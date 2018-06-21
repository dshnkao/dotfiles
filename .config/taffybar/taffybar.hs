{-# LANGUAGE MultiWayIf #-}
--import Control.Monad (join)
--import Data.List (intercalate)
--import Data.Maybe (fromMaybe)
--import Data.Monoid ((<>))
--import Graphics.UI.Gtk
--import Graphics.UI.Gtk.Abstract.Widget
--import System.Taffybar.Information.CPU
--import System.Taffybar.Information.Memory
--import System.Taffybar
--import System.Taffybar.Battery
--import System.Taffybar.FreedesktopNotifications
--import System.Taffybar.MPRIS
--import System.Taffybar.NetMonitor
--import System.Taffybar.Pager
--import System.Taffybar.Widget.SimpleClock
--import System.Taffybar.Systray
--import System.Taffybar.TaffyPager
--import System.Taffybar.Widget.Generic.PollingBar
--import System.Taffybar.Widget.Generic.PollingGraph
--import System.Taffybar.Widget.Generic.PollingLabel
--import System.Taffybar.Widget.Generic.VerticalBar
--import System.Taffybar.Information.Battery
--import System.Process (readProcess)
--import Text.Printf (printf)
--import Control.Monad.Trans.Maybe (MaybeT(..))

import System.Taffybar
import System.Taffybar.Hooks
import System.Taffybar.Information.CPU
import System.Taffybar.Information.Memory
import System.Taffybar.SimpleConfig
import System.Taffybar.Widget
import System.Taffybar.Widget.Generic.PollingGraph
import System.Taffybar.Widget.Generic.PollingLabel
import System.Taffybar.Widget.Util
import System.Taffybar.Widget.Workspaces

main :: IO ()
main =
  let
    layout = layoutNew defaultLayoutConfig
    windows = windowsNew defaultWindowsConfig
    workspaces = workspacesNew workspacesCfg
    myConfig = defaultSimpleTaffyConfig
      { startWidgets = workspaces : map (>>= buildContentsBox) [ layout, windows ]
      , endWidgets = map (>>= buildContentsBox)
        [ textClockNew Nothing "%Y-%m-%d %H:%M " 1
        , textBatteryNew "$percentage$% \62016"
        , pollingGraphNew memCfg 1 memCallback
        , pollingGraphNew cpuCfg 0.5 cpuCallback
        , networkGraphNew netCfg Nothing
        ]
      , barPosition = Top
      , barPadding = 0
      , barHeight = 30
      , widgetSpacing = 0
      }
  in
    dyreTaffybar $ withBatteryRefresh $ withLogServer $ withToggleServer $ toTaffyConfig myConfig

transparent = (0.0, 0.0, 0.0, 0.0)
yellow1 = (0.9453125, 0.63671875, 0.2109375, 1.0)
yellow2 = (0.9921875, 0.796875, 0.32421875, 1.0)
green1 = (0, 1, 0, 1)
green2 = (1, 0, 1, 0.5)
taffyBlue = (0.129, 0.588, 0.953, 1)

workspacesCfg = defaultWorkspacesConfig
  { widgetGap = 0
  , minWSWidgetSize = Nothing
  , underlinePadding = 0
  , maxIcons = Just 0
  , minIcons = 0
  , showWorkspaceFn = (/= "NSP") . workspaceName
  }

myGraphConfig = defaultGraphConfig
  { graphPadding = 2
  , graphBorderWidth = 1
  , graphWidth = 60
  , graphBackgroundColor = transparent
  , graphDirection = RIGHT_TO_LEFT
  }

netCfg = myGraphConfig
  { graphDataColors = [yellow1, yellow2]
  , graphLabel = Nothing
  }

memCfg = myGraphConfig
  { graphDataColors = [taffyBlue]
  , graphLabel = Nothing
  }

cpuCfg = myGraphConfig
  { graphDataColors = [green1, green2]
  , graphLabel = Nothing
  }

memCallback :: IO [Double]
memCallback = do
  mi <- parseMeminfo
  return [memoryUsedRatio mi]

cpuCallback = do
  (_, systemLoad, totalLoad) <- cpuLoad
  return [totalLoad, systemLoad]
--
--wifi :: IO Widget
--wifi =
--  let
--    f = flip fmap (readProcess "nmcli" ["device"] "") $ \s ->
--      case join . join $ conn <$> (words <$> (lines s)) of
--        [] -> colorize "#aaaaaa" "" "\61931 No Connection"
--        x  -> "\61931 " ++ (intercalate " " x)
--
--    conn x = case x of
--      device:typ:"connected":connection -> [connection]
--      _ -> []
--  in
--    pollingLabelNew "\61931 No Connection" 10 f >>= \x ->
--    widgetShowAll x >>
--    pure x
--
---- no idea why the f the name changes...
--network1 :: IO Widget
--network1 = netMonitorNewWith 1 "wlp4s0" 2 "▼ $inKB$kb/s ▲ $outKB$kb/s"
--
--network2 :: IO Widget
--network2 = netMonitorNewWith 1 "wlan0" 2 "▼ $inKB$kb/s ▲ $outKB$kb/s"

--battery :: IO Widget
--battery =
--  let f ctxm = fmap (maybe "\62010 --%" id) $ runMaybeT $ do
--        ctx <- MaybeT $ pure ctxm
--        inf <- MaybeT $ getBatteryInfo ctx
--        let icon = case batteryState inf of
--              BatteryStateCharging     -> "\62016"
--              BatteryStateFullyCharged -> "\62016"
--              _ -> if | batteryPercentage inf > 75 -> "\62017"
--                      | batteryPercentage inf > 50 -> "\62018"
--                      | batteryPercentage inf > 25 -> "\62019"
--                      | otherwise -> "\62020"
--        let txt = show (truncate $ batteryPercentage inf) <> "%"
--        pure $ icon <> " " <> txt
--  in
--    batteryContextNew >>= \ctx ->
--    pollingLabelNew "\62010 --%" 10 (f ctx) >>= \x ->
--    widgetShowAll x >>
--    pure x
--
--batteryText :: IO Widget
--batteryText = textBatteryNew "\62016 $percentage$%" 1
