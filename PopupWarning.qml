import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import App 1.0

Popup {
    id: popup
    width: 680
    scale: 1
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape
    leftMargin: 80
    topPadding: 50
    leftPadding: 20
    rightPadding: 140


    background: Image {
        id: backImage
        width: 550
        height: 368
        fillMode: Image.PreserveAspectFit
        source: "Assets/Background/EVCS_infobox_550x368.png"
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                if ( mouse.x > 485 && mouse.x < 524 && mouse.y > 17 && mouse.y < 56 )
                    popup.close();
            }
        }
    }

    contentItem: Item {
        ColumnLayout {
            x: 227
            anchors.verticalCenterOffset: -51
            anchors.horizontalCenterOffset: -9
            anchors.centerIn: parent
            SwitchBase {
                text: qsTr("Wi-Fi")

                onSignalError: console.log( "WifiErrror" );
            }
            SwitchBase {
                text: qsTr("Bluetooth")
            }
            SwitchBase {
                text: qsTr("Connection")
            }
            SwitchBase {
                text: qsTr("Unknown")
                Layout.fillWidth: false
            }
        }
    }
}
