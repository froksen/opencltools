import QtQuick 2.0

Rectangle {
    property string headertext: "Header Text"
    property string descriptiontext: "Here is a description"
    property alias topsection: topSection

    id: mytab
    anchors.fill: parent
    color: "transparent"

    Rectangle{
        id: topSection
        width: parent.width
        height: 45
        color: "steelblue"

        Text {
            id: header
            width: parent.width
            //font.letterSpacing: parent.width/header.
            //font.family: "Helvetica"
            font.family: 'Titillium Web'
            font.pointSize: 30*0.6
            font.capitalization: Font.AllUppercase
            color: "white"
            horizontalAlignment: TextInput.AlignHCenter
            text: headertext
        }
        /*Text{
            id: description
            width: parent.width
            height: 50
            anchors.top: header.bottom
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            text: descriptiontext
        }*/

        Rectangle{
            id: notifyarea
            width: parent.width
            height: 15
            anchors.bottom: parent.bottom
            color: "yellow"

            Text{
                id: notifyareatext
                text: "hello world"
                font.pixelSize: parent.height
                horizontalAlignment: TextInput.AlignHCenter
            }
        }

        gradient: Gradient {
                 GradientStop { position: 0.0; color: topSection.color }
                 GradientStop { position: 0.90; color: "black" }
        }
    }
}
