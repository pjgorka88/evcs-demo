import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.VirtualKeyboard 2.1
import App 1.0

ApplicationWindow {
    visible: true
    width: 800
    height: 480
    title: qsTr("Electric Vehicle Charging Station")

    background: Image { source: "Assets/Background/EVCS_UI_background_800x480.jpg" }

    header: Header {
            height: 50
               /* onOpenInfo:
                {
                    popup.open();
                }*/
        }

    footer: Footer {
        id: footerItem
        height: 63
        visible: swipeView.currentIndex /*|| swipeView.currentIndex == 2 ? 0 : 1*/
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
            onPaymentAccepted:
            {
                footerItem.rightButtonEnabled = 1;
            }
        }

        PageCharging
        {
            id: pageCharging
        }

        onCurrentIndexChanged: {
            footerItem.pageIndicatorcurrentIndex = swipeView.currentIndex - 1

            switch (swipeView.currentIndex)
            {
            case 1:  // PageChargeSelect
                footerItem.leftButtonVisible = 1
                footerItem.leftButtonEnabled = 1
                footerItem.leftButtonText = qsTr("Cancel")
                footerItem.rightButtonVisible = 1
                footerItem.rightButtonEnabled = ( pageChargeSelect.dialValue > Variables.initialCharge );
                footerItem.rightButtonText = qsTr("Confirm")
                break;
            case 2: // PagePayment
                footerItem.leftButtonVisible = 1
                footerItem.leftButtonEnabled = 1
                footerItem.leftButtonText = qsTr("Back")
                footerItem.rightButtonVisible = 1
                footerItem.rightButtonEnabled = 0
                footerItem.rightButtonText = qsTr("Continue")
                break;
            case 3: // PageChargeConfirm
                footerItem.leftButtonVisible = 0
                footerItem.leftButtonEnabled = 0
                footerItem.rightButtonVisible = 1
                footerItem.rightButtonEnabled = 0
                footerItem.rightButtonText = qsTr("Done")
                pageCharging.batteryInfo.topUpCharge = Math.floor( pageChargeSelect.dialValue )
                pageCharging.batteryInfo.chargingStarted = true;
                pageCharging.batteryInfo.initialCharge = Variables.initialCharge
                pageCharging.batteryInfo.initializeValues();
                break;
            }
        }

    }

}
