import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 1.0

Window {
    id: window
    property string textvalue: "hello"
    property color textcolor: "black"
    property color bgcolor: "white"
    property int maxPixelSize: Screen.desktopAvailableHeight
    property int textPixelsize: parent.width*0.45
    //flags: Qt.WindowStaysOnTopHint
    signal closing
    property alias windowstate: fullscreenicon_big.state

    width: 600
    minimumWidth: 240
    height: 480
    minimumHeight: 240
    title: textvalue
    color: bgcolor

    Rectangle{
        id: fullscreenicon_big
        width: 60
        height: 30
        color: "white"
        border.color: "black"
        z:1
        anchors.margins: 5
        radius: 7
        anchors.left: parent.left
        anchors.bottom: parent.bottom


        Rectangle{
            id: fullscreenicon_small
            width: parent.width/2
            height: parent.height/2
            color: "black"
            border.color: "black"
            anchors.left: parent.left
            anchors.margins: 3
            anchors.bottom: parent.bottom
            state: "windowed"
            radius: parent.radius
        }
        CheckBox{
            id: stayontop_checkbox
            z: 1
            anchors.left: fullscreenicon_big.right
            text: qsTr("Stay on top")
            anchors.margins: 10
            visible: fullscreenicon_big.state == "fullscreen" ? false : true

            onCheckedChanged: {
                if(checked){
                    stayontop(true)
                }
                else {
                    stayontop(false)
                }
            }

        }

        states: [
            State {
                name: "fullscreen"
                PropertyChanges { target: fullscreenicon_big; color: "black"}
                PropertyChanges { target: fullscreenicon_small; color: "white"}
                PropertyChanges { target: window; visibility: "FullScreen"}
            },
            State {
                name: "windowed"
                PropertyChanges { target: fullscreenicon_big; color: "white"}
                PropertyChanges { target: fullscreenicon_small; color: "black"}
                PropertyChanges { target: window; visibility: "Windowed"}
            }
        ]

        MouseArea{
            anchors.fill: parent
            onClicked: {
                console.log(window.visibility)

                if(fullscreenicon_big.state == "fullscreen"){
                    fullscreenicon_big.state = "windowed"
                    window.close();
                }
                else {
                    stayontop_checkbox.checked = false
                    fullscreenicon_big.state = "fullscreen"
                }
            }
        }
    }


    Text{
        width: parent.width
        height: parent.height

        font.family: "Helvetica"
        font.pixelSize: textPixelsize - 50
        horizontalAlignment: Text.AlignHCenter
        text: textvalue
        color: textcolor
        verticalAlignment: Text.AlignVCenter

        onWidthChanged: {
            textPixelsize = parent.width*0.45 // Resets the setting

            /*if(height == font.pixelSize){ //Finds the maxPixelSize
                maxPixelSize = textPixelsize
                console.log("maxPixelSize set to: " + maxPixelSize)
                textPixelsize = textPixelsize + 1
            }*/
            if(font.pixelSize<maxPixelSize){ //If less than maxPixelSize
                textPixelsize = parent.width*0.45 - 50
            }
            else if(font.pixelSize>maxPixelSize){ //If greater than maxPixelSize
                textPixelsize = maxPixelSize
            }

            /* DEBUGGING TEXT
            console.log("height: " + height)
            console.log ("maxPixelSize: " + maxPixelSize )
            console.log("font.pixelSize: " + font.pixelSize)
            */
        }
        onHeightChanged: {
            widthChanged();
        }

    }




    function open(){
        visible = true
    }
    function close(){
        visible = false
    }
    function stayontop(status){
        if(status){
            window.flags = Qt.WindowStaysOnTopHint
        }
        else {
            console.log("Disable")
            window.flags = 134279169;
        }

    }
}
