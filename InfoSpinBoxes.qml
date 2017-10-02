import QtQuick 2.6
import QtQuick.Controls 2.1
import App 1.0

Item {
    id: root
    signal valueChanged( real value );
    signal priceChanged( real value );

    property bool indicatorText: true;

    property alias chargingVisible: chargeSpinBox.visible

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

    SpinBoxNumber
    {
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
        y: 60

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
        y: 119
        stepSize: Variables.timeOnePercent * 100

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

    Text
    {
        y: 170
        color: "#979eb6"
        text: qsTr("Charging Rate")+ " 200 Mi/hr 355V 191A"
        font.pixelSize: Variables.fontChargingRate
    }

}

