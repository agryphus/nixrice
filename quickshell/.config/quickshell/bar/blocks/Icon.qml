
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects
import QtQuick.Effects

import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../"
import "root:/"

BarBlock {
  id: root
  Layout.preferredWidth: 40

    readonly property list<DesktopEntries> list: DesktopEntry
  content: BarText {
    text: ""
    pointSize: 17
    anchors.horizontalCenterOffset: -2
  }
  // content: IconImage {
  //   id: theicon
  //   visible: false
  //   anchors.centerIn: parent
  //   source: "image://icon/extra-nixos"
  //   implicitSize: 20
  // }
  // DropShadow {
  //   anchors.fill: parent
  //   horizontalOffset: 1
  //   verticalOffset: 1
  //   radius: 6.0
  //   samples: 20
  //   color: "#000000"
  //   source: parent.content
  // }
  // IconImage {
  //   anchors.centerIn: parent
  //   source: "image://icon/extra-nixos"
  //   implicitSize: 20
  // }

  PopupWindow {
    id: appmenu
    anchor.window: bar
    anchor.rect.x: parentWindow.width / 12 - width
    anchor.rect.y: parentWindow.height
    implicitWidth: 500
    implicitHeight: 600
    visible: true
    color: "transparent"

    Rectangle{
        id: sourceItem
        anchors.fill: parent
			  bottomLeftRadius: 10
        color: Theme.get.barBgColor

			  bottomRightRadius: 10

      Rectangle{
        anchors.fill: sourceItem
        gradient: Theme.get.barGradient

			  bottomRightRadius: 10
			  bottomLeftRadius: 10

        ScrollView{
          anchors.fill: parent

            anchors.margins: 10
          ColumnLayout{
            anchors.fill: parent

            Repeater {
              model:  DesktopEntries.applications.values
              RowLayout{

                Rectangle{
                  id: appSelection
                  anchors.fill: parent
                  color: {
                    if (appArea.containsMouse)
                      return hoveredBgColor;
                    return "transparent";
                  }

                  radius: 5
                }
                Rectangle{
                  anchors.fill:parent
                  gradient: Theme.get.barGradient

                  radius: 5
                  border.color: Theme.get.buttonBorderColor
                }
                MouseArea{
                  id: appArea
                  hoverEnabled: true
                  anchors.fill: parent

                  property string fa: DesktopEntries.byId(model?.name).execString
                  onClicked: event => {
                    DesktopEntries.byId(model?.id).execute()

                  }
                }
                IconImage{
                  id:appImage
                  implicitSize: 22
                  source: Quickshell.iconPath(model?.icon)
                }
                Label{

                  id: appText
                  text: (model?.name)+ "   "

                  color:"white"
                  font.pointSize: 12

                }

              }
            }
          }
        }
      }

    }

  }

  Image {

    anchors.fill: parent
    source: mouseArea.containsMouse
        ? "../images/" + Theme.get.iconPressedColor + ".png"
        : "../images/" + Theme.get.iconColor + ".png";
    visible: true
    z: -1
  }

  color: "transparent"


  onClicked: function() {
    appmenu.visible = !appmenu.visible
  }
}
