import QtQuick 2.3

Rectangle {
    property string timetext: "00:00"
    property string textColor: "black"
    readonly property string defaulttextColor: "black"
    property int maxPixelSize: 20
    property int textPixelsize: 16

    height: parent.height
    width: parent.width

    Text{
        width: parent.width
        height: parent.height

        font.family: "Helvetica"
        font.pixelSize: parent.width*0.45 - 50
        color: textColor
        horizontalAlignment: TextInput.AlignHCenter
        text: timetext
        verticalAlignment: TextInput.AlignVCenter
    }

}
