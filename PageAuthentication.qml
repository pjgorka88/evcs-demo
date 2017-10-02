import QtQuick 2.8
import QtQuick.Controls 2.0
import App 1.0

Page {
    id: root
    signal nextPage

    background: Item {
        anchors.horizontalCenter: parent.horizontalCenter
        y:2
        width: 760
        height: 400
        Rectangle {
            id: backRectange
            anchors.fill: parent
            color: "#B8BBC5"
            opacity: 0.5
        }

        Grid {
            anchors.centerIn: backRectange
            rows: 2
            columns: 2
            spacing: 20


            Text {
                id: text1
                text: qsTr("Username:")
                font.pixelSize: Variables.fontUserAuth
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "#0a0f2c"
            }

            AuthenticationTextInput {
                id: textInput
            }

            Text {
                id: text2
                text: qsTr("Password:")
                font.pixelSize: Variables.fontUserAuth
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "#0a0f2c"
            }

            AuthenticationTextInput {
                id: textInput1
                textField.echoMode:TextInput.Password
            }
        }
        Button {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter

            width: 350
            height: 45
            flat: true

            contentItem: Label {
                color: "#00DB52"
                text: qsTr("USER AUTHENTICATION")
                font.pixelSize: Variables.fontTapStart
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
