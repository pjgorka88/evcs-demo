import QtQuick 2.9
import QtQuick.Controls 2.0
import App 1.0

Button {
    id: button

    property alias buttonImage: backImage.source

    height: 53
    width: 150
    font.pointSize: Variables.footerButtonPoints
    flat: true
    opacity: 0

    contentItem: Label {
        color: "#ffffff"
        text: button.text
        font: button.font
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    background:
    Item
    {
        Image {
            visible: enabled
            id: backImage
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: "Assets/Buttons/blue_btn_171x42.png"
        }
        Image {
            visible: !enabled
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: "Assets/Buttons/grey_btn_171x42.png"
        }

    }

    Behavior on opacity
    {
        NumberAnimation { duration: 50 }
    }
}
