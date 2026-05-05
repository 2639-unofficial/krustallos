import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

Variants {
	id: root
	property color backgroundColor: "#0000000c"
	property color foregroundColor: "#ffffff"
	property color buttonColor: "#000000"
	property color buttonHoverColor: "#000000"
	property int boxRadius: 40
	property int popupRadius: 25
	default property list<LogoutAction> buttons

	model: Quickshell.screens
	PanelWindow {
		id: w

		property var modelData
		screen: modelData

		exclusionMode: ExclusionMode.Ignore
		WlrLayershell.layer: WlrLayer.Overlay
		WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

		color: "transparent"

		contentItem {
			focus: true
			Keys.onPressed: event => {
				if (event.key == Qt.Key_Escape) Qt.quit();
				else {
					for (let i = 0; i < buttons.length; i++) {
						let button = buttons[i];
						if (event.key == button.keybind) button.buttonExec();
					}
				}
			}
		}

		anchors {
			top: true
			left: true
			bottom: true
			right: true
		}

		Rectangle {
			color: backgroundColor
			anchors.fill: parent

			MouseArea {
				anchors.fill: parent
				onClicked: Qt.quit()

				RowLayout {
					anchors.centerIn: parent

					width: parent.width * 0.75
					height: parent.height * 0.4

					spacing: 0

					Repeater {
						model: buttons
						id: cluster
						delegate: LogoutButton {
							required property LogoutAction modelData
							required property int index

							action: modelData

							first: index === 0
							last: index === cluster.count - 1

							foregroundColor: root.foregroundColor
							buttonColor: root.buttonColor
							buttonHoverColor: root.buttonHoverColor
							boxRadius: root.boxRadius
							popupRadius: root.popupRadius

							anchors.verticalCenter: parent.verticalCenter
						}
					}
				}
			}
		}
	}
}
