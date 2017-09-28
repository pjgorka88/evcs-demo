import QtQuick 2.9
import QtQuick.Controls 2.0

Page {
    id: root

    signal nextPage

    background: Item {
        anchors.centerIn: parent
        width: 760
        height: 400
        Rectangle {
            anchors.fill: parent
            color: "#B8BBC5"
            opacity: 0.5
        }
        Button {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter

            width: 320
            height: 45

            flat: true

            contentItem: Label {
                color: "#00DB52"
                text: qsTr("TAP TO START")
                font.pixelSize: 18
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            background: Rectangle {
                anchors.fill: parent
                color: "#0E1039"
            }
            onReleased: root.nextPage()
        }
    }
}
