import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "blocks" as Blocks

Scope {
  Variants {
    model: Quickshell.screens
  
    PanelWindow {
      property var modelData
      screen: modelData

      color: "#cc000000"
      height: 27
    
      anchors {
        top: true
        left: true
        right: true
      }
    
      RowLayout {
        spacing: 0
        width: parent.width
        height: parent.height
  
        // Left side
        RowLayout {
          spacing: 0
          Layout.alignment: Qt.AlignLeft

          Blocks.Icon {}
          Blocks.Workspaces {}
          Blocks.ActiveWorkspace {}
        }
  
        // Right side
        RowLayout {
          spacing: 0
          Layout.alignment: Qt.AlignRight
  
          Blocks.SystemTray {}
          Blocks.Test {}
          Blocks.Notifications {}
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

