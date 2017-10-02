import QtQuick 2.6
import QtQuick.Controls 2.1
import App 1.0


Rectangle
{
    property alias textField: textFieldItem
    width: 250
    height: 45
    color: "#0b2a4a"
    border.color: "#0a0f2c"
    radius: 15
    TextInput
    {
        id: textFieldItem
        anchors.fill: parent
        anchors.leftMargin: 10
        text: qsTr("Test")
        font.pixelSize: Variables.fontUserAuth2
        verticalAlignment: Text.AlignVCenter
        color: "#42cc53"
    }
}
