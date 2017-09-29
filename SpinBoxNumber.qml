import QtQuick 2.6
import QtQuick.Controls 2.1

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
        return Number(value / 100).toLocaleString(locale, 'f', infoSpinBox.decimals) + "%"
    }

    valueFromText: function(text, locale) {
        return Number.fromLocaleString(locale, text.substring(0, text.lenght-1)) * 100
    }
}
