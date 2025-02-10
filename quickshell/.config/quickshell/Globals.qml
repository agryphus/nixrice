pragma Singleton

import QtQuick
import Quickshell

Singleton {
	id: root
	property var popupContext: PopupContext {};
	property var date: new Date()

	Timer {
		interval: 1000
		repeat: true
		running: true

		onTriggered: root.date = new Date()
	}
}
