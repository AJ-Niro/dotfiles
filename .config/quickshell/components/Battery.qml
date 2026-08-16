import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root

    property int iconSize: 18
    property int fontSize: 14
    property string fontFamily: ""
    property int spacingAmount: 5

    property color normalColor: "#c0caf5"
    property color chargingColor: "#9ece6a"
    property color lowColor: "#f7768e"
    property color criticalColor: "#db4b4b"

    property int lowThreshold: 30
    property int criticalThreshold: 20

    property bool showPercentage: true

    spacing: root.spacingAmount

    property var device: UPower.displayDevice
    property int percentage: device ? Math.round(device.percentage * 100) : 0
    property bool isCharging: device ? device.state === UPowerDeviceState.Charging : false
    property bool isFull: device ? device.state === UPowerDeviceState.FullyCharged : false

    function batteryColor() {
        if (isCharging || isFull) return root.chargingColor
        if (percentage <= root.criticalThreshold) return root.criticalColor
        if (percentage <= root.lowThreshold) return root.lowColor
        return root.normalColor
    }

    function batteryIcon() {
        if (isCharging) return "󰂄"
        if (isFull) return "󰁹"

        if (percentage <= 10) return "󰁺"
        if (percentage <= 20) return "󰁻"
        if (percentage <= 30) return "󰁼"
        if (percentage <= 40) return "󰁽"
        if (percentage <= 50) return "󰁾"
        if (percentage <= 60) return "󰁿"
        if (percentage <= 70) return "󰂀"
        if (percentage <= 80) return "󰂁"
        if (percentage <= 90) return "󰂂"
        return "󰁹"
    }

    Text {
        text: root.batteryIcon()
        color: root.batteryColor()
        font.family: root.fontFamily
        font.pixelSize: root.iconSize
    }

    Text {
        visible: root.showPercentage
        text: root.percentage + "%"
        color: root.batteryColor()
        font.family: root.fontFamily
        font.pixelSize: root.fontSize
    }
}
