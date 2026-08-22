import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root

    property int iconSize: 18
    property int itemSpacing: 10

    property color tooltipBackground: "#1a1b26"
    property color tooltipTextColor: "#c0caf5"
    property color tooltipBorderColor: "#c0caf5"
    property string fontFamily: ""
    property int tooltipFontSize: 12

    // Match against each item's id/title — case-insensitive substring match
    property var blacklist: ["network", "wifi", "nm-applet"]

    spacing: root.itemSpacing

    function isBlacklisted(item) {
        const haystack = ((item.id || "") + " " + (item.title || "")).toLowerCase()
        return root.blacklist.some(term => haystack.includes(term.toLowerCase()))
    }

    Repeater {
        model: SystemTray.items

        delegate: Item {
            id: trayItem
            required property var modelData

            visible: !root.isBlacklisted(modelData)
            implicitWidth: visible ? root.iconSize : 0
            implicitHeight: root.iconSize
            Layout.alignment: Qt.AlignVCenter

            Image {
                anchors.fill: parent
                source: trayItem.modelData.icon
                fillMode: Image.PreserveAspectFit
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: trayItem.modelData.activate()
                onEntered: {
                    tooltipWindow.hoveredItem = trayItem
                    tooltipWindow.titleText = trayItem.modelData.tooltipTitle || trayItem.modelData.title || ""
                    tooltipWindow.visible = tooltipWindow.titleText.length > 0
                }
                onExited: {
                    tooltipWindow.visible = false
                }
            }
        }
    }

    // --- Floating tooltip window ---
    PopupWindow {
        id: tooltipWindow
        visible: false
        color: "transparent"

        property var hoveredItem: null
        property string titleText: ""

        anchor.window: hoveredItem ? hoveredItem.QsWindow.window : null
        anchor.rect.x: hoveredItem
            ? hoveredItem.mapToItem(hoveredItem.QsWindow.window.contentItem, 0, 0).x
            : 0
        anchor.rect.y: hoveredItem
            ? hoveredItem.mapToItem(hoveredItem.QsWindow.window.contentItem, 0, hoveredItem.height + 6).y
            : 0

        implicitWidth: tooltipText.implicitWidth + 16
        implicitHeight: tooltipText.implicitHeight + 12

        Rectangle {
            anchors.fill: parent
            color: root.tooltipBackground
            border.color: root.tooltipBorderColor
            border.width: 1
            radius: 4

            Text {
                id: tooltipText
                anchors.centerIn: parent
                text: tooltipWindow.titleText
                color: root.tooltipTextColor
                font.family: root.fontFamily
                font.pixelSize: root.tooltipFontSize
            }
        }
    }
}
