import QtQuick 2.3

Rectangle {
    property string timetext: "00:00"
    property string textColor: "red"
    property int textPointsize: 16

    height: parent.height
    width: parent.width

    Text{
        anchors.fill: parent
        font.family: "Helvetica"
        font.pointSize: parent.height*0.45
        color: textColor
        horizontalAlignment: TextInput.AlignHCenter
        text: timetext
        verticalAlignment: TextInput.AlignVCenter
    }

}
