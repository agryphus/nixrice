import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import "../"

BarBlock {
  id: text
  visible: Pipewire.ready

  content: BarText {
    symbolText: ` ${volume}`
  }

  property PwNode sink: Pipewire.defaultAudioSink
  property string volume: Pipewire.ready ? `${Math.floor(sink.audio.volume * 100)}%` : ""

  PwObjectTracker { objects: [ sink ] }
}

