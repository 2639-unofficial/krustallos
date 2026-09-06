import QtQuick
import Quickshell

// REF: https://git.outfoxxed.me/quickshell/quickshell-examples/src/branch/master/wlogout
ShellRoot {
	WLogout {
		LogoutButton {
			command: "loginctl lock-session"
			keybind: Qt.Key_L
			text: "Lock"
			icon: "lock"
			hoverColor: "#f9e2af"
		}

		LogoutButton {
			command: "loginctl terminate-user $USER"
			keybind: Qt.Key_E
			text: "Logout"
			icon: "logout"
			hoverColor: "#f9c5af"
		}

		LogoutButton {
			command: "systemctl suspend"
			keybind: Qt.Key_U
			text: "Suspend"
			icon: "suspend"
			hoverColor: "#caaff9"
		}

		LogoutButton {
			command: "systemctl hibernate"
			keybind: Qt.Key_H
			text: "Hibernate"
			icon: "hibernate"
			hoverColor: "#a8c0ff"
		}

		LogoutButton {
			command: "systemctl poweroff"
			keybind: Qt.Key_S
			text: "Shutdown"
			icon: "shutdown"
			hoverColor: "#ff8d8d"
		}

		LogoutButton {
			command: "systemctl reboot"
			keybind: Qt.Key_R
			text: "Reboot"
			icon: "reboot"
			hoverColor: "#84ffaa"
		}
	}
}
