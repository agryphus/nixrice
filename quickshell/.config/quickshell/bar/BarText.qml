import Quickshell
import Quickshell.Io
import QtQuick

Item {
  property string text
  property string color: "white"
  property string mainFont: "FiraCode"
  property string symbolFont: "Symbols Nerd Font Mono"
  property int pointSize: 11

  implicitWidth: thetext.implicitWidth
  implicitHeight: thetext.implicitHeight

  function wrapSymbols(text) {
    const isSymbol = (codePoint) =>
        (codePoint >= 0xE000   && codePoint <= 0xF8FF) // Private Use Area
     || (codePoint >= 0xF0000  && codePoint <= 0xFFFFF) // Supplementary Private Use Area-A
     || (codePoint >= 0x100000 && codePoint <= 0x10FFFF); // Supplementary Private Use Area-B

    return text.replace(/./gu, (c) => isSymbol(c.codePointAt(0))
      ? `<span style='font-family: ${symbolFont}; letter-spacing: -5px; font-size: ${pointSize + 4}px'>${c}</span>`
      : c);
  }

  Text {
    id: thetext
    text: wrapSymbols(parent.text)
    color: parent.color
    anchors.centerIn: parent

    font {
      family: parent.mainFont
      pointSize: parent.pointSize
    }
    textFormat: Text.RichText
  }
}

