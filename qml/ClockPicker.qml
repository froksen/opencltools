import QtQuick 2.3
import QtQuick.Controls 1.2

Rectangle {  
    property int selectedtime: 0
    signal okclicked

    id: picker
    width: 280
    height: 225
    color: "steelblue"
    anchors.centerIn: parent

    Row {
        id: spinners
        width: parent.width
        height: 150
        anchors.horizontalCenter: parent.horizontalCenter

        Column{
            height: parent.height
            width: parent.width/2.3

            Text{
                id: minutsText
                width: parent.width
                text: qsTr("Minuts")
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
            }
            SpinnerList{
                id: minutsSpinner
                width: parent.width
                spinnermodel: 60
            }


        }

        Column{
            height: parent.height

            Text {
                height: minutsSpinner.height/2-minutsText.height
                text: " "
            }

            Text {
                text: ":"
                font.pixelSize: 75
            }
        }

        Column{
            height: parent.height
            width: parent.width/2.3

            Text{
                width: parent.width
                text: qsTr("Seconds")
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
            }
            SpinnerList{
                id: secondsSpinner
                width: parent.width
                spinnermodel: 60
            }
        }
    }


    Column{
        id: buttons
        width: parent.width
        height: 100
        anchors.top: spinners.bottom
        TouchButton{
            id: okButton
            width: parent.width
            height: 40
            text: qsTr("OK")

            onClicked: {
                selectedtime = secondsSpinner.value + (minutsSpinner.value*60)
                console.log("Time set to "+selectedtime+" seconds")
                okclicked()
            }
        }
        TouchButton{
            text: qsTr("Cancel")
            onClicked: {
                picker.visible = false;
            }
        }
    }
 }
