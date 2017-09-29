import QtQuick 2.6
import QtQuick.Controls 2.1
import App 1.0


Rectangle
{

    property alias textField: textFieldItem
    width: 200
    height: 40
    color: "#0b2a4a"
    border.color: "#0a0f2c"
    radius: 10
    TextInput
    {
        id: textFieldItem
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.topMargin: 5
        //text: qsTr("Enter")
        font.pixelSize: 20
        color: "#42cc53"
    }
}
