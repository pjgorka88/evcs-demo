import QtQuick 2.8
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import App 1.0

Page {
    id: root
    property alias batteryInfo: battery

    function initializeValues()
    {
        infoText.text = qsTr( "Charging" )
        chargingText.text = qsTr( "Charging in progress" )
        battery.initializeValues();
    }

    signal signalChargeCompleted();

    Component.onCompleted:
    {
        spinBoxes.indicatorText = false;
        spinBoxes.chargingVisible = false;
    }

    background: Item {

        Image {
            x: 40
            y: 60
            width: 554
            height: 240
            fillMode: Image.PreserveAspectFit
            source: "Assets/Select/EVCS_dial_554x220_top.png"
        }

        InfoSpinBoxes
        {
            id: spinBoxes
            x:360
            y:103
            width:230
            height: 150

            Text
            {
                id: chargingText
                color: "#42cc53"
                text: qsTr( "Charging in progress" )
                width: 230
                height: 34
                x: 20
                font.pixelSize: Variables.fontChargingProgress
                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
            }

        }

        Battery
        {
            id: battery
            x: 650
            y: 40

            onChargedPercentageChanged :
            {
                updateSpinBoxes( chargedPercentage )
            }

            onSignalChargeCompleted:
            {
                updateSpinBoxes( chargedPercentage )
                chargingText.text = qsTr( "Charging Complete" )
                root.signalChargeCompleted();
            }

            function updateSpinBoxes( value )
            {
                var strvalue = Number(Math.floor(value)).toLocaleString(locale, 'f', 0) + "%";
                if ( value < 10 )
                    strvalue = "0" + strvalue;
                infoText.text = strvalue;
                spinBoxes.setChargeValue( value * 100 )
                spinBoxes.setTimeValue( ( battery.topUpCharge - value ) * Variables.timeOnePercent * 100 )
                spinBoxes.setPriceValue( ( value - battery.initialCharge) * Variables.priceOnePercent * 100 )
            }
        }

        Text
        {
            id: infoText
            x: 110
            anchors.verticalCenter: parent.verticalCenter
            color: "#42cc53"
            text: "00%"
            font.pixelSize: Variables.fontChargingPercentage
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
