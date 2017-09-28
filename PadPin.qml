import QtQuick 2.6
import QtQuick.Controls 2.1
import App 1.0


Button
{
    id: button
    width: 60
    height: 60
    flat: true

    property int keyId: 16
    property alias buttonText: labelItem.text
    property alias buttonColor: back.color


    background: Rectangle
    {
        id: back
        color: "#0c2b4a"
        border.width: 4
        border.color: "#000105"
        radius: 8
    }

    contentItem: Label
    {
        id: labelItem
        anchors.fill: parent
        color: "#ffffff"
        text: "0"
        font.pointSize: Variables.fontKeys
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

}
