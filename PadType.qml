import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0
import App 1.0


Item
{
    id: root
    width: 380
    height: 300
    property real padOpacity: 1
    property alias confirmText: confirmText.text

    signal pressedButton(int keyId)

    Rectangle
    {
        anchors.fill: parent
        color: "#0e1531"
        radius: 40
        opacity: 0.6
    }

    Text
    {
        id: confirmText
        anchors.centerIn: parent;
        color: "#ffffff"
        text: qsTr("Payment\nAccepted")
        font.pixelSize: Variables.fontPaymentCost
        opacity: 1 - root.padOpacity;
    }

    Row
    {
        x: 20
        y: 20
        spacing: 10
        opacity: root.padOpacity;
        Column
        {
            spacing: 10
            PadPin
            {
                keyId: 7
                buttonText: "7"
                onPressed: pressedButton(keyId)
            }

            PadPin
            {
                keyId: 4
                buttonText: "4"
                onPressed: pressedButton(keyId)
            }

            PadPin
            {
                keyId: 1
                buttonText: "1"
                onPressed: pressedButton(keyId)
            }
        }
        Column
        {
            spacing: 10
            PadPin
            {
                keyId: 8
                buttonText: "8"
                onPressed: pressedButton(keyId)
            }

            PadPin
            {
                keyId: 5
                buttonText: "5"
                onPressed: pressedButton(keyId)
            }

            PadPin
            {
                keyId: 2
                buttonText: "2"
                onPressed: pressedButton(keyId)
            }

            PadPin
            {
                keyId: 0
                buttonText: "0"
                onPressed: pressedButton(keyId)
            }
        }
        Column
        {
            spacing: 10
            PadPin
            {
                keyId: 9
                buttonText: "9"
                onPressed: pressedButton(keyId)
            }

            PadPin
            {
                keyId: 6
                buttonText: "6"
                onPressed: pressedButton(keyId)
            }

            PadPin
            {
                keyId: 3
                buttonText: "3"
                onPressed: pressedButton(keyId)
            }
        }

        Column
        {
            spacing: 10
            PadPin
            {
                keyId: 10
                fontSize: Variables.fontKeysText
                buttonText: qsTr("Cancel")
                buttonColor: "#ce0203"
                width: 130
                onPressed: pressedButton(keyId)
            }

            PadPin
            {
                keyId: 11
                fontSize: Variables.fontKeysText
                buttonText: qsTr("Correct")
                buttonColor: "#d1a601"
                width: 130
                onPressed: pressedButton(keyId)
            }

            PadPin
            {
                keyId: 12
                fontSize: Variables.fontKeysText
                buttonText: qsTr("Help")
                buttonColor: "#0e6bcb"
                width: 130
                onPressed: pressedButton(keyId)
            }
            PadPin
            {
                keyId: 13
                fontSize: Variables.fontKeysText
                buttonText: qsTr("Enter")
                buttonColor: "#65cd52"
                width: 130
                onPressed: pressedButton(keyId)
            }
        }
    }
}
