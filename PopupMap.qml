import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtLocation 5.6
import QtPositioning 5.6

Popup {
    id: popup
    width: 680
    rightMargin: 1
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    leftMargin: 60


    Plugin {
          id: mapPlugin
          name: "osm"
      }

    Component.onCompleted:
    {
        point.center = QtPositioning.coordinate(52.520686, 13.41638)
        locationData.center = QtPositioning.coordinate(52.520686, 13.41638)
    }

    background:Rectangle
    {

        width: 600
        height: 400
        color: "transparent"
        border.color: "black"
        Map
        {
            id: locationData
            width: 720
            anchors.fill: parent
            plugin: mapPlugin
            zoomLevel: 16
            MapCircle {
                id: point
                radius: 10
                color: "#ff0000"
                border.color: "#190a33"
                border.width: 2
                smooth: true
                opacity: 0.75
            }
        }
    }
}
