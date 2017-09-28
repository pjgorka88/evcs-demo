pragma Singleton
import QtQuick 2.0

QtObject  {

    readonly property double initialCharge:   10
    readonly property double priceOnePercent: 0.45
    readonly property double timeOnePercent:  0.2
    readonly property double timeToComplete:  60000

    readonly property real   fontKeys:              25
    readonly property real   fontKeysText:          20
    readonly property real   bigFontPoints:         36
    readonly property real   mediumFontPoints:      30
    readonly property real   controlSpinFontPoints: 24
    readonly property real   footerButtonPoints:    20

    property double currentPrice: 0
    property double wantedCharge: 0

}
