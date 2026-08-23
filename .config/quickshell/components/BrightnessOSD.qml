import Quickshell
import Quickshell.Io
import QtQuick

OSD {
    id: root
    icon: "󰃞"

    // --- Internal state ---
    property string deviceName: ""
    property int maxBrightness: 1
    property bool hasReadInitialValue: false

    // --- Functions ---

    function percentFromRaw(rawValue) {
        return Math.round((rawValue / root.maxBrightness) * 100)
    }

    function onBrightnessFileLoaded(rawText) {
        const raw = parseInt(rawText)
        if (isNaN(raw)) return

        root.value = percentFromRaw(raw)

        if (!root.hasReadInitialValue) {
            root.hasReadInitialValue = true
            return
        }

        root.popUp()
    }

    // --- Device discovery (runs once at startup) ---

    Process {
        id: findBacklightDevice
        command: ["bash", "-c", "ls /sys/class/backlight | head -n1"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.deviceName = text.trim()
        }
    }

    Process {
        id: readMaxBrightness
        command: root.deviceName
            ? ["cat", `/sys/class/backlight/${root.deviceName}/max_brightness`]
            : []
        stdout: StdioCollector {
            onStreamFinished: {
                const value = parseInt(text)
                if (!isNaN(value)) root.maxBrightness = value
            }
        }
    }

    onDeviceNameChanged: {
        if (deviceName) readMaxBrightness.running = true
    }

    // --- Live brightness watcher (reactive, no polling) ---

    FileView {
        id: brightnessFile
        path: root.deviceName ? `/sys/class/backlight/${root.deviceName}/brightness` : ""
        watchChanges: true
        onFileChanged: reload()
        onLoaded: root.onBrightnessFileLoaded(text())
    }
}
