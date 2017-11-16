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
        spinBoxes.chargingText = qsTr( "Charging in progress" )
        battery.initializeValues();
    }

    signal signalChargeCompleted();

    Component.onCompleted:
    {
        spinBoxes.indicatorText = false;
        spinBoxes.chargingVisible = false;
    }

    background: RowLayout  {
        spacing: 40
        anchors.centerIn: parent

        Image {
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: 240
            Layout.preferredWidth: 240
            fillMode: Image.PreserveAspectFit
            source: "Assets/Select/dial_outside_top_240x240.png"

            Text
            {
                id: infoText
                anchors.centerIn: parent
                color: "#42cc53"
                text: "00%"
                font.pixelSize: Variables.fontChargingPercentage
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }


        InfoSpinBoxes
        {
            id: spinBoxes
            Layout.preferredWidth: Variables.pixelSpinBoxWidth
            Layout.preferredHeight: 180
            Layout.alignment: Qt.AlignCenter
        }

        Battery
        {
            id: battery
            Layout.preferredWidth: 100
            Layout.preferredHeight: 280
            Layout.alignment: Qt.AlignCenter

            onChargedPercentageChanged :
            {
                updateSpinBoxes( chargedPercentage )
                azureEvent.charging = chargedPercentage;
            }

            onSignalChargeCompleted:
            {
                updateSpinBoxes( chargedPercentage )
                spinBoxes.chargingText = qsTr( "Charging Complete" )
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
    }
}
