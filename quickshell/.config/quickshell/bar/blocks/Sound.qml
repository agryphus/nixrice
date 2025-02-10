import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import "../"

BarBlock {
  id: text
  text: ` ${Math.floor(sink?.audio.volume * 100)}%`

  property PwNode sink: Pipewire.defaultAudioSink
  PwObjectTracker { objects: [ sink ] }
}

