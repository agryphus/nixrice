import QtQuick
import QtQuick.Layouts
import Quickshell

Rectangle {
  id: root
  Layout.preferredWidth: wsText.implicitWidth + 10
  Layout.preferredHeight: 27

  property string text
  property bool dim: false
  property bool underline
  property var onClicked: function() {}
  property int leftPadding
  property int rightPadding

  property string fgColor: "white"
  property string dimFgColor: "#999999"
  property string hoveredBgColor: "#444444"

  // Background color
  color: {
    if (mouseArea.containsMouse)
      return hoveredBgColor;
    return "transparent";
  }

  states: [
    State {
      when: mouseArea.containsMouse
      PropertyChanges {
        target: root
      }
    }
  ]

  Behavior on color {
    ColorAnimation {
      duration: 200
    }
  }

  BarText {
    id: wsText
    text: root.text
    anchors {
        left: parent.left
        right: parent.right
        leftMargin: root.leftPadding
        rightMargin: root.rightPadding
        verticalCenter: parent.verticalCenter
    }

    color: {
      if (mouseArea.containsMouse || !root.dim)
        return fgColor
      return dimFgColor
    }

    Behavior on color {
      ColorAnimation {
        duration: 100
      }
    }
  }

  MouseArea {
    id: mouseArea
    anchors.fill: root
    hoverEnabled: true
    acceptedButtons: Qt.LeftButton
    onClicked: root.onClicked()
  }

  // While line underneath workspace
  Rectangle {
    id: wsLine
    width: parent.width
    height: 3

    color: {
      if (parent.underline)
        return fgColor;
      return "transparent";
    }
    anchors.bottom: parent.bottom
  }
}

