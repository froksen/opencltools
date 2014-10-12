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
        height: 30
        color: "steelblue"

        Text {
            id: header
            width: parent.width
            //font.letterSpacing: parent.width/header.
            //font.family: "Helvetica"
            font.family: 'Titillium Web'
            font.pointSize: parent.height*0.6
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

        gradient: Gradient {
                 GradientStop { position: 0.0; color: topSection.color }
                 GradientStop { position: 0.90; color: "black" }
        }
    }
}
