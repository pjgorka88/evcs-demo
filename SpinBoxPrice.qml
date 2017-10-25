import QtQuick 2.6
import QtQuick.Controls 2.1
import App 1.0

SpinBoxBase
{
    id: infoSpinBox
    to: 100 * 100

    property int decimals: 2
    property real realValue: value / 100

    validator: DoubleValidator {
        bottom: Math.min(infoSpinBox.from, infoSpinBox.to)
        top:  Math.max(infoSpinBox.from, infoSpinBox.to)
    }

    textFromValue: function(value, locale) {
        var numberValue = Number(value / 100).toLocaleString(locale, 'f', infoSpinBox.decimals)
        if ( ( value / 100 ) <  10 )
            numberValue = "0" +  numberValue
        return numberValue + " \u20ac"
    }

    valueFromText: function(text, locale) {
        return Number.fromLocaleString(locale, text.substring(0, text.lenght-2)) * 100
    }

    Rectangle
    {
        color: "transparent"
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        border.color: "#41CD52"
        border.width: Variables.pixelBorderSpinBox
    }
}
