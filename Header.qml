import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import App 1.0

Item {

    id: header
    signal openInfo
    signal openMap
    signal openWarning

// Left Positioner
    RowLayout
    {
        anchors.left: parent.left
        height: 50
        Image {
            Layout.preferredWidth: 41
            Layout.preferredHeight: 31
            Layout.leftMargin: 20
            source: "Assets/Icons/EVCS_Qt_logo_41x31.png"
        }

        Label {
            Layout.preferredWidth: 300
            Layout.preferredHeight: 31
            Layout.leftMargin: 10
            verticalAlignment: Text.AlignVCenter
            color: "#ffffff"
            text: qsTr("Electric charging station in a RUNC container")
            font.pixelSize: Variables.fontHeader
            font.bold: true
        }
    }

// Right Positioner

    RowLayout
    {
        anchors.right: parent.right
        height: 50
        spacing: 15
        ComboBox
        {
            Layout.preferredWidth: 110
            Layout.preferredHeight: 31


            id: control
            model: ["Assets/Icons/EVCS_icon_flag_UK_53x31.png", "Assets/Icons/EVCS_icon_flag_FR_53x31.png",
                    "Assets/Icons/EVCS_icon_flag_DE_53x31.png", "Assets/Icons/EVCS_icon_flag_IT_53x31.png"]

            delegate: ItemDelegate {
                contentItem:
                Image {
                        width: 53
                        height: 31
                        fillMode: Image.PreserveAspectFit
                        source: modelData
                    }
            }

            indicator: Canvas {
                id: canvas
                x: control.width - width - control.rightPadding
                y: control.topPadding + (control.availableHeight - height) / 2
                width: 12
                height: 8
                contextType: "2d"

                Connections {
                    target: control
                    onPressedChanged: canvas.requestPaint()
                }

                onPaint: {
                    context.reset();
                    context.moveTo(0, 0);
                    context.lineTo(width, 0);
                    context.lineTo(width / 2, height);
                    context.closePath();
                    context.fillStyle = "#ffffff";
                    context.fill();
                }
            }

            contentItem:
                Image {
                    width: 53
                    height: 31
                        fillMode: Image.PreserveAspectFit
                        source: control.displayText
                    }


            background: Rectangle {
                implicitWidth: 120
                implicitHeight: 31
                color: "#09102C"
                border.color: control.pressed ? "#17a81a" : "#21be2b"
                border.width: 0
                radius: 2
            }

            popup: Popup {
                y: control.height +2
                width: control.width
                implicitHeight: contentItem.implicitHeight
                padding: 1

                contentItem: ListView {
                    clip: true
                    implicitHeight: contentHeight
                    model: control.popup.visible ? control.delegateModel : null
                    currentIndex: control.highlightedIndex

                    ScrollIndicator.vertical: ScrollIndicator { }
                }

                background: Rectangle {
                    color: "#09102C"
                    border.color: "#21be2b"
                     border.width: 0
                    radius: 2
                }
            }

            onActivated:
            {
                if ( index === 1 )
                    translation.selectLanguage( "fr" );
                else if ( index === 2 )
                    translation.selectLanguage( "de" );
                else if ( index === 3 )
                    translation.selectLanguage( "it" );
                else
                    translation.selectLanguage( "en" );
            }
        }

        Button
        {
            Layout.preferredWidth: 31
            Layout.preferredHeight: 31
            background: Image {
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                source: "Assets/Icons/EVCS_icon_map_31x31.png"
            }
            flat: true
            onClicked: header.openMap();
        }


        Button
        {
            Layout.preferredWidth: 38
            Layout.preferredHeight: 31
            background: Image {
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                source: "Assets/Icons/EVCS_icon_attention_30x31.png"
            }
            flat: true
            onClicked: header.openWarning();
        }

        Button
        {
            Layout.preferredWidth: 30
            Layout.preferredHeight: 31
            Layout.rightMargin: 20
            background: Image {
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                source: "Assets/Icons/EVCS_icon_info_30x31.png"
            }
            flat: true
            onClicked: header.openInfo();
        }
    }
}
