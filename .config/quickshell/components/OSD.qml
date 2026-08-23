import Quickshell
import QtQuick
import QtQuick.Layouts

PopupWindow {
    id: root
    required property var anchorWindow

    // --- Public API ---
    property int value: 0
    property int hideDelay: 1500
    property int barWidth: 160
    property int barHeight: 8
    property int iconSize: 20
    property int fontSize: 14
    property string fontFamily: ""
    property string icon: ""

    property color background: "#1a1b26"
    property color borderColor: "#c0caf5"
    property color trackColor: "#414868"
    property color fillColor: "#7aa2f7"
    property color textColor: "#c0caf5"

    property int paddingH: 16
    property int paddingV: 12
    property int bottomMargin: 40

    visible: false
    color: "transparent"

    anchor.window: anchorWindow
    anchor.rect.x: anchorWindow ? (anchorWindow.screen.width - implicitWidth) / 2 : 0
    anchor.rect.y: anchorWindow ? anchorWindow.screen.height - implicitHeight - root.bottomMargin : 0

    implicitWidth: content.implicitWidth + paddingH * 2
    implicitHeight: content.implicitHeight + paddingV * 2

    // --- Functions ---

    function popUp() {
        root.visible = true
        hideTimer.restart()
    }

    Timer {
        id: hideTimer
        interval: root.hideDelay
        onTriggered: root.visible = false
    }

    // --- UI ---

    Rectangle {
        anchors.fill: parent
        color: root.background
        border.color: root.borderColor
        border.width: 1

        RowLayout {
            id: content
            anchors.centerIn: parent
            spacing: 10

            Text {
                text: root.icon
                color: root.textColor
                font.family: root.fontFamily
                font.pixelSize: root.iconSize
                horizontalAlignment: Text.AlignHCenter
                Layout.preferredWidth: root.iconSize
                Layout.alignment: Qt.AlignVCenter
            }

            Rectangle {
                id: track
                width: root.barWidth
                height: root.barHeight
                color: root.trackColor
                Layout.alignment: Qt.AlignVCenter

                Rectangle {
                    width: track.width * root.value / 100
                    height: track.height
                    color: root.fillColor

                    Behavior on width {
                        NumberAnimation { duration: 120 }
                    }
                }
            }

            Text {
                text: root.value + "%"
                color: root.textColor
                font.family: root.fontFamily
                font.pixelSize: root.fontSize
                Layout.alignment: Qt.AlignVCenter
                Layout.minimumWidth: metrics.advanceWidth
            }
        }
    }

    TextMetrics {
        id: metrics
        font.family: root.fontFamily
        font.pixelSize: root.fontSize
        text: "100%"
    }
}
