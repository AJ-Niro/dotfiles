import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

OSD {
    id: root
    icon: root.muted ? "󰝟" : root.value >= 50 ? "󰕾" : root.value > 0 ? "󰖀" : "󰕿"

    // --- Internal state ---
    readonly property var sink: Pipewire.defaultAudioSink
    readonly property bool muted: root.sink ? root.sink.audio.muted : false
    property bool hasReadInitialValue: false

    // --- Functions ---

    function syncFromSink() {
        if (!root.sink) return

        root.value = Math.round(root.sink.audio.volume * 100)

        if (!root.hasReadInitialValue) {
            root.hasReadInitialValue = true
            return
        }

        root.popUp()
    }

    onSinkChanged: root.syncFromSink()

    // --- Default sink tracking (keeps the node's properties bound) ---

    PwObjectTracker {
        objects: root.sink ? [root.sink] : []
    }

    // --- Live volume/mute watcher (reactive, no polling) ---

    Connections {
        target: root.sink ? root.sink.audio : null
        function onVolumesChanged() { root.syncFromSink() }
        function onMutedChanged() { root.syncFromSink() }
    }
}
