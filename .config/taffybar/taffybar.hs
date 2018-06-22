import Control.Monad (join)
import Control.Monad.IO.Class (MonadIO(..))
import Data.Maybe (fromMaybe)
import Data.Monoid ((<>))
import System.Process (readCreateProcess, shell)
import System.Taffybar
import System.Taffybar.Context (TaffyIO)
import System.Taffybar.Hooks
import System.Taffybar.Information.CPU
import System.Taffybar.Information.Memory
import System.Taffybar.SimpleConfig
import System.Taffybar.Widget
import System.Taffybar.Widget.Generic.PollingGraph
import System.Taffybar.Widget.Generic.PollingLabel
import System.Taffybar.Widget.Util
import System.Taffybar.Widget.Workspaces
import qualified Data.List as List
import qualified Data.List.Split as List
import qualified Graphics.UI.Gtk as Gtk

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
        , networkMonitorNew defaultNetFormat (Just ["wlp4s0"])
        , pollingLabelNew "\61931 No Connection" 10 wifiCallback
        ]
      , barPosition = Top
      , barPadding = 0
      , barHeight = 30
      , widgetSpacing = 0
      }
  in
    dyreTaffybar $ withBatteryRefresh $ withLogServer $ withToggleServer $ toTaffyConfig myConfig

transparent = (0.0, 0.0, 0.0, 0.0)
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

cpuCallback :: IO [Double]
cpuCallback = do
  (_, systemLoad, totalLoad) <- cpuLoad
  return [totalLoad, systemLoad]

wifiCallback :: IO String
wifiCallback = do
  out <- readCreateProcess (shell "nmcli -t dev wifi | grep '*'") ""
  let ssid = case List.splitOn ":" out of
        "*":ssid:_-> ssid
        _ -> "No Connection"
  pure $ "\61931" <> " " <> ssid
