import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import LongUI 1.0 as LongUI

Item {
    id: control

    signal clicked(string text)

    property string text
    property var icon
    property alias textColor: _label.color
    property bool flat: false

    Layout.fillWidth: true
    Layout.fillHeight: true

    property color backgroundColor: LongUI.Theme.backgroundColor
    property color hoveredColor: LongUI.Theme.darkMode ? Qt.lighter(LongUI.Theme.backgroundColor, 1.7)
                                                       : Qt.darker(LongUI.Theme.backgroundColor, 1.1)
    property color pressedColor: LongUI.Theme.darkMode ? Qt.lighter(LongUI.Theme.backgroundColor, 1.4)
                                                       : Qt.darker(LongUI.Theme.backgroundColor, 1.3)

    property color flatBg: LongUI.Theme.highlightColor
    property color flatHoveredBg: LongUI.Theme.darkMode ? Qt.lighter(LongUI.Theme.highlightColor, 1.1)
                                                        : Qt.darker(LongUI.Theme.highlightColor, 1.1)
    property color flatPressedBg: LongUI.Theme.darkMode ? Qt.lighter(LongUI.Theme.highlightColor, 1.05)
                                                        : Qt.darker(LongUI.Theme.highlightColor, 1.3)

    Rectangle {
        id: _background
        anchors.centerIn: parent
        radius: LongUI.Theme.smallRadius
        width: control.width - radius
        height: control.height - radius
        color: !flat ? _mouseArea.pressed ? pressedColor : _mouseArea.containsMouse
                                            ? hoveredColor : backgroundColor
                     : _mouseArea.pressed ? flatPressedBg : _mouseArea.containsMouse
                                                           ? flatHoveredBg : flatBg
        opacity: !flat ? _mouseArea.pressed || _mouseArea.containsMouse ? 0.6 : 0.7 : 1.0
    }

    MouseArea {
        id: _mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: control.clicked(control.text)
    }

    Image {
        id: _icon
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: control.height * 0.45
        height: width
        sourceSize: Qt.size(width, height)
        source: control.icon ? control.icon : ""
        visible: _icon.status === Image.Ready
        smooth: false
        antialiasing: true
    }

    Label {
        id: _label
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Layout.minimumWidth: parent.width
        horizontalAlignment: Text.AlignHCenter
        color: !flat ? LongUI.Theme.textColor : LongUI.Theme.highlightedTextColor
        text: control.text
        visible: !_icon.visible
        minimumPointSize: Math.round(control.height / 5)
        font.pointSize: Math.round(control.height / 5)
    }
}
