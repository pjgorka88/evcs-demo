import QtQuick 2.6
import QtQuick.Controls 2.1

SpinBoxBase
{
    id: infoSpinBox

    textFromValue: function(value, locale) {

        var numberValue = Number( value ).toLocaleString(locale, 'f', 2);
        if ( value <  10 )
            numberValue = "0"+  numberValue
        console.log( numberValue )
        return numberValue
    }

    valueFromText: function(text, locale) {
        console.log(text.substring(0, text.lenght-2) )
        return  text.substring(0, text.lenght-2)
    }
}
