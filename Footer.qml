import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    id: footer

    signal leftButtonReleased
    signal rightButtonReleased

    property alias leftButtonText: leftButton.text
    property alias leftButtonVisible: leftButton.opacity
    property alias leftButtonEnabled: leftButton.enabled
    property alias rightButtonText: rightButton.text
    property alias rightButtonVisible: rightButton.opacity
    property alias rightButtonEnabled: rightButton.enabled
    property alias pageIndicatorcurrentIndex: pageIndicator.currentIndex
    property alias pageIndicatorcount: pageIndicator.count
    property alias pageIndicatorVisible: pageIndicator.opacity
    width: 720

    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        width: 720
        height: 64
        FooterButton {
            id: leftButton
            x: 10
            y: -25
            Layout.preferredWidth: 150
            Layout.preferredHeight: 56
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            text: qsTr("Cancel")
            buttonImage: "Assets/Buttons/blue_btn_171x42.png"
            onReleased: footer.leftButtonReleased()
        }

        PageIndicator {
            id: pageIndicator
            x: 354
            opacity: 0
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
        }

        FooterButton {
            id: rightButton
            x: 560
            y: -30
            Layout.preferredWidth: 150
            Layout.preferredHeight: 56
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            buttonImage: "Assets/Buttons/green_btn_171x42.png"
            text: qsTr("Confirm")
            onReleased: footer.rightButtonReleased()
        }
    }
    Rectangle {
        y: 60
        anchors.horizontalCenter: parent.horizontalCenter
        width: 720
        height: 381
        radius: 2
        anchors.horizontalCenterOffset: 0
        color: "#800d2e50"

        Image {
            id: logofmu
            x: 0
            anchors.horizontalCenter: parent.horizontalCenter
            width: 280
            visible: true
            fillMode: Image.PreserveAspectFit
            source: "Assets/Icons/EVCS_FMU_logo.png"
        }

        Text {
            id: welcome
            width: parent.width - 10
            height: 180
            color: "#ffffff"
            wrapMode: Text.WordWrap
            text: "Welcome to the first version of the electrical vehicle charging station. This version only supports one language and does not include support for credit cards yet. The next version will include multiple languages."
            font.family: "Verdana"
            fontSizeMode: Text.FixedSize
            x: 10
            y: 60
            font.pointSize: 8
        }

        Text {
            id: updatingmessage
            color: "#ffffff"
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Updating to a new version in 30 seconds!"
            anchors.horizontalCenterOffset: 0
            font.family: "Verdana"
            y: 305
            font.pointSize: 8
        }

        Text {
            id: step
            color: "#ffffff"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.bottomMargin: 5
            text: "Step 1/3"
            font.family: "Verdana"
            font.pointSize: 7
        }

        Rectangle {
            y: 350
            width: 400
            anchors.horizontalCenter: parent.horizontalCenter
            id: control
            height: 20
            z: 100
            radius: 10
            border.color: "#00aeea"
            visible: true
            Item {
                anchors.fill: parent
                anchors.margins: 3
                clip: true
                Row {
                    z: 10
                    Repeater {
                        Rectangle {
                            radius: 2
                            color: index % 2 ? "#ffffff" : "#00aeea"
                            width: 20 ; height: control.height
                        }
                        model: control.width / 20 + 2
                    }
                    XAnimator on x {
                        from: -40 ; to: 0
                        loops: Animation.Infinite
                        duration:350
                        running: true
                    }
                    y: 0
                }
            }

        }


    }
}
