pragma Singleton

import QtQuick
import Quickshell

Singleton {
  property Item get: black

  Item {
    id: windowsXP

    property string barBgColor: "#235EDC"
    property string buttonBorderColor: "#99000000"
    property bool buttonBorderShadow: false
    property bool onTop: false
    property string iconColor: "green"
    property string iconPressedColor: "green"
    property Gradient barGradient: black.barGradient
    property Gradient buttonInactiveGradientV: Gradient {
      GradientStop { position: 0.0; color: "#55FFFFFF" }
      GradientStop { position: 0.3; color: "#22FFFFFF" }
    }
    property Gradient buttonInactiveGradientH: Gradient {
      orientation: Gradient.Horizontal
      GradientStop { position: 0.0; color: "#55FFFFFF" }
      GradientStop { position: 0.1; color: "#00000000" }
    }
    property Gradient buttonActiveGradient: Gradient {
      GradientStop { position: 0.0; color: "#99000000" }
      GradientStop { position: 0.3; color: "#55000000" }
      GradientStop { position: 1.0; color: "#55000000" }
    }
  }

  Item {
    id: black

    property string barBgColor: "#cc000000" 
    property string buttonBorderColor: "#44FFFFFF"
    property bool buttonBorderShadow: true
    property bool onTop: true
    property string iconColor: "blue"
    property string iconPressedColor: "dark_blue"
    property Gradient barGradient: Gradient {
      GradientStop { position: 0.0; color: "#55FFFFFF" }
      GradientStop { position: 0.4; color: "#00FFFFFF" }
      GradientStop { position: 0.8; color: "#00FFFFFF" }
      GradientStop { position: 1.0; color: "#AA000000" }
    }
    property Gradient buttonInactiveGradientV: Gradient {
      GradientStop { position: 0.0; color: "#33FFFFFF" }
      GradientStop { position: 0.3; color: "#55000000" }
    }
    property Gradient buttonInactiveGradientH: Gradient {
      orientation: Gradient.Horizontal
      GradientStop { position: 0.0; color: "#55FFFFFF" }
      GradientStop { position: 0.1; color: "#00000000" }
    }
    property Gradient buttonActiveGradient: Gradient {
      GradientStop { position: 0.92; color: "#FF000000" }
      GradientStop { position: 0.93; color: "#FFFFFFFF" }
      GradientStop { position: 1.0; color: "#FFFFFFFF" }
    }
  }

  Item {
    id: black_bright

    property string barBgColor: black.barBgColor
    property string buttonBorderColor: windowsXP.buttonBorderColor
    property bool buttonBorderShadow: windowsXP.buttonBorderShadow
    property bool onTop: black.onTop
    property string iconColor: "orange"
    property string iconPressedColor: "orange"
    property Gradient barGradient: black.barGradient
    property Gradient buttonInactiveGradientV: windowsXP.buttonInactiveGradientV
    property Gradient buttonInactiveGradientH: windowsXP.buttonInactiveGradientH
    property Gradient buttonActiveGradient: windowsXP.buttonActiveGradient
  }

  Item {
    id: black_flat

    property string barBgColor: "#cc000000" 
    property string buttonBorderColor: "#01000000" // Making this transparent breaks things
    property bool buttonBorderShadow: false
    property bool onTop: true
    property string iconColor: ""
    property string iconPressedColor: ""
    property Gradient barGradient: Gradient {
      GradientStop { position: 0.0; color: "transparent" }
    }
    property Gradient buttonInactiveGradientV: Gradient {
      GradientStop { position: 0.0; color: "transparent" }
    }
    property Gradient buttonInactiveGradientH: Gradient {
      orientation: Gradient.Horizontal
      GradientStop { position: 0.0; color: "transparent" }
    }
    property Gradient buttonActiveGradient: black.buttonActiveGradient
  }
}

