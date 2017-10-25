import QtQuick 2.6
import QtQuick.Controls 2.1
import App 1.0

SpinBoxBase
{
    id: infoSpinBox
    to: 24 * 60 * 365

    validator: DoubleValidator {
        bottom: Math.min(infoSpinBox.from, infoSpinBox.to)
        top:  Math.max(infoSpinBox.from, infoSpinBox.to)
    }

    textFromValue: function(value, locale) {
        var timeMin = Math.floor( value/100 )
        var timeSec = Math.floor( ( value/100 - timeMin) * 60 );

        var secVal = Number( timeSec ).toLocaleString(locale, 'f', 0);
        if ( secVal.length < 2 )
            secVal = "0" + secVal;
        var minVal = Number( timeMin ).toLocaleString(locale, 'f', 0);
        if ( minVal.length < 2 )
            minVal = "0" + minVal;
        return  minVal + " m " +  secVal  + " s"
    }

    valueFromText: function(text, locale) {
        var posH = text.indexOf('m')
        var posM = text.indexOf('s')
        return Number.fromLocaleString(locale, text.substring(0, posH)) * 60 + Number.fromLocaleString(locale, text.substring(posH + 1, posM))
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
