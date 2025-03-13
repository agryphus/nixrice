import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "blocks" as Blocks
import "root:/"

Scope {
  Variants {
    model: Quickshell.screens
  
    PanelWindow {
      id: bar
      property var modelData
      screen: modelData

      color: Theme.get.barBgColor

      Rectangle {
        id: highlight
        anchors.fill: parent
        gradient: Theme.get.barGradient
      }

      height: 30

      visible: true

      IpcHandler {
        target: "bar"

        function toggleVis(): void {
          visible = !visible;
        }
      }
    
      anchors {
        top: Theme.get.onTop
        bottom: !Theme.get.onTop
        left: true
        right: true
      }
    
      RowLayout {
        id: allBlocks
        spacing: 0
        anchors.fill: parent
  
        // Left side
        RowLayout {
          id: leftBlocks
          spacing: 10
          Layout.alignment: Qt.AlignLeft
          Layout.fillWidth: true

          Blocks.Icon {}
          Blocks.Workspaces {}
        }

        Blocks.ActiveWorkspace {
          id: activeWorkspace
          Layout.leftMargin: 10
          anchors.centerIn: undefined

          chopLength: {
            var space = Math.floor(bar.width - (rightBlocks.implicitWidth + leftBlocks.implicitWidth))
            return space * 0.08;
          }

          text: {
            var str = activeWindowTitle
            return str.length > chopLength ? str.slice(0, chopLength) + '...' : str;
          }

          color: {
            return Hyprland.focusedMonitor == Hyprland.monitorFor(screen)
              ? "#FFFFFF" : "#CCCCCC"
          }
        }

        // Without this filler item, the active window block will be centered
        // despite setting left alignment
        Item {
          Layout.fillWidth: true
        }
  
        // Right side
        RowLayout {
          id: rightBlocks
          spacing: 0
          Layout.alignment: Qt.AlignRight
          Layout.fillWidth: true
  
          Blocks.SystemTray {}
          Blocks.Memory {}
          Blocks.Sound {}
          Blocks.Battery {}
          Blocks.Date {}
          Blocks.Time {}
        }
      }
    }
  }
}

