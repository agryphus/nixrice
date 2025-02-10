import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
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
      underline: isActive || isOpen
      onClicked: function() {
        Hyprland.dispatch(`workspace ${ws.id}`);
      }
      leftPadding: hasClients ? 2 : 0
      text: {
        if (isActive) {
          if (!hasClients)
            return `<span style='color:${fgColor};'>${ws.name}</span>`
          var split_i = ws.id > 9 ? 3 : 2
          return `<span style='color:${fgColor};'>${ws.name.slice(0, split_i)}</span>${ws.name.slice(split_i)}`
        }
        return ws.name
      }
    }
  }
}

