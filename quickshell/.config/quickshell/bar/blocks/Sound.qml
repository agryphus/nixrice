import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import "../"

BarBlock {
  id: text
  content: BarText {
    symbolText: ` ${Math.floor(volume * 100)}%`
  }

  property PwNode sink: Pipewire.defaultAudioSink
  property real volume: sink?.audio.volume

  PwObjectTracker { objects: [ sink ] }
}

