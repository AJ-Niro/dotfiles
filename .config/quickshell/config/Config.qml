pragma Singleton
import QtQuick

QtObject {
  readonly property QtObject bar: QtObject {
    readonly property int height: 34
  }
}
