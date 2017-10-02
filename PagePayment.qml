import QtQuick 2.6
import QtQuick.Controls 2.1
import App 1.0

Page
{
    id: root
    signal paymentAccepted

    function initializeValues()
    {
        textField.clear();
    }

    background: Item
    {

        Text
        {
            color: "#ffffff"
            text: qsTr("Payment method")
            font.pixelSize: Variables.fontPayment
            x: 80
            y: 35
        }
        PaymentType
        {
            id: payment
            x: 40
            y: 70
        }

        Text
        {
            id: textEnterPIN
            font.pixelSize: Variables.fontPayment
            color: "#ffffff"
            text: qsTr("Enter PIN-number:")
            x: 410
            y: 35
        }

        Rectangle
        {
            anchors.left: textEnterPIN.right
            anchors.top: textEnterPIN.top
            anchors.bottom: textEnterPIN.bottom
            anchors.leftMargin: 10
            border.width: 2
            color: "transparent"
            radius: 5
            width: 120
            Label
            {
                anchors.fill: parent
                id: textField
                color: "#ffffff"
                text: ""
                font.pixelSize: Variables.fontPaymentPin
                horizontalAlignment: TextInput.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                function clear()
                {
                    text = "";
                }

                function insertText( keyId ) {
                    if ( textField.text.length < 4 )
                        textField.text = textField.text + "x";
                }

                function removeText() {
                    var len = textField.text.length;
                    console.log( len )
                    if ( len > 0 )
                        textField.text = textField.text.substring(0, len - 1);
                }
            }
        }

        PadType
        {
            id: pad
            anchors.verticalCenter:  payment.verticalCenter
            anchors.left: payment.right
            anchors.leftMargin: 40
            onPressedButton:
            {
                updateTextField( keyId )
            }

            function updateTextField( keyId )
            {
                switch (keyId) {
                case 10: textField.clear(); break;
                case 11: textField.removeText(); break;
                case 12: break;
                case 13: root.paymentAccepted(); break;
                case 14: break;
                case 15: break;
                case 16: break;
                default: textField.insertText(keyId); break;
                }
            }
        }
    }
}
