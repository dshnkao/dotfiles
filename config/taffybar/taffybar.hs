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
import System.Process (readProcess)
import Text.Printf (printf)

main :: IO ()
main = do
  defaultTaffybar defaultTaffybarConfig
    { startWidgets = [ pager ]
    , endWidgets   = [ clock, textBattery, mem, cpu, network, wifi ]
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
      maybe (colorize "#aaaaaa" "" "\61931 No Connection") id $
      case drop 1 (lines s) of
        []   -> Nothing
        x:xs -> case words x of
          device:typ:state:connection:[] -> if state /= "connected"
            then Nothing
            else pure $ "\61931 " ++ connection
          _ -> Nothing
  in do
    label <- pollingLabelNew "\61931 No Connection" 1 f
    widgetShowAll label
    return label

network :: IO Widget
network = netMonitorNewWith 1 "wlp4s0" 2 "▼ $inKB$kb/s ▲ $outKB$kb/s"

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

battery :: IO Widget
battery = batteryBarNew BarConfig
  { barBorderColor = (0.5, 0.5, 0.5)
  , barBackgroundColor = const (0, 0, 0)
  , barColor = const (1, 1, 1)
  , barPadding = 2
  , barWidth = 15
  , barDirection = VERTICAL
  } 1

textBattery :: IO Widget
textBattery = textBatteryNew "\62016 $percentage$%" 1

clock :: IO Widget
clock = textClockNew Nothing "%Y-%m-%d %H:%M " 1
