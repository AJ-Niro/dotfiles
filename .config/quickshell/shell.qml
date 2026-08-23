import Quickshell
import "./config"
import "./components"
import "./widgets"

Scope {
  Bar {
    id: bar
  }
  BrightnessOSD {
    anchorWindow: bar
    fontFamily: Theme.fontFamily
    fontSize: Theme.fontSize
  }
  VolumeOSD {
    anchorWindow: bar
    fontFamily: Theme.fontFamily
    fontSize: Theme.fontSize
  }
}
