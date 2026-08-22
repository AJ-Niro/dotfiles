import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../config"
import "../components"

PanelWindow {
  implicitHeight: Config.bar.height
    color: Theme.background

    anchors.top: true
    anchors.left: true
    anchors.right: true

    RowLayout {
        anchors.fill: parent

        Item { Layout.fillWidth: true }

        WorkspaceWindows {
          fontFamily: Theme.fontFamily
        }

        Workspaces { fontFamily: Theme.fontFamily }

        Item { Layout.fillWidth: true }

        Battery {
          fontFamily: Theme.fontFamily
          fontSize: Theme.fontSize
          iconSize: Theme.fontSize + 2
        }

        DateTime {
          fontFamily: Theme.fontFamily
        }


    }
}
