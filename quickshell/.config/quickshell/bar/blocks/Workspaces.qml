import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects
import "root:/"
import "../"

RowLayout {
  spacing: 0
  property HyprlandMonitor monitor: Hyprland.monitorFor(screen)

  Repeater {
    model: ScriptModel {
      values: {
        var seenEmpty = false
        return [...Hyprland.workspaces.values]
          .filter((ws) => {
            if (ws.monitor !== monitor || ws.name.includes("special"))
              return false

            // There is a flickering that can happen when switching from one
            // empty workspace to another where both empty workspaces are shown
            // on the bar at the same time.  This ensures that only the first
            // empty workspace is shown.
            const isNumeric = /^\d+$/.test(ws.name);
            if (!isNumeric)
              return true;
            if (!seenEmpty) {
              seenEmpty = true
              return true
            }
            return false;
          })
          // Sort workspaces by id
          .sort((a, b) => a.id - b.id)
      }
    }

    BarBlock {
      property HyprlandWorkspace ws: modelData
      property bool isActive: Hyprland.focusedMonitor?.activeWorkspace?.id === ws.id
      property bool isOpen: monitor.activeWorkspace?.id === ws.id
      property bool hasClients: ws.name.length > 2

      dim: true
      underline: false
      border.color: Theme.get.buttonBorderColor
      radius: 5
      gradient: isActive || isOpen ? Theme.get.buttonActiveGradient : Theme.get.buttonInactiveGradientV
      Layout.preferredWidth: content.width + 20

      Rectangle {
        visible: !isActive && !isOpen
        gradient: Theme.get.buttonInactiveGradientH
        implicitWidth: parent.width
        implicitHeight: parent.height
        radius: parent.radius
        z:-1
      }

      Rectangle {
        visible: Theme.get.buttonBorderShadow
        implicitWidth: parent.width - 1
        implicitHeight: parent.height - 1
        radius: parent.radius
        color: "transparent" // Transparent fill
        border.color: parent.isActive || parent.isOpen ? "transparent" : "black" // Inner border color
        border.width: 1 // Inner border width

        x: 1
        y: 1
        z: -1
      }

      onClicked: function() {
        Hyprland.dispatch(`workspace ${ws.id}`);
      }

      content: RowLayout {
        spacing: 0
        anchors.centerIn: parent

        Repeater {
          id: therepeater
          model: ScriptModel {
            values: getChunks(ws.name)
          }

          delegate: Item {
            property bool showText: modelData.type === "text" && modelData.value.length > 0
            property bool showIcon: modelData.type === "icon"
            // property int symbolSize: 18
            property int symbolSize: 22
            property int spacerSize: 3

            implicitWidth:  {
              if (showText)
                return thetext.implicitWidth
              if (showIcon)
                return symbolSize
              return spacerSize;
            }
            implicitHeight:  {
              if (showText)
                return thetext.implicitHeight
              if (showIcon)
                return symbolSize
              return spacerSize;
            }
            Layout.alignment: Qt.AlignCenter

            Loader {
              id: thetext
              anchors.centerIn: parent
              active:  modelData.type === "text"
              sourceComponent: BarText {
                text: modelData.value
                dim: !isActive

                // pointSize: 10
              }
            }

            Loader {
              id: theicon
              anchors.centerIn: parent
              active: modelData.type === "icon"

              sourceComponent: Item {
                implicitWidth:  inside.implicitWidth
                implicitHeight: inside.implicitHeight
                IconImage {
                  id: inside
                  anchors.centerIn: parent
                  source: modelData.source
                  implicitSize: symbolSize
                  opacity: modelData.active ? 1 : 0.7
                  mipmap: true
                }
                DropShadow {
                  anchors.fill: parent
                  verticalOffset: 1
                  horizontalOffset: 1
                  radius: 8.0
                  color: "#000000"
                  source: inside
                  opacity: modelData.active ? 1 : 0.7
                }
                Rectangle {
                  visible: modelData.mult > 1
                  width: 10
                  height: width
                  radius: width / 2
                  color: "black"
                  opacity: 0.8
                  BarText {
                    text: modelData.mult
                    pointSize: 10
                    dim: !isActive
                    style: Text.Outline
                    styleColor: "black"
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  function getChunks(text) {
    let chunks = [];
    let buffer = "";  // Temporary storage for text segments

    let symbolChunkInd = {}

    let nextIsActive = false
    for (let c of text) {
      if (c === "󰀦") {
        nextIsActive = true
        continue
      }

      if (!(c in symbolImgMap)) {
        buffer += c;
        nextIsActive = false
        continue;
      }

      if (buffer.length > 0 && !/^\s*$/.test(buffer)) {
        chunks.push({
            type: "text",
            value: buffer,
        });
        buffer = ""; // Reset text buffer
      }

      if (!(c in symbolChunkInd)) {
        if (chunks[chunks.length - 1].type == "icon") {
          chunks.push({type: "spacer"})
        }
        symbolChunkInd[c] = chunks.length
        chunks.push({
          type: "icon",
          active: nextIsActive,
          source: `image://icon/${symbolImgMap[c]}`,
          mult: 1, // multiplicity; how many times this symbol was seen
        });
      } else {
        chunks[symbolChunkInd[c]].mult++
        if (nextIsActive)
          chunks[symbolChunkInd[c]].active = true;
      }
      nextIsActive = false
    }

    if (buffer.length > 0 && !/^\s*$/.test(buffer)) {
      chunks.push({ type: "text", value: buffer})
    }

    return chunks;
  }

  property var symbolImgMap: {
    "": "extra-scale-vim",
    "󰇥": "extra-scale-yazi",
    // "󰇧": "extra-zen",
    "󰇧": "extra-scale-firefox",
    "󰒱": "extra-scale-slack",
    "": "extra-scale-terminal-thin",
    "": "extra-scale-firefox",
    "": "extra-scale-element-desktop",
    "󰊴": "extra-scale-discord-circle-dark",
    "": "extra-scale-chromium",
    // "": "chromium",
    "󰽉": "libreoffice-draw",
    "󰷈": "libreoffice-writer",
    "": "libreoffice-calc",
    "󰈩": "libreoffice-impress",
    // "󰭹": "signal-desktop",
    "󰭹": "extra-signal-simple",
    "": "extra-zathura",
    "": "extra-spotify",
    // "": "extra-scale-spotify",
    "": "extra-steam",
    "": "extra-scale-bluetooth",
    "": "extra-anki",
    "": "extra-scale-gimp",
    "": "extra-ghidra",
    // "󰄄": "com.obsproject.Studio",
    "󰄄": "extra-scale-obs",
    "": "extra-scale-photos",
    "": "extra-anki",
    "": "extra-mpv",
    "": "extra-virtualbox",
    "": "extra-scale-emacs",
    "": "monero",
    "󰻎": "extra-system-explorer-outline",
    "󱍼": "extra-scale-vlc",
    "": "com.usebottles.bottles",
    "": "Zoom",
    "󰊻": "teams-for-linux",
  }
}

