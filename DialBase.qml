import QtQuick 2.8
import QtQuick.Controls 2.0

Dial {
    id: dial

    background: Rectangle {
        x: dial.width / 2 - width / 2
        y: dial.height / 2 - height / 2
        width: Math.max(64, Math.min(dial.width, dial.height))
        height: width
        color: "transparent"
        radius: width / 2
        border.color: dial.pressed ? "#17a81a" : "#21be2b"
        opacity: dial.enabled ? 1 : 0.3
    }
    handle: Image {
            id: handleItem
            x: dial.background.x + dial.background.width / 2 - width / 2
            y: dial.background.y + dial.background.height / 2 - height / 2
            width: 16
            height: 16
            //color: dial.pressed ? "#17a81a" : "#21be2b"
            //radius: 8
            source: "Assets/Select/EVCS_dial_button_16x16.png"
            antialiasing: true
            opacity: dial.enabled ? 1 : 0.3
            transform: [
                Translate {
                    x: -8
                    y: -Math.min(dial.background.width, dial.background.height) * 0.4 + handleItem.height / 2 - 8

                },
                Rotation {
                    angle: dial.angle
                    origin.x: handleItem.width / 2
                    origin.y: handleItem.height / 2
                }
            ]
        }
    }
