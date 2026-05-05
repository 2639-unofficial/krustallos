import QtQuick
import Quickshell.Io

QtObject {
	id: button

	required property string command
	required property string text
	required property string icon
	required property color accentColor

	property var keybind: null
	property bool isActive: false

	// A small hack to eliminate the brief flash of desktop before lockscreen spawns in
	// For logout, reboot, or shutdown, we simply omit the Qt.quit call
	property bool quitAfterExec: false
	property int quitDelay: 300

	readonly property var process: Process {
		command: ["sh", "-c", button.command]
	}

	// Wait for the animation to finish and a chance to cancel
	readonly property var execTimer: Timer {
		interval: 500
		repeat: false

		onTriggered: button.exec()
	}

	readonly property var quitTimer: Timer {
		interval: quitDelay
		onTriggered: Qt.quit()
	}

	function buttonExec() {
		if (execTimer.running) return;

		isActive = true;
		execTimer.start();
	}

	function exec() {
		process.startDetached();
		if (quitAfterExec) quitTimer.start();
	}
}
