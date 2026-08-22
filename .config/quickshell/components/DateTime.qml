import Quickshell
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root

    property string timeFormat: "hh:mm"
    property string dateFormat: "ddd, MMM d"
    property bool showDate: true
    property bool showIcons: true

    property string calendarIcon: "󰃭"
    property string clockIcon: "/"

    property int fontSize: 14
    property string fontFamily: ""
    property color textColor: "#c0caf5"
    property color iconColor: "#c0caf5"

    property int groupSpacing: 3
    property int iconSpacing: 5

    // SystemClock.Minutes is the default since seconds aren't shown by default.
    // Switch to SystemClock.Seconds if you set timeFormat to include "ss".
    property int precision: SystemClock.Minutes

    spacing: root.groupSpacing

    SystemClock {
        id: clock
        precision: root.precision
    }

    RowLayout {
        visible: root.showDate
        spacing: root.iconSpacing

        Text {
            visible: root.showIcons
            text: root.calendarIcon
            color: root.iconColor
            font.family: root.fontFamily
            font.pixelSize: root.fontSize
            Layout.alignment: Qt.AlignVCenter
        }

        Text {
            text: Qt.formatDateTime(clock.date, root.dateFormat)
            color: root.textColor
            font.family: root.fontFamily
            font.pixelSize: root.fontSize
            Layout.alignment: Qt.AlignVCenter
        }
    }

    RowLayout {
        spacing: root.iconSpacing

        Text {
            visible: root.showIcons
            text: root.clockIcon
            color: root.iconColor
            font.family: root.fontFamily
            font.pixelSize: root.fontSize
            Layout.alignment: Qt.AlignVCenter
        }

        Text {
            text: Qt.formatDateTime(clock.date, root.timeFormat)
            color: root.textColor
            font.family: root.fontFamily
            font.pixelSize: root.fontSize
            Layout.alignment: Qt.AlignVCenter
        }
    }
}
