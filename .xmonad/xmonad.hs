{-# LANGUAGE LambdaCase #-}

import           Control.Applicative ((<|>))
import           Control.Exception (catch, SomeException)
import           Control.Monad (join, when, msum)
import           Data.Bits ((.|.))
import           Data.Maybe (maybeToList, fromMaybe, isJust)
import           Data.Monoid ((<>))
import           GHC.IO.Handle (Handle)
import           System.Directory (findExecutable)
import           System.Exit (exitSuccess)
-- import           System.Taffybar.Support.PagerHints (pagerHints)
import           XMonad
import           XMonad.Actions.CycleWS (prevWS, nextWS, moveTo, Direction1D(..), WSType(..))
import           XMonad.Actions.SpawnOn (manageSpawn, spawnOn)
import           XMonad.Actions.SwapWorkspaces (swapWithCurrent)
import           XMonad.Config (def)
import           XMonad.Hooks.EwmhDesktops (fullscreenEventHook, ewmh, ewmhDesktopsEventHook)
import           XMonad.Hooks.InsertPosition (Position(..), Focus(..), insertPosition)
import           XMonad.Hooks.ManageDocks (docks, docksEventHook, avoidStruts, manageDocks)
import           XMonad.Hooks.ManageHelpers (isDialog, doRectFloat, isFullscreen, doFullFloat)
import           XMonad.Hooks.SetWMName (setWMName)
import           XMonad.Hooks.UrgencyHook (withUrgencyHook, NoUrgencyHook(..))
import           XMonad.Layout.NoBorders (lessBorders, Ambiguity(..))
import           XMonad.Util.EZConfig (additionalKeys)
import           XMonad.Util.Run (safeSpawn, safeSpawnProg, spawnPipe, runProcessWithInput, hPutStrLn)
import           XMonad.Util.Scratchpad (scratchpadManageHook, scratchpadSpawnActionTerminal)
import qualified Codec.Binary.UTF8.String as UTF8
import qualified DBus as D
import qualified DBus.Client as D
import qualified Data.List as List
import qualified XMonad.Hooks.DynamicLog as DL
import qualified XMonad.Layout.Fullscreen as LF
import qualified XMonad.StackSet as W

main = do
  myTerm <- myTerminal
  myLogHook <- spawnBar
  -- set cursor
  spawn "xsetroot -cursor_name left_ptr"
  spawn "xsetroot -solid '#101010'"
  -- unify clipboard, need both
  -- spawn "autocutsel -fork"
  -- spawn "autocutsel -selection PRIMARY -fork"
  -- xmonad $ ewmh $ docks $ pagerHints $ def
  xmonad $ ewmh $ docks $ def
    { manageHook  = myManageHook
    , layoutHook  = myLayoutHook
    , startupHook = setWMName "LG3D" >> addEWMHFullscreen
    , workspaces  = myWorkspaces
    , modMask     = mod4Mask
    , terminal    = myTerm
    , logHook     = myLogHook
    , handleEventHook = handleEventHook def <+> fullscreenEventHook
    } `additionalKeys` (myKeys myTerm)

myWorkspaces :: [WorkspaceId]
myWorkspaces = map show [1..9 :: Int]

myTerminal :: IO String
myTerminal =
  fromMaybe "xterm" . msum <$> (mapM findExecutable terminals)
  where
    terminals = [ "konsole" , "urxvt" , "terminator" , "tilix"]

myLayoutHook = lessBorders OnlyScreenFloat $ avoidStruts $ layoutHook def

myManageHook :: ManageHook
myManageHook = composeAll
  [ (not <$> (isDialog <||> appName =? "pinentry")) --> insertPosition Below Newer
  , isAppDialog              --> doRectFloat (W.RationalRect 0.25 0.25 0.5 0.5)
  , appName =? "pavucontrol" --> doRectFloat (W.RationalRect 0.25 0.25 0.5 0.5)
  , className =? "ktorrent"  --> doShift "9"
  , isFullscreen             --> doFullFloat
  , manageSpawn
  , scratchpadManageHook (W.RationalRect 0 0.6 1 0.4)
  ]
  where
    xs = ["Firefox", "Chromium"]
    isAppDialog = isDialog <&&> fmap or (traverse (className =?) xs)

myKeys :: String -> [((KeyMask, KeySym), X ())]
myKeys myTerm =
  [ ((mod4Mask,                 xK_bracketleft  ), sendMessage Shrink) -- %! Shrink the master area
  , ((mod4Mask,                 xK_bracketright ), sendMessage Expand) -- %! Shrink the master area
  , ((mod4Mask .|. shiftMask,   xK_bracketleft  ), moveTo Prev (WSIs (pure notNSP)))
  , ((mod4Mask .|. shiftMask,   xK_bracketright ), moveTo Next (WSIs (pure notNSP)))
  , ((mod4Mask,                 xK_minus        ), moveTo Prev (WSIs (pure notNSP)))
  , ((mod4Mask,                 xK_equal        ), moveTo Next (WSIs (pure notNSP)))
  , ((mod4Mask .|. shiftMask,   xK_i            ), spawn "carbon-edp.sh")
  , ((mod4Mask .|. shiftMask,   xK_e            ), spawn "carbon-hdmi.sh")
  , ((mod4Mask .|. shiftMask,   xK_y            ), io exitSuccess)
  , ((mod4Mask,                 xK_y            ), spawn $ killBar <> restartXMonad)
  , ((mod4Mask .|. controlMask, xK_q            ), spawn "slock")
  , ((mod4Mask .|. shiftMask,   xK_q            ), io exitSuccess)
  , ((mod4Mask,                 xK_q            ), spawn $ killBar <> restartXMonad)
  , ((mod4Mask,                 xK_u            ), spawn firefox)
  , ((mod4Mask,                 xK_p            ), spawn "rofi -show run -matching fuzzy")
  , ((mod4Mask,                 xK_w            ), spawn "rofi -show window -matching fuzzy")
  , ((mod4Mask,                 xK_r            ), spawn "rofi -show drun -matching fuzzy")
  , ((mod4Mask,                 xK_i            ), spawn "rofi-books.sh")
  , ((mod4Mask,                 xK_o            ), spawn "rofi-password-store.sh")
  , ((mod4Mask,                 xK_s            ), spawn "pavucontrol")
  , ((mod4Mask,                 xK_0            ), scratchpadSpawnActionTerminal myTerm)
  , ((0, 0x1008ff12                             ), spawn "amixer -q sset Master toggle") --f1
  , ((0, 0x1008ff11                             ), spawn "amixer -q sset Master 5%-") --f2
  , ((0, 0x1008ff13                             ), spawn "amixer -q sset Master 5%+") --f3
  , ((0, 0x1008ffb2                             ), spawn "amixer -c 0 set Master playback 100% unmute") --f4
  , ((0, 0x1008ff03                             ), spawn "xbacklight -5") --f5
  , ((0, 0x1008ff02                             ), spawn "xbacklight +5") --f6
  , ((mod4Mask, 0xff61                          ), spawn "scrot") --prtsc
  ]
  ++
  [((mod4Mask .|. controlMask, k), windows $ swapWithCurrent i) | (i, k) <- zip myWorkspaces [xK_1 ..]]
  where
    notNSP (W.Workspace wId _ _) = wId /= "NSP"
    firefox = unwords
      [ "firefox-open.sh"
      , "~/.mozilla/firefox/bl0ar52g.default-1507385104150/places.sqlite"
      , "\"rofi -dmenu -i -p url --no-sort\""
      ]
    restartXMonad = "xmonad --recompile && xmonad --restart"
    killBar = case myBar of
      Dzen     -> "pkill conky; pkill dzen2;"
      PolyBar  -> "pkill polybar;"
      TaffyBar -> "pkill taffybar;"

data MyBar = TaffyBar | Dzen | PolyBar

myBar :: MyBar
myBar = PolyBar

spawnBar :: IO (X ())
spawnBar = case myBar of
  Dzen -> do
    leftBar <- spawnPipe "dzen2 -ta l -h 30 -w 960 -fn Ubuntu:size=11 -dock"
    spawn $ "conky -c ~/.xmonad/conky.conf | dzen2 -ta r -x 960 -h 30 -fn Ubuntu:size=11"
    pure $ dzenLogHook leftBar
  TaffyBar ->
    fmap pure $ spawn "taffybar"
  PolyBar -> do
    spawn "polybar top"
    dbus <- D.connectSession
    D.requestName dbus (D.busName_ "org.xmonad.Log") [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]
    pure $ polybarLogHook dbus

dzenLogHook :: Handle -> X ()
dzenLogHook h = DL.dynamicLogWithPP $ def
  { DL.ppCurrent         = DL.dzenColor "#cccccc" "#006788" . DL.pad
  , DL.ppHidden          = DL.dzenColor "#cccccc" "" . DL.pad . noScratchPad
  , DL.ppHiddenNoWindows = DL.dzenColor "#606060" "" . DL.pad . noScratchPad
  , DL.ppLayout          = DL.dzenColor "#909090" "" . DL.pad
  , DL.ppUrgent          = DL.dzenColor "#ff0000" "" . DL.pad . DL.dzenStrip
  , DL.ppTitle           = DL.shorten 50
  , DL.ppWsSep           = ""
  , DL.ppSep             = "  "
  , DL.ppOutput          = hPutStrLn h
  }
  where
    noScratchPad ws = if ws == "NSP" then "" else ws

-- dbus
-- Override the PP values as you would otherwise, adding colors etc depending
-- on  the statusbar used
polybarLogHook :: D.Client -> X ()
polybarLogHook dbus = DL.dynamicLogWithPP $ def
  { DL.ppCurrent         = polyColor "#cccccc" "#006788" . DL.pad
  , DL.ppHidden          = polyColor "#cccccc" "" . DL.pad . noScratchPad
  , DL.ppHiddenNoWindows = polyColor "#808080" "" . DL.pad . noScratchPad
  , DL.ppLayout          = polyColor "#A0A0A0" "" . DL.pad
  , DL.ppUrgent          = polyColor "#ff0000" "" . DL.pad . DL.dzenStrip
  , DL.ppTitle           = DL.shorten 50
  , DL.ppWsSep           = ""
  , DL.ppSep             = "  "
  , DL.ppOutput = dbusOutput dbus
  }
  where
    polyColor fg bg s = "%{B" <> bg <> " F" <> fg <> "}" <> s <> "%{B- F-}"
    noScratchPad ws = if ws == "NSP" then "" else ws

-- Emit a DBus signal on log updates
dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str = do
  let signal =
        (D.signal objectPath interfaceName memberName)
        {D.signalBody = [D.toVariant $ UTF8.decodeString str]}
  D.emit dbus signal
  where
    objectPath = D.objectPath_ "/org/xmonad/Log"
    interfaceName = D.interfaceName_ "org.xmonad.Log"
    memberName = D.memberName_ "Update"

-- GLFW
-- https://github.com/xmonad/xmonad-contrib/pull/109
-- https://github.com/xmonad/xmonad-contrib/issues/183
addNETSupported :: Atom -> X ()
addNETSupported x = withDisplay $ \dpy -> do
  r               <- asks theRoot
  a_NET_SUPPORTED <- getAtom "_NET_SUPPORTED"
  a               <- getAtom "ATOM"
  liftIO $ do
    sup <- (join . maybeToList) <$> getWindowProperty32 dpy a_NET_SUPPORTED r
    when (fromIntegral x `notElem` sup) $
      changeProperty32 dpy r a_NET_SUPPORTED a propModeAppend [fromIntegral x]

addEWMHFullscreen :: X ()
addEWMHFullscreen = do
  wms <- getAtom "_NET_WM_STATE"
  wfs <- getAtom "_NET_WM_STATE_FULLSCREEN"
  mapM_ addNETSupported [wms, wfs]
