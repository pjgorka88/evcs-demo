import QtQuick 2.6
import QtQuick.Controls 2.1
import App 1.0

Page
{
    id: root
    signal paymentAccepted
    signal paymentCanceled
    signal helpPage

    function initializeValues()
    {
        padLabel.clear();
        pinNumberItem.padOpacity = 1;
        payment.paymentEnabled = true;
    }

    background: Row
    {
        anchors.centerIn: parent
        spacing: 30

        Item // The payment method item
        {
            width: childrenRect.width
            height: childrenRect.height
            Text
            {
                id: paymentText
                color: "#ffffff"
                text: qsTr("Payment method")
                font.pixelSize: Variables.fontPayment
                x: 40
            }
            PaymentType
            {
               id: payment
               anchors.top: paymentText.bottom
               anchors.topMargin: 5;

               onCardPayment:
               {
                   padLabel.clear();
                   pinNumberItem.padOpacity = 1;

               }
               onCashPayment:
               {
                   pinNumberItem.padOpacity = 0;
                   pad.confirmText =  qsTr("Insert money");
                   root.paymentAccepted()
               }
            }
        }

        Item // The pin number item
        {
            id: pinNumberItem
            width: pad.width
            height: padLabel.height + pad.height

            property real padOpacity: 1
            Behavior on padOpacity { NumberAnimation { duration: 300 } }

            Text
            {
                id: textEnterPIN
                font.pixelSize: Variables.fontPayment
                color: "#ffffff"
                text: qsTr("Enter PIN-number:")
                x: 40
                opacity: pinNumberItem.padOpacity;

            }

            PadLabel
            {
                id: padLabel
                anchors.left: textEnterPIN.right
                anchors.top: textEnterPIN.top
                anchors.bottom: textEnterPIN.bottom
                anchors.leftMargin: 10
                opacity: pinNumberItem.padOpacity;

                onPinAccepted:
                {
                    pad.confirmText =  qsTr("Payment\nAccepted");
                    pinNumberItem.padOpacity = 0;
                    root.paymentAccepted();
                    payment.paymentEnabled = false;
                }

                onPinCaneled:
                {
                    pinNumberItem.padOpacity = 1;
                    root.paymentCanceled();
                }
            }

            PadType
            {
                id: pad
                anchors.top: textEnterPIN.bottom
                anchors.topMargin: 5;
                padOpacity: pinNumberItem.padOpacity;

                onPressedButton:
                {
                    updateTextField( keyId )
                }

                function updateTextField( keyId )
                {
                    switch (keyId) {
                    case 10: padLabel.cancelButton(); break;
                    case 11: padLabel.removeText(); break;
                    case 12: root.helpPage(); break;
                    case 13: padLabel.acceptedButton(); break;
                    case 14: break;
                    case 15: break;
                    case 16: break;
                    default: padLabel.insertText(keyId); break;
                    }
                }
            }
        }
    }
}
