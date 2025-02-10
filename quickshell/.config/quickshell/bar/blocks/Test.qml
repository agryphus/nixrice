import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "../"

Repeater {
  // model: SystemTray.items
  model: ScriptModel {
    values: SystemTray.items.values
      .filter((item) => item.id == "nm-tray")
  }


  BarBlock {
    id: block
    Layout.preferredWidth: 30
    leftPadding: 4
    text: " "

    required property SystemTrayItem modelData
    property alias item: block.modelData

    MouseArea {
      id: delegate
      anchors.fill: block

      property alias item: block.item

      acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
      hoverEnabled: true

      onClicked: event => {
        if (event.button == Qt.LeftButton) {
          item.activate();
        } else if (event.button == Qt.MiddleButton) {
          item.secondaryActivate();
        } else if (event.button == Qt.RightButton) {
          menuAnchor.open();
        }
      }

      onWheel: event => {
        event.accepted = true;
        const points = event.angleDelta.y / 120
        item.scroll(points, false);
      }

      QsMenuAnchor {
        id: menuAnchor
        menu: item.menu

        anchor.window: delegate.QsWindow.window
        anchor.adjustment: PopupAdjustment.Flip

        anchor.onAnchoring: {
          console.log("here2")
          const window = delegate.QsWindow.window;
          const widgetRect = window.contentItem.mapFromItem(delegate, 0, delegate.height, delegate.width, delegate.height);

          menuAnchor.anchor.rect = widgetRect;
        }
      }

      Tooltip {
        relativeItem: delegate.containsMouse ? delegate : null

        Label {
          text: delegate.item.tooltipTitle || delegate.item.id
        }
      }
    }
  }
}

