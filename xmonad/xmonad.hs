import Control.Monad
import Data.Maybe
import Data.Bits ((.|.))
import qualified Data.List as List
import Data.Monoid
import Graphics.X11.Xlib
import Graphics.X11.Xlib.Extras
import System.Exit
import System.IO
import System.Taffybar.Hooks.PagerHints (pagerHints)
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn
import XMonad.Actions.SwapWorkspaces
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog (dzen)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Layout
import XMonad.Layout.Fullscreen hiding (fullscreenEventHook)
import XMonad.Layout.NoBorders
import XMonad.ManageHook
import XMonad.Operations
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.Scratchpad
import qualified Data.Map as M
import qualified XMonad.StackSet as W

main = do
  taffy <- spawnPipe "taffybar"
  spawn "xsetroot -cursor_name left_ptr"
  spawn "xsetroot -solid '#101010'"
  -- spawn "autocutsel -fork" -- need both, don't delete
  -- spawn "autocutsel -selection PRIMARY -fork"
  xmonad $ ewmh $ pagerHints $ withUrgencyHook NoUrgencyHook $ fullscreenSupport $ defaultConfig
    { manageHook  = myManageHook
    , layoutHook  = myLayoutHook
    , startupHook = setWMName "LG3D" >> addEWMHFullscreen
    , workspaces  = myWorkspaces
    , modMask     = mod4Mask
    , terminal    = myTerminal
    , handleEventHook = docksEventHook <+> handleEventHook defaultConfig <+> fullscreenEventHook
    } `additionalKeys` myKeys

myWorkspaces :: [WorkspaceId]
myWorkspaces = map show [1..9 :: Int]

myTerminal :: String
myTerminal = "konsole"

myLayoutHook =
  fullscreenFull
  $ lessBorders OnlyFloat
  $ avoidStruts
  $ layoutHook defaultConfig

myManageHook = composeAll
  [ (not <$> isDialog) --> insertPosition Below Newer
  , isFFDialog         --> doRectFloat (W.RationalRect 0.25 0.25 0.5 0.5)
  , isFullscreen       --> doFullFloat
  , manageSpawn
  , scratchpadManageHook (W.RationalRect 0 0.6 1 0.4)
  , manageDocks
  , fullscreenManageHook
  ]
  where
    isFFDialog = do
      d <- isDialog
      c <- className
      let isApp xs = or (flip List.isInfixOf c <$> xs)
      pure $ d && isApp ["Firefox", "Chromium"]

myKeys =
  [ ((mod4Mask,               xK_bracketleft  ), sendMessage Shrink) -- %! Shrink the master area
  , ((mod4Mask,               xK_bracketright ), sendMessage Expand) -- %! Shrink the master area
  , ((mod4Mask .|. shiftMask, xK_bracketleft  ), prevWS)
  , ((mod4Mask .|. shiftMask, xK_bracketright ), nextWS)
  , ((mod4Mask .|. shiftMask, xK_i            ), spawn "~/repos/my/scripts/internal.sh")
  , ((mod4Mask .|. shiftMask, xK_e            ), spawn "~/repos/my/scripts/external.sh")
  , ((mod4Mask .|. shiftMask, xK_y            ), io exitSuccess)
  , ((mod4Mask,               xK_y            ), spawn "pkill taffybar; xmonad --recompile && xmonad --restart")
  , ((mod4Mask .|. shiftMask, xK_q            ), io exitSuccess)
  , ((mod4Mask,               xK_q            ), spawn "pkill taffybar; xmonad --recompile && xmonad --restart")
  , ((mod4Mask,               xK_p            ), spawn "rofi -show run -matching fuzzy")
  , ((mod4Mask,               xK_w            ), spawn "rofi -show window -matching fuzzy")
  , ((mod4Mask,               xK_r            ), spawn "rofi -show drun -matching fuzzy")
  , ((mod4Mask,               xK_o            ), spawn "~/repos/my/scripts/pmenu")
  , ((mod4Mask,               xK_0            ), scratchpadSpawnActionTerminal myTerminal)
    -- media keys
  , ((0, 0x1008ff12                           ), spawn "amixer -q sset Master toggle") --f1
  , ((0, 0x1008ff11                           ), spawn "amixer -q sset Master 5%-") --f2
  , ((0, 0x1008ff13                           ), spawn "amixer -q sset Master 5%+") --f3
  , ((0, 0x1008ff03                           ), spawn "xbacklight -5") --f5
  , ((0, 0x1008ff02                           ), spawn "xbacklight +5") --f6
  , ((mod4Mask, 0xff61                        ), spawn "scrot") --prtsc
  ]
  ++
  [((mod4Mask .|. controlMask, k              ), windows $ swapWithCurrent i) | (i, k) <- zip myWorkspaces [xK_1 ..]]

-- GLFW
-- https://github.com/xmonad/xmonad-contrib/pull/109
-- https://github.com/xmonad/xmonad-contrib/issues/183
addNETSupported :: Atom -> X ()
addNETSupported x   = withDisplay $ \dpy -> do
  r               <- asks theRoot
  a_NET_SUPPORTED <- getAtom "_NET_SUPPORTED"
  a               <- getAtom "ATOM"
  liftIO $ do
    sup <- (join . maybeToList) <$> getWindowProperty32 dpy a_NET_SUPPORTED r
    when (fromIntegral x `notElem` sup) $
      changeProperty32 dpy r a_NET_SUPPORTED a propModeAppend [fromIntegral x]

addEWMHFullscreen :: X ()
addEWMHFullscreen   = do
  wms <- getAtom "_NET_WM_STATE"
  wfs <- getAtom "_NET_WM_STATE_FULLSCREEN"
  mapM_ addNETSupported [wms, wfs]
