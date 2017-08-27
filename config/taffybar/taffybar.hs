import Graphics.UI.Gtk.Abstract.Widget
import System.Information.CPU
import System.Information.Memory
import System.Taffybar
import System.Taffybar.Battery
import System.Taffybar.FreedesktopNotifications
import System.Taffybar.MPRIS
import System.Taffybar.Pager
import System.Taffybar.SimpleClock
import System.Taffybar.Systray
import System.Taffybar.TaffyPager
import System.Taffybar.Weather
import System.Taffybar.Widgets.PollingBar
import System.Taffybar.Widgets.PollingGraph
import System.Taffybar.Widgets.VerticalBar
import Text.Printf (printf)
memCallback = do
  mi <- parseMeminfo
  return [memoryUsedRatio mi]

cpuCallback = do
  (userLoad, systemLoad, totalLoad) <- cpuLoad
  return [totalLoad, systemLoad]

main = do
  let memCfg = defaultGraphConfig { graphDataColors = [(1, 0, 0, 1)]
                                  , graphLabel = Nothing
                                  }
      cpuCfg = defaultGraphConfig { graphDataColors = [ (0, 1, 0, 1)
                                                      , (1, 0, 1, 0.5)
                                                      ]
                                  , graphLabel = Nothing
                                  }
      mem   = pollingGraphNew memCfg 1 memCallback
      cpu   = pollingGraphNew cpuCfg 0.5 cpuCallback
  defaultTaffybar defaultTaffybarConfig
    { startWidgets = [ pager ]
    , endWidgets   = [ clock, textBattery, mem, cpu ]
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
