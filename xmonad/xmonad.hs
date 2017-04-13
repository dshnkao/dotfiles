import XMonad
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops 
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Scratchpad 
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog (dzen)
import XMonad.Hooks.UrgencyHook
import Data.List
import System.IO

import XMonad.Layout
import XMonad.Operations
import XMonad.ManageHook
import qualified XMonad.StackSet as W
import Data.Bits ((.|.))
import Data.Monoid
import qualified Data.Map as M
import System.Exit
import Graphics.X11.Xlib
import Graphics.X11.Xlib.Extras

main = do
  d <- spawnPipe "dzen2 -ta l -h 30 -w 1000 -fn Ubuntu:size=11 -dock"
  spawn $ "conky -c ~/.xmonad/data/conky/dzen | " ++ "dzen2 -ta r -x 1000 -h 30 -fn Ubuntu:size=11"
  spawn "/usr/bin/emacs25 --daemon"
  spawn "/usr/bin/autocutsel -fork"
  spawn "/usr/bin/autocutsel -selection PRIMARY -fork"

  --xmonad $ desktopConfig
  xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig
    { manageHook  = myManageHook 
    , layoutHook  = myLayoutHook
    , logHook     = myLogHook d
    , startupHook = setWMName "LG3D"
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
myManageHook = manageScratchPad <+> manageDocks <+> manageHook defaultConfig

manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)
  where
    h = 0.3     -- terminal height, 10%
    w = 1       -- terminal width, 100%
    t = 1 - h   -- distance from top edge, 90%
    l = 1 - w   -- distance from left edge, 0%

myKeys = [ ((mod4Mask,               xK_bracketleft     ), sendMessage Shrink) -- %! Shrink the master area
         , ((mod4Mask,               xK_bracketright    ), sendMessage Expand) -- %! Shrink the master area
         , ((mod4Mask .|. shiftMask, xK_y     ), io (exitWith ExitSuccess)) -- %! Quit xmonad
         , ((mod4Mask              , xK_y     ), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") 
         , ((mod4Mask,               xK_p     ), spawn "rofi -show run")
         , ((mod4Mask              , xK_0     ), scratchpadSpawnActionTerminal "urxvt")
         ]
