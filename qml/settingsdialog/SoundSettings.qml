import QtQuick 2.0
import QtQuick.Controls 1.2
import Qt.labs.folderlistmodel 2.1
import QtMultimedia 5.0

Rectangle {
    width: parent.width
    height: 30
    color: "lightgrey"

    property string currentAudio: ""



    Row{
        width: parent.width
        height: parent.height

        Text {
            id: header_alarmsound
            text: "Alarmlyd: "
            font.pixelSize: 16
            height: parent.height
            verticalAlignment: Text.AlignVCenter
        }

        ComboBox {
            height: parent.height
            anchors.left: header_alarmsound.right

            id: combobox_alarmsound
            model:alarmsounds

            onCurrentIndexChanged: {
                currentAudio = alarmsounds.get(currentIndex).audiofile
                console.log("Current alarmsound: " + currentAudio)
                }


            ListModel {
                        id: alarmsounds

                        ListElement{
                            text: "phone-outgoing-busy"
                            audiofile: "qrc:/sounds/phone-outgoing-busy.mp3"
                        }
                    }
            }


        Button{
            id: alarmsoundbutton
            text: !playSound.Busy ? "Hør" : "Stop"
            height: parent.height
            anchors.left: combobox_alarmsound.right

            onClicked: {
                !playSound.PlayingState ? playSound.play() : playSound.stop()
            }
        }

        Audio {
            id: playSound
            source: currentAudio
        }

    }

}
