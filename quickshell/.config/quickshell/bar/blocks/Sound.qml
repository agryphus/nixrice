
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
    symbolText: volume
  }

  property PwNode sink: Pipewire.defaultAudioSink
  property int currentVolume: Math.floor(sink.audio.volume * 100)
  property string volume: (" " + currentVolume + "%")
  MouseArea {
    anchors.fill: parent

    onWheel: wheel => {
      const delta = wheel.angleDelta.y / 120 * 5
      text.currentVolume += delta
      if (text.currentVolume > 100) text.currentVolume = 100
      else if (text.currentVolume < 0) text.currentVolume = 0

      sink.audio.volume = text.currentVolume / 100
      wheel.accepted = true
      console.log("Volume:", text.currentVolume)

    }
  }

  PwObjectTracker { objects: [ sink ] }
}
