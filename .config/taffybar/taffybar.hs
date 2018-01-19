{-# LANGUAGE MultiWayIf #-}
import Control.Monad (join)
import Data.List (intercalate)
import Data.Maybe (fromMaybe)
import Data.Monoid ((<>))
import Graphics.UI.Gtk
import Graphics.UI.Gtk.Abstract.Widget
import System.Information.CPU
import System.Information.Memory
import System.Taffybar
import System.Taffybar.Battery
import System.Taffybar.FreedesktopNotifications
import System.Taffybar.MPRIS
import System.Taffybar.NetMonitor
import System.Taffybar.Pager
import System.Taffybar.SimpleClock
import System.Taffybar.Systray
import System.Taffybar.TaffyPager
import System.Taffybar.Weather
import System.Taffybar.Widgets.PollingBar
import System.Taffybar.Widgets.PollingGraph
import System.Taffybar.Widgets.PollingLabel
import System.Taffybar.Widgets.VerticalBar
import System.Information.Battery
import System.Process (readProcess)
import Text.Printf (printf)
import Control.Monad.Trans.Maybe (MaybeT(..))

main :: IO ()
main = do
  defaultTaffybar defaultTaffybarConfig
    { startWidgets = [ pager ]
    , endWidgets   = [ clock, battery, mem, cpu, network2, network1, wifi ]
    }

pager :: IO Widget
pager = taffyPagerNew PagerConfig
  { activeWindow     = shorten 40 . nodots .escape
  , activeLayout     = escape
  , activeWorkspace  = colorize "" "#006788" . pad . escape
  , hiddenWorkspace  = noScratchPad . escape
  , emptyWorkspace   = colorize "grey" "" . noScratchPad . escape
  , visibleWorkspace = escape
  , urgentWorkspace  = escape
  , widgetSep        = "  "
  }
  where
    pad = wrap " " " "
    noScratchPad ws = if ws == "NSP" then "" else pad ws
    nodots ws = if ws == "..." then "" else ws

wifi :: IO Widget
wifi =
  let
    f = flip fmap (readProcess "nmcli" ["device"] "") $ \s ->
      case join . join $ conn <$> (words <$> (lines s)) of
        [] -> colorize "#aaaaaa" "" "\61931 No Connection"
        x  -> "\61931 " ++ (intercalate " " x)

    conn x = case x of
      device:typ:"connected":connection -> [connection]
      _ -> []
  in
    pollingLabelNew "\61931 No Connection" 10 f >>= \x ->
    widgetShowAll x >>
    pure x

-- no idea why the f the name changes...
network1 :: IO Widget
network1 = netMonitorNewWith 1 "wlp4s0" 2 "▼ $inKB$kb/s ▲ $outKB$kb/s"

network2 :: IO Widget
network2 = netMonitorNewWith 1 "wlan0" 2 "▼ $inKB$kb/s ▲ $outKB$kb/s"


cpu :: IO Widget
cpu = pollingGraphNew defaultGraphConfig
  { graphDataColors = [ (1, 0, 0, 1) ]
  , graphLabel = Nothing
  , graphDirection = RIGHT_TO_LEFT
  } 1 callback
  where
    callback = (\(userLoad, sysLoad, totalLoad) -> [totalLoad]) <$> cpuLoad

mem :: IO Widget
mem = pollingGraphNew defaultGraphConfig
  { graphDataColors = [ (1, 0, 0, 1) ]
  , graphLabel = Nothing
  , graphDirection = RIGHT_TO_LEFT
  } 1 callback
  where
    callback = (:[]) . memoryUsedRatio <$> parseMeminfo

batteryBar :: IO Widget
batteryBar = batteryBarNew BarConfig
  { barBorderColor = (0.5, 0.5, 0.5)
  , barBackgroundColor = const (0, 0, 0)
  , barColor = const (1, 1, 1)
  , barPadding = 2
  , barWidth = 15
  , barDirection = VERTICAL
  } 1

volume :: IO Widget
volume = do
  l <- labelNew (pure "\61480")
  labelSetMarkup l "\61480"
  widgetShowAll $ toWidget l
  -- on l realize $ pure ()
  pure $ toWidget l

battery :: IO Widget
battery =
  let f ctxm = fmap (maybe "\62010 --%" id) $ runMaybeT $ do
        ctx <- MaybeT $ pure ctxm
        inf <- MaybeT $ getBatteryInfo ctx
        let icon = case batteryState inf of
              BatteryStateCharging     -> "\62016"
              BatteryStateFullyCharged -> "\62016"
              _ -> if | batteryPercentage inf > 75 -> "\62017"
                      | batteryPercentage inf > 50 -> "\62018"
                      | batteryPercentage inf > 25 -> "\62019"
                      | otherwise -> "\62020"
        let txt = show (truncate $ batteryPercentage inf) <> "%"
        pure $ icon <> " " <> txt
  in
    batteryContextNew >>= \ctx ->
    pollingLabelNew "\62010 --%" 10 (f ctx) >>= \x ->
    widgetShowAll x >>
    pure x

batteryText :: IO Widget
batteryText = textBatteryNew "\62016 $percentage$%" 1

clock :: IO Widget
clock = textClockNew Nothing "%Y-%m-%d %H:%M " 1
