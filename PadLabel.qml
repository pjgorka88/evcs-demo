import QtQuick 2.6
import QtQuick.Controls 2.1
import App 1.0

Rectangle
{
    id: root
    border.width: 2
    color: "transparent"
    radius: 5
    width: 120

    signal pinAccepted();
    signal pinCaneled();

    function clear()
    {
        textField.text = "";
        root.pinCaneled();
    }

    function insertText( keyId )
    {
        if ( textField.text.length < 4 )
            textField.text = textField.text + "x";
    }

    function removeText()
    {
        var len = textField.text.length;
        if ( len > 0 )
            textField.text = textField.text.substring(0, len - 1);
    }

    function cancelButton()
    {
        clear();
    }

    function acceptedButton()
    {
        var len = textField.text.length;
        if ( len > 0 )
        {
            root.pinAccepted();
        }
    }

    Label
    {
        anchors.fill: parent
        id: textField
        color: "#ffffff"
        text: ""
        font.pixelSize: Variables.fontPaymentPin
        horizontalAlignment: TextInput.AlignHCenter
        verticalAlignment: Text.AlignVCenter

    }
}
