import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import App 1.0

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 720
    height: 1280
    title: qsTr("Electric Vehicle Charging Station")

    background: Image { fillMode: Image.Stretch; transformOrigin: Item.Center; enabled: true; source: "Assets/Background/EVCS_UI_background_800x480.jpg" }

    header: Header {
        width: 720
        height: 50
        onOpenInfo: infoPopup.open();
        onOpenMap: mapPopup.open();
        onOpenWarning: warningPopup.open();
    }

    PopupInfo
    {
        id: infoPopup
    }

    PopupMap
    {
        id: mapPopup
    }

    PopupWarning
    {
        id: warningPopup
    }

    footer: Footer {
        id: footerItem
        y: -30
        width: 720
        height: 450
        transformOrigin: Item.Center
        pageIndicatorcount: swipeView.count - 1
        onRightButtonReleased: swipeView.currentIndex == (swipeView.count-1) ? swipeView.setCurrentIndex(0) : swipeView.incrementCurrentIndex()
        onLeftButtonReleased: swipeView.decrementCurrentIndex()
    }


    SwipeView {
        id: swipeView
        anchors.fill: parent

        PagePromotionSpot
        {
            clip: true
            visible: true
            onNextPage: swipeView.incrementCurrentIndex()
        }

        PageAuthentication
        {
            id: pageAuthentication
        }

        PageChargeSelect
        {
            id: pageChargeSelect

            onDialValueChanged:
            {
                footerItem.rightButtonEnabled = ( dialValue > Variables.initialCharge );
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

        function updateText()
        {
            switch (swipeView.currentIndex)
            {
            case 0: // Promo page
                break;
            case 1:  // PageAutentification
                footerItem.leftButtonText = qsTr("Cancel")
                footerItem.rightButtonText = qsTr("Confirm")
                infoPopup.setDescription( 1 )
                break;
            case 2:  // PageChargeSelect
                footerItem.leftButtonText = qsTr("Back")
                footerItem.rightButtonText = qsTr("Confirm")
                infoPopup.setDescription( 2 )
                break;
            case 3: // PageChargeConfirm
                footerItem.rightButtonText = qsTr("Done")
                break;
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
                azureEvent.resetAll();
                break;
            case 1:  // PageAutentification
                footerItem.leftButtonVisible  = 1
                footerItem.rightButtonVisible = 1
                footerItem.rightButtonEnabled = 1
                footerItem.leftButtonEnabled  = 1
                infoPopup.setDescription( 1 )
                break;
            case 2:  // PageChargeSelect
                azureEvent.userName = "test";
                pagePayment.initializeValues();
                footerItem.leftButtonVisible = 1
                footerItem.leftButtonEnabled = 1
                footerItem.rightButtonVisible = 1
                footerItem.rightButtonEnabled = ( pageChargeSelect.dialValue > Variables.initialCharge );
                infoPopup.setDescription( 2 )
                break;
            case 3: // PageChargeConfirm
                azureEvent.cost = Variables.currentPrice;
                footerItem.leftButtonVisible = 0
                footerItem.leftButtonEnabled = 0
                footerItem.rightButtonVisible = 1
                //footerItem.rightButtonEnabled = 0 // Easier to demostrate the demo
                pageCharging.initializeValues();
                pageCharging.batteryInfo.topUpCharge = pageChargeSelect.dialValue
                pageCharging.batteryInfo.chargingStarted = true;
                pageCharging.batteryInfo.initialCharge = Variables.initialCharge
                infoPopup.setDescription( 3 )
                break;
            }
            updateText();
        }

        Component.onCompleted:
        {
            translation.languageChanged.connect(updateText);
            azureEvent.sendEvent();
        }
    }

}

/*##^##
Designer {
    D{i:8;invisible:true}
}
##^##*/
