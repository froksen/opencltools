import QtQuick 2.3
import QtQuick.Controls 1.2

MyTab{
    id: myTab
    property int secondsatstart: 1
    property int seconds : 0
    property string timestamp: "00:00"
    property int milisecs: 0
    headertext: qsTr("Stopwatch")


    LightMode{
        id: lightmode
        textvalue: clock.timetext
        bgcolor: clock.color
        textcolor: clock.textColor
        x: mainWindow.x
        y: mainWindow.y
        width: mainWindow.width
        height: mainWindow.height

        onClosing: {stayontop_checkbox.checked = false}
    }

    ClockLayout{
        Row{
            id: buttonsrow
            width: parent.width
            TouchButton{
                width: parent.width/2
                text: qsTr("Reset")

                onClicked: {
                    myTab.seconds = 0;
                    converttotime(myTab.seconds);
                    timer.stop();
                }
            }
            TouchButton{
                width: parent.width/2
                text: qsTr("Start/Pause")

                onClicked: {
                    if(timer.running){
                            timer.stop()
                    }
                    else {
                        //if(!seconds<0){
                            timer.start()
                        // }
                    }
                }
            }
        }
        Rectangle{
            id: fullscreenicon_big
            width: 60
            height: 30
            color: "white"
            border.color: "black"
            z:1
            anchors.margins: 5
            radius: 7
            anchors.top: buttonsrow.bottom
            anchors.left: lightmodebutton.right



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

            MouseArea{
                anchors.fill: parent

                onClicked: {
                    lightmode.open();
                    lightmode.windowstate = "fullscreen"
                }
            }
        }

        CheckBox{
            id: stayontop_checkbox
            z: 1
            anchors.left: fullscreenicon_big.right
            anchors.top: buttonsrow.bottom
            text: qsTr("Stay on top")
            anchors.margins: 10
            visible: fullscreenicon_big.state == "fullscreen" ? false : true

            onCheckedChanged: {
                if(checked){
                    lightmode.open()
                    lightmode.windowstayontop = true
                    mainWindow.hide()
                }
                else {
                    lightmode.close()
                    lightmode.windowstayontop = false
                    mainWindow.show()
                }
            }
        }

        id: clock
        anchors.top: topsection.bottom
        timetext: converttotime(seconds)
        height: parent.height-topsection.height

        onTimetextChanged: {
            if(myTab.visible){
                mainWindow.windowtitleExtra = timestamp;
            }
        }
    }

    Timer {
        id: timer
        interval: 1000; running: false; repeat: true;
        onTriggered: {seconds++;
                }
    }

    function converttotime(secs) {
        var totalSec = secs ;//new Date().getTime() / 1000;
        var hours = parseInt( totalSec / 3600 ) % 24;
        var minutes = parseInt( totalSec / 60 ) % 60;
        var seconds = totalSec % 60;

        //var result = (hours < 10 ? "0" + hours : hours) + ":" + (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds  < 10 ? "0" + seconds : seconds);
        var result = (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds  < 10 ? "0" + seconds : seconds);
        console.log(result);
        return result;
    }


}



