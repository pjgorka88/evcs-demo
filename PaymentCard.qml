import QtQuick 2.6
import QtQuick.Controls 2.1
import App 1.0

RadioButton
{
    id: button
    property alias imageName: image.source
    width: 77
    height: 46


    background: Rectangle
        {
            width: 79
            height: 51
            x:3
            y:2
            color: "transparent"
            border.width: button.checked ? 4 : 0
            border.color: "#3cbf52"
            radius: 4
        }

    contentItem: Image
        {
            width: 73
            height: 44
            id: image
            fillMode: Image.PreserveAspectFit
        }


}
