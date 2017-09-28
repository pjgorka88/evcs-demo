import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.VirtualKeyboard 2.1
import App 1.0

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 800
    height: 480
    title: qsTr("Electric Vehicle Charging Station")

    background: Image { source: "Assets/Background/EVCS_UI_background_800x480.jpg" }

    header: Header {
        height: 50
         onOpenInfo:
         {
            infoPopup.open();
         }

         onOpenMap:
         {
             mapPopup.open();
         }
    }

    PopupInfo
    {
        id: infoPopup
    }

    PopupMap
    {
        id: mapPopup
    }

    footer: Footer {
        id: footerItem
        height: 63
        pageIndicatorcount: swipeView.count - 1
        onRightButtonReleased: swipeView.currentIndex == 3 ? swipeView.setCurrentIndex(0) : swipeView.incrementCurrentIndex()
        onLeftButtonReleased: swipeView.decrementCurrentIndex()
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        interactive: false

        PagePromotionSpot
        {
            onNextPage: swipeView.incrementCurrentIndex()
        }

        PageChargeSelect
        {
            id: pageChargeSelect

            onDialValueChanged:
            {
                footerItem.rightButtonEnabled = ( dialValue > Variables.initialCharge );
            }
        }

        PagePayment
        {
            id: pagePayment
            onPaymentAccepted:
            {
                footerItem.rightButtonEnabled = 1;
            }
        }

        PageCharging
        {
            id: pageCharging

            onSignalChargeCompleted :
            {
                footerItem.rightButtonEnabled = 1
            }
        }

        onCurrentIndexChanged: {
            footerItem.pageIndicatorcurrentIndex = swipeView.currentIndex - 1
            footerItem.pageIndicatorVisible = swipeView.currentIndex > 0;

            switch (swipeView.currentIndex)
            {
            case 0: // Promo page
                footerItem.leftButtonVisible  = 0
                footerItem.rightButtonVisible = 0
                pageChargeSelect.initializeValues();
                pagePayment.initializeValues();
                infoPopup.setDescription( 0 )
                break;
            case 1:  // PageChargeSelect
                footerItem.leftButtonVisible = 1
                footerItem.leftButtonEnabled = 1
                footerItem.leftButtonText = qsTr("Cancel")
                footerItem.rightButtonVisible = 1
                footerItem.rightButtonEnabled = ( pageChargeSelect.dialValue > Variables.initialCharge );
                footerItem.rightButtonText = qsTr("Confirm")
                infoPopup.setDescription( 1 )
                break;
            case 2: // PagePayment
                footerItem.leftButtonVisible = 1
                footerItem.leftButtonEnabled = 1
                footerItem.leftButtonText = qsTr("Back")
                footerItem.rightButtonVisible = 1
                footerItem.rightButtonEnabled = 0
                footerItem.rightButtonText = qsTr("Continue")
                infoPopup.setDescription( 2 )
                break;
            case 3: // PageChargeConfirm
                footerItem.leftButtonVisible = 0
                footerItem.leftButtonEnabled = 0
                footerItem.rightButtonVisible = 1
                footerItem.rightButtonEnabled = 0
                footerItem.rightButtonText = qsTr("Done")
                pageCharging.batteryInfo.topUpCharge = pageChargeSelect.dialValue
                pageCharging.batteryInfo.chargingStarted = true;
                pageCharging.batteryInfo.initialCharge = Variables.initialCharge
                pageCharging.batteryInfo.initializeValues();
                infoPopup.setDescription( 3 )
                break;
            }
        }

    }

}
