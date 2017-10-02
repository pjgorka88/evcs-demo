import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0
import App 1.0



Item
{
    width: 300
    height: 300

    Rectangle
    {
        anchors.fill: parent
        color: "#0e1531"
        radius: 40
        opacity: 0.6
    }

    ButtonGroup { id: radioGroup }

    GridLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 20

        rows: 2
        columns: 3

        PaymentCard
        {
            checked: true
            imageName: "Assets/Payment/amex.png"
            ButtonGroup.group: radioGroup
        }

        PaymentCard {
            imageName: "Assets/Payment/discover.png"
            ButtonGroup.group: radioGroup
        }

        PaymentCard {
            imageName: "Assets/Payment/jcb.png"
            ButtonGroup.group: radioGroup
        }

        PaymentCard {
            imageName: "Assets/Payment/mastercard.png"
            ButtonGroup.group: radioGroup
        }

        PaymentCard {
            imageName: "Assets/Payment/money.png"
            ButtonGroup.group: radioGroup
        }

        PaymentCard {
            imageName: "Assets/Payment/visa.png"
            ButtonGroup.group: radioGroup
        }
    }
    Text
    {
        color: "#ffffff"
        text: qsTr("Total cost")
        font.pixelSize: Variables.fontTotalCost
        x: 30
        y: 150
    }

    Text
    {
        color: "#ffffff"
        text: Number(Variables.currentPrice / 100).toLocaleString(locale, 'f', 2) + " \u20ac"
        font.pixelSize: Variables.fontPaymentCost
        x: 30
        y: 190
    }
}
