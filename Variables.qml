pragma Singleton
import QtQuick 2.0

QtObject  {

    readonly property double initialCharge:   10
    readonly property double priceOnePercent: 0.45
    readonly property double timeOnePercent:  0.2
    readonly property double timeToComplete:  60000

    readonly property real   fontHeader: 30
    readonly property real   fontFooterButton: 25
    readonly property real   fontTapStart: 18
    readonly property real   fontUserAuth: 30
    readonly property real   fontUserAuth2: 20
    readonly property real   fontSelectCharging: 20
    readonly property real   fontChargingRate: 16
    readonly property real   fontControlSpinBox: 25
    readonly property real   fontKeys: 35
    readonly property real   fontKeysText: 30
    readonly property real   fontPayment: 20
    readonly property real   fontInfo: 30
    readonly property real   fontPaymentPin: 25
    readonly property real   fontTotalCost: 25
    readonly property real   fontPaymentCost: 50
    readonly property real   fontChargingProgress: 20
    readonly property real   fontChargingPercentage: 60

    property double currentPrice: 0
    property double wantedCharge: 0

}
