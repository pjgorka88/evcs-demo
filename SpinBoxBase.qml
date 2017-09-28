import QtQuick 2.6
import QtQuick.Controls 2.1
import App 1.0

SpinBox {
    id: control
    value: 0
    editable: true
    width: 230
    height: 34
    font.pointSize: Variables.controlSpinFontPoints

    property bool indicatorText: true;

    contentItem: Rectangle
    {
        anchors.fill:parent
        color: "#0b2a4a"
        Text {
            anchors.fill: parent
            z: 4
            text: control.textFromValue(control.value, control.locale)

            leftPadding: 45
            font: control.font
            color: "#42cc53"
            horizontalAlignment: Qt.AlignLeft
            verticalAlignment: Qt.AlignVCenter
        }
    }

    up.indicator: Rectangle {
        x: control.mirrored ? 0 : parent.width - width
        height: parent.height
        implicitWidth: 34
        implicitHeight: 34
        color: "#0a0f2c"
        border.color: "#0b2a4a"

        Text {
            visible: control.indicatorText
            text: "+"
            font.pixelSize: control.font.pixelSize * 2
            color: "#fefefe"
            anchors.fill: parent
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    down.indicator: Rectangle {
        x: control.mirrored ? parent.width - width : 0
        height: parent.height
        implicitWidth: 34
        implicitHeight: 34
        color: "#0a0f2c"
        border.color: "#0b2a4a"

        Text {
            visible: control.indicatorText
            text: "-"
            font.pixelSize: control.font.pixelSize * 2
            color: "#fefefe"
            anchors.fill: parent
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    background: Rectangle {
        border.color: "#0b2a4a"
    }


}
