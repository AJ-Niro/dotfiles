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

  property int horizontalPadding: 12
  property int sectionsSpacing: 12

  Item {
      anchors.fill: parent
      anchors.leftMargin: horizontalPadding
      anchors.rightMargin: horizontalPadding

      // --- Left section ---
      RowLayout {
          id: leftSection
          anchors.left: parent.left
          anchors.verticalCenter: parent.verticalCenter
          spacing: sectionsSpacing

          WorkspaceWindows {
              fontFamily: Theme.fontFamily
          }
      }

      // --- Center section ---
      RowLayout {
          id: centerSection
          anchors.centerIn: parent
          spacing: sectionsSpacing

          Workspaces { fontFamily: Theme.fontFamily }
      }

      // --- Right section ---
      RowLayout {
          id: rightSection
          anchors.right: parent.right
          anchors.verticalCenter: parent.verticalCenter
          spacing: sectionsSpacing

          SystemTray {
            fontFamily: Theme.fontFamily
            iconSize: Theme.fontSize + 2
            blacklist: ["network"]
          }

          Battery {
              fontSize: Theme.fontSize
              iconSize: Theme.fontSize + 2
          }
          DateTime {
              fontFamily: Theme.fontFamily
          }
      }
  }
}
