import QtQuick 2.8
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import App 1.0

Page {

    Component.onCompleted: initializeValues()

    property alias dialValue: dial.value

    function initializeValues()
    {
        dial.value = Variables.initialCharge
        spinBoxes.updateValues( dial.value )
    }

    background: Item {
        Image {
            x: 40
            y: 60
            width: 554
            height: 240
            fillMode: Image.PreserveAspectFit
            source: "Assets/Select/EVCS_dial_554x220.png"
        }

        Image {
            x: 150
            y: 160
            width: 20
            height: 40
            fillMode: Image.PreserveAspectFit
            source: "Assets/Select/EVCS_charge_icon_20x40.png"
        }

        Text
        {
            anchors.bottom: spinBoxes.top
            anchors.bottomMargin: 20
            anchors.left: spinBoxes.left
            color: "#fefefe"
            text: qsTr("Select charging level")
            font.pointSize: 16
        }

        DialBase
        {
            id: dial
            x: 40
            y: 60
            width: 240
            height: 240
            from: 0
            to: 100
            onMoved:
            {
                if ( value < Variables.initialCharge )
                    value = Variables.initialCharge
                spinBoxes.updateValues( value )
            }

            onValueChanged:
            {
                Variables.wantedCharge = value;
            }
        }

        InfoSpinBoxes
        {
            id: spinBoxes
            x:360
            y:103
            width:230
            height: 150

            onValueChanged:
            {
                dial.value = value;
            }
            onPriceChanged:
            {
                Variables.currentPrice = value;
            }
        }

        Battery
        {
            id: batt
            x: 650
            y: 40
            topUpCharge: dial.value
        }
    }
}
