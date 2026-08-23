import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root

    property int workspaceCount: 8
    property int itemSpacing: 5

    property string fontFamily: ""
    property string separatorIcon: "󰧾"
    property int separatorIconSize: 30

    property int ringSize: 20
    property int ringBorderWidth: 2

    property int activeDotSize: 12
    property int hasWindowsDotSize: 6

    property color background: "transparent"
    property color accentColor: "#c0caf5"
    property color notificationColor: "#9ece6a"

    spacing: itemSpacing

    component WorkspaceCircle: Rectangle {
      property int wsIndex

      property var ws: Hyprland.workspaces.values.find(w => w.id === wsIndex + 1)
      property bool isActive: Hyprland.focusedWorkspace?.id === (wsIndex + 1)
      property var windowsInWs: Hyprland.toplevels.values.filter(
          t => t.workspace && t.workspace.id === wsIndex + 1
      )
      property bool hasWindows: windowsInWs.length > 0
      property bool hasNotification: windowsInWs.some(t => t.urgent === true)

      function dotColor() {
          if (hasNotification) return root.notificationColor
          if (isActive || hasWindows) return root.accentColor
          return root.background
      }

      function dotSize() {
          if (isActive) return root.activeDotSize
          if (hasWindows) return root.hasWindowsDotSize
          return 0
      }

      function borderColor() {
          if (hasNotification) return root.notificationColor
          return root.accentColor
      }

      width: root.ringSize
      height: width
      radius: width / 2
      color: root.background
      border.color: borderColor()
      border.width: root.ringBorderWidth

      Rectangle {
          anchors.centerIn: parent
          width: dotSize()
          height: width
          radius: width / 2
          color: dotColor()
      }
    }

    Repeater {
      model: root.workspaceCount / 2
      delegate: WorkspaceCircle { wsIndex: index }
    }

    Text {
      text: root.separatorIcon
      color: root.accentColor 
      font.family: root.fontFamily
      font.pixelSize: root.separatorIconSize
    }

    Repeater {
      model: root.workspaceCount / 2
      delegate: WorkspaceCircle { wsIndex: index + root.workspaceCount / 2}
    }
}
