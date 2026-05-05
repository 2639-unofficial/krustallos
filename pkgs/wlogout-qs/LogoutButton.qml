import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.impl

Rectangle {
	id: button

	required property LogoutAction action

	property bool first: false
	property bool last: false

	required property color foregroundColor
	required property color buttonColor
	required property color buttonHoverColor
	required property int boxRadius
	required property int popupRadius

	readonly property bool isActive: ma.containsMouse || action.isActive
	readonly property color fgColor: isActive ? `${action.accentColor}` : foregroundColor

	Layout.fillWidth: true
	Layout.fillHeight: true

	border.width: 0
	height: parent.height
	color: buttonColor

	radius: 0
	topLeftRadius:    first ? boxRadius : 0
	bottomLeftRadius: first ? boxRadius : 0
	topRightRadius:    last ? boxRadius : 0
	bottomRightRadius: last ? boxRadius : 0

	state: isActive ? "expanded" : ""

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
				properties: "height, radius, topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius"
				duration: 200
				easing.type: Easing.Linear
			}
		}
	]

	MouseArea {
		id: ma
		anchors.fill: parent
		hoverEnabled: true
		onClicked: action.exec()
	}

	// REF: https://www.reddit.com/r/QtFramework/s/4j8YUxZVAm
	IconImage {
		id: icon
		anchors.centerIn: parent
		source: `icons/${action.icon}.svg`
		color: fgColor
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

		text: `${String.fromCharCode(action.keybind)}  /  ${action.text}`
		font.pixelSize: 16
		font.family: "monospace"
		color: fgColor
	}
}
