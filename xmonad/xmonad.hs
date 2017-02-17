import XMonad
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops 
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
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
  d      <- spawnPipe "dzen2 -h 30 -fn Ubuntu:size=11 -dock"
  guake  <- spawnPipe "/usr/bin/guake"
  emacs  <- spawnPipe "/usr/bin/emacs25 --daemon"
  -- spawn $ "conky -c ~/.xmonad/data/conky/dzen | " ++ "dzen2 -p -xs 2 ta -r -e 'onstart=lower'"
  xmonad $ desktopConfig
    { manageHook  = manageDocks <+> myManageHook
    , layoutHook  = myLayoutHook
    , logHook     = myLogHook d
    , startupHook = setWMName "LG3D"
    , modMask     = mod4Mask
    , terminal    = "terminator"
    , handleEventHook = docksEventHook <+> handleEventHook defaultConfig 
    } `additionalKeys` myKeys

myLogHook h = dynamicLogWithPP $ defaultPP
    -- display current workspace as darkgrey on light grey (opposite of 
    -- default colors)
    { ppCurrent         = dzenColor "#303030" "#909090" . pad 
    -- display other workspaces which contain windows as a brighter grey
    , ppHidden          = dzenColor "#909090" "" . pad 
    -- display other workspaces with no windows as a normal grey
    , ppHiddenNoWindows = dzenColor "#606060" "" . pad 
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

-- add avoidStruts to your layoutHook like so
myLayoutHook = avoidStruts $ layoutHook defaultConfig
-- add manageDocks to your managehook like so
myManageHook = manageDocks <+> manageHook defaultConfig

myKeys = [ ((mod4Mask,               xK_bracketleft     ), sendMessage Shrink) -- %! Shrink the master area
         , ((mod4Mask,               xK_bracketright    ), sendMessage Expand) -- %! Shrink the master area
         -- quit, or restart
         , ((mod4Mask .|. shiftMask, xK_y     ), io (exitWith ExitSuccess)) -- %! Quit xmonad
         -- %! Restart xmonad
         , ((mod4Mask              , xK_y     ), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") 
         , ((mod4Mask,               xK_p     ), spawn "rofi -show run")
         ]
