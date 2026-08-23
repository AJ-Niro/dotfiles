import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root

    property int iconSize: 20
    property int itemSpacing: 12
    property int maxTitleLength: 40
    property string fontFamily: ""
    property int tooltipFontSize: 12

    property color focusedUnderlineColor: "#7aa2f7"
    property int focusedUnderlineHeight: 2
    property int focusedUnderlineOverhang: 2

    property color tooltipBackground: "#1a1b26"
    property color tooltipTextColor: "#c0caf5"
    property color tooltipBorderColor: "#c0caf5"

    spacing: root.itemSpacing

    property int currentWorkspaceId: Hyprland.focusedWorkspace?.id ?? -1
    property var windows: Hyprland.toplevels.values.filter(
        t => t.workspace && t.workspace.id === root.currentWorkspaceId
    )
    property var desktopIconCache: ({})
    property var pendingLookups: ({})

    function isFocused(win) {
        return Hyprland.activeToplevel && win.address === Hyprland.activeToplevel.address
    }

    function truncateTitle(title) {
        if (!title) return ""
        if (title.length <= root.maxTitleLength) return title
        return title.substring(0, root.maxTitleLength) + "…"
    }

    function focusWindow(win) {
        Hyprland.dispatch(`focuswindow address:${win.address}`)
    }

    function iconFor(win) {
        const appId = win.wayland?.appId ?? ""
        if (!appId) return ""
        if (root.desktopIconCache[appId]) return root.desktopIconCache[appId]
        if (!root.pendingLookups[appId]) {
            root.pendingLookups[appId] = true
            root.resolveFromDesktopFile(appId)
        }
        return appId
    }

    function resolveFromDesktopFile(appId) {
        const dirs = "/usr/share/applications ~/.local/share/applications"

        const findByFilename = `f=$(find ${dirs} -iname "${appId}.desktop" 2>/dev/null | head -n1)`
        const findByContent = `[ -z "$f" ] && f=$(grep -ril "StartupWMClass=.*${appId}" ${dirs} 2>/dev/null | head -n1)`
        const extractIcon = `[ -n "$f" ] && grep -m1 "^Icon=" "$f" | cut -d= -f2`

        const script = `${findByFilename}\n${findByContent}\n${extractIcon}`

        lookupProcess.pendingAppId = appId
        lookupProcess.command = ["bash", "-c", script]
        lookupProcess.running = true
    }

    Process {
        id: lookupProcess
        property string pendingAppId: ""
        stdout: SplitParser {
            onRead: data => {
                const iconName = data.trim()
                const appId = lookupProcess.pendingAppId
                if (iconName.length > 0) {
                    let cache = root.desktopIconCache
                    cache[appId] = iconName
                    root.desktopIconCache = Object.assign({}, cache)
                }
            }
        }
    }

    Repeater {
        model: root.windows
        delegate: Item {
            id: windowItem
            required property var modelData
            property bool hovered: false

            implicitWidth: root.iconSize
            implicitHeight: root.iconSize + root.focusedUnderlineHeight + 4
            Layout.alignment: Qt.AlignVCenter

            IconImage {
                id: icon
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                implicitSize: root.iconSize
                source: Quickshell.iconPath(root.iconFor(windowItem.modelData), "image-missing")
            }

            Rectangle {
                visible: root.isFocused(windowItem.modelData)
                color: root.focusedUnderlineColor
                radius: height / 2

                height: root.focusedUnderlineHeight
                width: icon.width + (root.focusedUnderlineOverhang * 2)

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: icon.bottom
                anchors.topMargin: 1.5
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                z: 1000
                onEntered: {
                    windowItem.hovered = true
                    tooltipWindow.hoveredItem = windowItem
                    tooltipWindow.titleText = root.truncateTitle(windowItem.modelData.title)
                    tooltipWindow.visible = true
                }
                onExited: {
                    windowItem.hovered = false
                    tooltipWindow.visible = false
                }
                onClicked: root.focusWindow(windowItem.modelData)
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

    Text {
        visible: root.windows.length === 0
        text: "No windows"
        color: root.tooltipTextColor
        opacity: 0.5
        font.family: root.fontFamily
        font.pixelSize: root.tooltipFontSize
    }
}
