import QtQuick
import Quickshell

// REF: https://git.outfoxxed.me/quickshell/quickshell-examples/src/branch/master/wlogout
ShellRoot {
	WLogout {
		LogoutAction {
			command: "loginctl lock-session"
			keybind: Qt.Key_L
			text: "Lock"
			icon: "lock"
			accentColor: "#f9e2af"
			quitAfterExec: true
		}

		LogoutAction {
			command: "loginctl terminate-user $USER"
			keybind: Qt.Key_E
			text: "Logout"
			icon: "logout"
			accentColor: "#f9c5af"
			quitAfterExec: false
		}

		LogoutAction {
			command: "systemctl suspend"
			keybind: Qt.Key_U
			text: "Suspend"
			icon: "suspend"
			accentColor: "#caaff9"
			quitAfterExec: true
		}

		LogoutAction {
			command: "systemctl hibernate"
			keybind: Qt.Key_H
			text: "Hibernate"
			icon: "hibernate"
			accentColor: "#a8c0ff"
			quitAfterExec: true
		}

		LogoutAction {
			command: "systemctl poweroff"
			keybind: Qt.Key_S
			text: "Shutdown"
			icon: "shutdown"
			accentColor: "#ff8d8d"
			quitAfterExec: false
		}

		LogoutAction {
			command: "systemctl reboot"
			keybind: Qt.Key_R
			text: "Reboot"
			icon: "reboot"
			accentColor: "#84ffaa"
			quitAfterExec: false
		}
	}
}
