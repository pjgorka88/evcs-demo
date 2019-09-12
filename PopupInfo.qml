import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import App 1.0

Popup {
    id: popup
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape
    leftMargin: 80
    topPadding: 50
    leftPadding: 20
    rightPadding: 140

    function setDescription( index )
    {
        textId.text = decriptions[index];
    }

    property variant decriptions:
        [
        qsTr( "Please tap to start for entering your credentials and start charging your car" ),
        qsTr( "Please enter your credential in the system" ),
        qsTr( "Please set the charge that you want achieve using the rotational Knob" ),
        qsTr( "Please add your pin number in order to start the charge" ),
        qsTr( "Charging information status" )
    ]
    width: 680


    Component.onCompleted:
    {
        setDescription( 0 )
    }


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

    contentItem: Text {
        id: textId
        color: "#ffffff"
        font.pixelSize: Variables.fontInfo
        wrapMode: Text.WordWrap
        text: ""
    }
}
