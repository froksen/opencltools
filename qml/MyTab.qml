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

    Rectangle{
        id: notifyarea
        width: parent.width
        height: 20
        anchors.bottom: parent.bottom
        z: 10
        color: "yellow"
        state: "none"
        anchors.bottomMargin: 5

        Text{
            id: notifyareatext
            text: "An error has happend"
            font.pixelSize: parent.height - anchors.bottomMargin
            horizontalAlignment: TextInput.AlignHCenter
            anchors.bottomMargin: 2
            anchors.rightMargin: 2
        }

        states: [
            State {
                name: "error"
                PropertyChanges {
                    target: notifyarea
                    color: "red"
                }
                PropertyChanges {
                    target: notifyareatext
                    color: "white"
                }
            },
            State {
                name: "note"
                PropertyChanges {
                    target: notifyarea
                    color: "yellow"
                }
                PropertyChanges {
                    target: notifyareatext
                    color: "black"
                }
            },
            State {
                name: "none"
                PropertyChanges {
                    target: notifyarea
                    color: "transparent"
                }
                PropertyChanges {
                    target: notifyareatext
                    color: "transparent"
                }
            }
        ]
    }

    function notifymsg(text){
        notifyareatext.text = text
        notifyarea.state = "note"
    }

    function errormsg(text){
        notifyareatext.text = qsTr("Error")+": "+text
        notifyarea.state = "error"
    }

    function clearmsg(){
        notifyareatext.text = ""
        notifyarea.state = "none"
    }
}
