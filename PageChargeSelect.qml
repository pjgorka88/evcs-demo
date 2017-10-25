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

    background: RowLayout  {
        spacing: 40
        anchors.centerIn: parent

        DialBase
        {
            id: dial
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: 240
            Layout.preferredWidth: 240
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
            Layout.preferredWidth: Variables.pixelSpinBoxWidth
            Layout.preferredHeight: 180
            Layout.alignment: Qt.AlignCenter

            onValueChanged:
            {
                dial.value = value;
            }
            onPriceChanged:
            {
                Variables.currentPrice = value;
            }

            Text
            {
                anchors.bottom: spinBoxes.top
                anchors.bottomMargin: 8
                color: "#fefefe"
                text: qsTr("Select charging level")
                font.pixelSize: Variables.fontSelectCharging
            }
        }

        Battery
        {
            Layout.preferredWidth: 100
            Layout.preferredHeight: 280
            Layout.alignment: Qt.AlignCenter
            topUpCharge: dial.value
        }
    }
}
