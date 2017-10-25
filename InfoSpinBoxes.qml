import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import App 1.0

Item {
    id: root
    signal valueChanged( real value );
    signal priceChanged( real value );

    property bool indicatorText: true;

    property alias chargingVisible: chargeSpinBox.visible
    property alias chargingText: chargingText.text

    function setChargeValue( value )
    {
        chargeSpinBox.from  = value;
        chargeSpinBox.to    = value;
        chargeSpinBox.value = value;
    }

    function setTimeValue( value )
    {
        timeSpinBox.from  = value;
        timeSpinBox.to    = value;
        timeSpinBox.value = value;
    }

    function setPriceValue( value )
    {
        priceSpinBox.from  = value;
        priceSpinBox.to    = value;
        priceSpinBox.value = value;
    }

    Component.onCompleted:
    {
        chargeSpinBox.from = Variables.initialCharge * 100
    }

    function updateValues( value )
    {
        setSizeStep( 100 )

        chargeSpinBox.updateValue( value );
        timeSpinBox.updateValue( value );
        priceSpinBox.updateValue( value );
    }

    function setSizeStep( value )
    {
        chargeSpinBox.stepSize = value;
        timeSpinBox.stepSize   = Variables.timeOnePercent * value
        priceSpinBox.stepSize  = Variables.priceOnePercent * value
    }

    ColumnLayout
    {
        spacing: 30
        id: spinBoxColumn

        Rectangle
        {
            color: "#0b2a4a"
            border.color: "#41CD52"
            border.width: Variables.pixelBorderSpinBox
            Layout.preferredWidth: Variables.pixelSpinBoxWidth
            height: Variables.pixelSpinBoxButton
            visible: !root.chargingVisible

            Text
            {
                id: chargingText
                color: "#42cc53"
                height: Variables.pixelSpinBoxButton
                text: qsTr( "Charging in progress" )
                font.pixelSize: Variables.fontChargingProgress
                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
                x:20
            }
        }

        SpinBoxNumber
        {
            Layout.preferredWidth: Variables.pixelSpinBoxWidth
            id: chargeSpinBox
            indicatorText: root.indicatorText
            function updateValue( inValue )
            {
                chargeSpinBox.value = inValue * 100
            }

            onValueModified:
            {
                var sendValue = value / 100;
                root.valueChanged( sendValue )
                timeSpinBox.updateValue( sendValue )
                priceSpinBox.updateValue( sendValue )
            }
        }

        SpinBoxTime
        {
            id: timeSpinBox
            indicatorText: root.indicatorText
            Layout.preferredWidth: Variables.pixelSpinBoxWidth

            function updateValue( inValue )
            {
                var chargeToAdd = inValue - Variables.initialCharge
                timeSpinBox.value = chargeToAdd * Variables.timeOnePercent * 100
            }

            onValueModified:
            {
                var chargeToAdd  = value / ( Variables.timeOnePercent * 100 )
                var sendValue = chargeToAdd + Variables.initialCharge;
                root.valueChanged(  sendValue )
                chargeSpinBox.updateValue( sendValue )
                priceSpinBox.updateValue( sendValue )

            }
        }

        SpinBoxPrice
        {
            id: priceSpinBox
            indicatorText: root.indicatorText
            stepSize: Variables.timeOnePercent * 100
            Layout.preferredWidth: Variables.pixelSpinBoxWidth

            function updateValue( inValue )
            {
                var chargeToAdd = inValue - Variables.initialCharge
                priceSpinBox.value = chargeToAdd * Variables.priceOnePercent * 100
            }

            onValueChanged:
            {
                priceChanged( value )
            }

            onValueModified:
            {
                var chargeToAdd  = value / ( Variables.priceOnePercent * 100 )
                var sendValue = chargeToAdd + Variables.initialCharge;
                root.valueChanged( sendValue )
                chargeSpinBox.updateValue( sendValue )
                timeSpinBox.updateValue( sendValue )
            }
        }

    }

    Text
    {
        anchors.top: spinBoxColumn.bottom
        anchors.topMargin: 8
        color: "#979eb6"
        text: qsTr("Charging Rate")+ " 200 Mi/hr 355V 191A"
        font.pixelSize: Variables.fontChargingRate
    }

}

