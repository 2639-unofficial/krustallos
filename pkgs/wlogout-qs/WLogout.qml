import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.impl
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
	default property list<LogoutButton> buttons

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
						if (event.key == button.keybind) button.exec();
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
						delegate: Rectangle {
							required property LogoutButton modelData
							required property int index

							id: button

							anchors.verticalCenter: parent.verticalCenter

							Layout.fillWidth: true
							Layout.fillHeight: true

							border.width: 0

							height: parent.height
							color: buttonColor
							radius: 0
							topLeftRadius:     (index == 0) ? boxRadius : 0
							bottomLeftRadius:  (index == 0) ? boxRadius : 0
							topRightRadius:    (index == cluster.count - 1) ? boxRadius : 0
							bottomRightRadius: (index == cluster.count - 1) ? boxRadius : 0

							state: ma.containsMouse ? "expanded" : ""

							states: [
								State {
									name: "expanded"
									PropertyChanges {
										target: button
										height: parent.height * 1.2
										color: buttonHoverColor
										radius: popupRadius
										topLeftRadius: popupRadius
										topRightRadius: popupRadius
										bottomLeftRadius: popupRadius
										bottomRightRadius: popupRadius
									}
								}
							]

							transitions: [
								Transition {
									from: "*"
									to: "expanded"
									NumberAnimation {
										// properties: "height,radius"
										// topLeftRadius,topRightRadius,bottomLeftRadius,bottomRightRadius
										properties: "height, radius, topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius"
										duration: 200
										easing.type: Easing.BezierSpline
										easing.bezierCurve: [
											0.2, 0.2,
											0.3, 1.7,
											1.0, 1.0
										]
									}
								},
								Transition {
									from: "expanded"
									to: "*"
									NumberAnimation {
										// properties: "height,radius"
										properties: "height, radius, topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius"
										duration: 200
										easing.type: Easing.Linear
									}
								}
							]

							// Behavior on radius {
							// 	NumberAnimation {
							// 		duration: 200
							// 		easing.type: Easing.InOutExpo
							// 	}
							// }

							MouseArea {
								id: ma
								anchors.fill: parent
								hoverEnabled: true
								onClicked: modelData.exec()
							}

							// REF: https://www.reddit.com/r/QtFramework/s/4j8YUxZVAm
							IconImage {
								id: icon
								anchors.centerIn: parent
								source: `icons/${modelData.icon}.svg`
								color: ma.containsMouse ? `${modelData.hoverColor}` : foregroundColor
								width: parent.width * 0.25
								height: parent.width * 0.25
							}

							Text {
								anchors {
									// top: icon.bottom
									// topMargin: 20
									bottom: button.bottom
									bottomMargin: 70
									horizontalCenter: parent.horizontalCenter
								}

								text: `${String.fromCharCode(modelData.keybind)}  /  ${modelData.text}`
								// font.pointSize: 16
								font.pixelSize: 16
								font.family: "monospace"
								color: ma.containsMouse ? `${modelData.hoverColor}` : foregroundColor
							}
						}
					}
				}
			}
		}
	}
}
