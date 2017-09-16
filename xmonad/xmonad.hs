import Data.Bits ((.|.))
import Data.List
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
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.DynamicLog (dzen)
import XMonad.Hooks.EwmhDesktops 
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Layout
import XMonad.ManageHook
import XMonad.Operations
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.Scratchpad 
import qualified Data.Map as M
import qualified XMonad.StackSet as W

myWorkspaces :: [WorkspaceId]
myWorkspaces = map show [1..9 :: Int]

main = do
  -- leftBar <- spawnPipe "dzen2 -ta l -h 30 -w 960 -fn Ubuntu:size=11 -dock"
  -- spawn $ "conky -c ~/.xmonad/data/conky/dzen | " ++ "dzen2 -ta r -x 960 -h 30 -fn Ubuntu:size=11"
  taffy <- spawnPipe "taffybar"
  spawn "xsetroot -cursor_name left_ptr"
  spawn "autocutsel -fork" -- need both, don't delete
  spawn "autocutsel -selection PRIMARY -fork"

  --xmonad $ desktopConfig
  xmonad $ ewmh $ pagerHints $ withUrgencyHook NoUrgencyHook $ defaultConfig
    { manageHook  = myManageHook
    , layoutHook  = myLayoutHook
    --, logHook     = myLogHook leftBar
    , startupHook = setWMName "LG3D"
    , workspaces  = myWorkspaces
    , modMask     = mod4Mask
    , terminal    = "urxvt"
    , handleEventHook = docksEventHook <+> handleEventHook defaultConfig 
    } `additionalKeys` myKeys

myLogHook h = dynamicLogWithPP $ defaultPP
    -- display current workspace as darkgrey on light grey (opposite of 
    -- default colors)
    { ppCurrent         = dzenColor "#303030" "#909090" . pad 
    -- display other workspaces which contain windows as a brighter grey
    , ppHidden          = dzenColor "#909090" "" . pad . noScratchPad
    --, ppHidden          = dzenColor "#ffffff" "" . pad . noScratchPad
    -- display other workspaces with no windows as a normal grey
    , ppHiddenNoWindows = dzenColor "#606060" "" . pad . noScratchPad
    -- display the current layout as a brighter grey
    , ppLayout          = dzenColor "#909090" "" . pad 
    -- if a window on a hidden workspace needs my attention, color it so
    , ppUrgent          = dzenColor "#ff0000" "" . pad . dzenStrip
    -- shorten if it goes over 100 characters
    , ppTitle           = shorten 100
    -- no separator between workspaces
    , ppWsSep           = ""
    -- put a few spaces between each object
    , ppSep             = "  "
    -- output to the handle we were given as an argument
    , ppOutput          = hPutStrLn h
    }
    where
      noScratchPad ws = if ws == "NSP" then "" else ws

-- add avoidStruts to your layoutHook like so
myLayoutHook = avoidStruts $ layoutHook defaultConfig
-- add manageDocks to your managehook like so
myManageHook = manageSpawn 
    <+> manageScratchPad 
    <+> manageDocks 
    <+> insertPosition Below Newer 
    <+> manageHook defaultConfig

manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)
  where
    h = 0.4     -- terminal height
    w = 1       -- terminal width
    t = 1 - h   -- distance from top edge
    l = 1 - w   -- distance from left edge

myKeys = [ ((mod4Mask,                 xK_bracketleft  ), sendMessage Shrink) -- %! Shrink the master area
         , ((mod4Mask,                 xK_bracketright ), sendMessage Expand) -- %! Shrink the master area
         , ((mod4Mask .|. shiftMask,   xK_bracketleft  ), prevWS)
         , ((mod4Mask .|. shiftMask,   xK_bracketright ), nextWS)
         , ((mod4Mask .|. shiftMask,   xK_i            ), spawn "~/repos/my/scripts/internal.sh")
         , ((mod4Mask .|. shiftMask,   xK_e            ), spawn "~/repos/my/scripts/external.sh")
         , ((mod4Mask .|. shiftMask,   xK_y            ), io (exitWith ExitSuccess))
         , ((mod4Mask,                 xK_y            ), spawn "pkill taffybar; xmonad --recompile && xmonad --restart") 
         , ((mod4Mask .|. shiftMask,   xK_q            ), io (exitWith ExitSuccess))
         , ((mod4Mask,                 xK_q            ), spawn "pkill taffybar; xmonad --recompile && xmonad --restart")
         , ((mod4Mask,                 xK_p            ), spawn "rofi -show run")
         , ((mod4Mask,                 xK_w            ), spawn "rofi -show window")
         , ((mod4Mask,                 xK_r            ), spawn "rofi -show drun")
         , ((mod4Mask,                 xK_0            ), scratchpadSpawnActionTerminal "urxvt")
         -- media keys
         , ((0, 0x1008ff12                             ), spawn "amixer -q sset Master toggle") --f1
         , ((0, 0x1008ff11                             ), spawn "amixer -q sset Master 5%-") --f2
         , ((0, 0x1008ff13                             ), spawn "amixer -q sset Master 5%+") --f3
         , ((0, 0x1008ff03                             ), spawn "xbacklight -5") --f5
         , ((0, 0x1008ff02                             ), spawn "xbacklight +5") --f6
         ]
         ++
         [((mod4Mask .|. controlMask,  k               ), windows $ swapWithCurrent i) | (i, k) <- zip myWorkspaces [xK_1 ..]]


