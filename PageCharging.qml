import QtQuick 2.8
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import App 1.0

Page {

     property alias batteryInfo: battery

     background: Item {

         InfoSpinBoxes
         {
             id: spinBoxes
             x:360
             y:103
             width:230
             height: 150

         }

         Battery
         {
             id: battery
             x: 650
             y: 40

             onChargedPercentageChanged :
             {
                 spinBoxes.setChargeValue( chargedPercentage * 100 )
                 spinBoxes.setTimeValue( ( battery.topUpCharge - chargedPercentage ) * Variables.timeOnePercent * 100 )
                 spinBoxes.setPriceValue( ( chargedPercentage - battery.initialCharge) * Variables.priceOnePercent * 100 )
             }
         }

         Text {
             x: 50
             anchors.verticalCenter: parent.verticalCenter
             color: "#ffffff"
             text: qsTr("Charging")
             font.pointSize: 36
             font.bold: true
         }
     }
}
