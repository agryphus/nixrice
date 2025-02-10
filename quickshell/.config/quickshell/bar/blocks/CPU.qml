import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import "../"

Item {
  implicitHeight: text.implicitHeight
  implicitWidth: text.implicitWidth

  property string percentUsed

  Process {
    id: cpuProc
    command: ["sh", "-c", "top -bn 1 | grep \"%Cpu(s)\" | awk '{usage=100-$8; printf \"%02d%%\\n\", usage}'"]
    running: true

    stdout: SplitParser {
      onRead: data => percentUsed = data
    }
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: cpuProc.running = true
  }

  BarText {
    id: text
    text: "<div style = 'font-family: Symbols Nerd Font Mono'>%1</div>%2"
      .arg(" ") // The rest of the string
      .arg(percentUsed) // Symbol needs its own font
  }
}
