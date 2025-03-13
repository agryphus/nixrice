import QtQuick
import Quickshell.Io
import "../"

BarBlock {
  property string battery
  content: BarText {
    symbolText: battery
  }

  Process {
    id: batteryProc
    command: ["block_battery"]
    running: true

    stdout: SplitParser {
      onRead: data => battery = data
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: batteryProc.running = true
  }
}

