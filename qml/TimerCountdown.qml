import QtQuick 2.3
import QtQuick.Controls 1.2
import QtMultimedia 5.0

MyTab{
    id: myTab
    property int secondsatstart: 1
    property int seconds : picker.selectedtime
    property string timestamp: "00:00"
    headertext: qsTr("Countdown timer")


    ClockLayout{
        id: clock
        anchors.top: topsection.bottom
        timetext: timestamp
        //width: parent.width
        height: parent.height-topsection.height

        onTimetextChanged: {
            if(myTab.visible){
                mainWindow.windowtitleExtra = timestamp;
            }
        }

        Row{
            id: buttonsrow
            width: parent.width
            //anchors.top: topsection.bottom

            TouchButton{
                width: parent.width/2
                text: qsTr("Set")

                onClicked: {
                    picker.visible = true
                    timerCountdown.stop()
                }
            }
            TouchButton{
                width: parent.width/2
                text: qsTr("Start/Pause")

                onClicked: {
                    if(timerCountdown.running){
                            timerCountdown.stop()
                    }
                    else {
                        if(!seconds<=0){
                            timerCountdown.start()
                         }
                    }
                }
            }
        }

        ClockPicker{
            id: picker
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false

            onOkclicked:{
                if(selectedtime>0){
                    myTab.secondsatstart = selectedtime;
                }
                myTab.seconds = selectedtime;
                picker.visible = false;
                converttotime(myTab.seconds);
                clock.color = "white";
                clock.textColor = clock.defaulttextColor;
            }
        }
    }
    ProgressBar{
        id: progressbar
        anchors.bottom: myTab.bottom
        width: clock.width
        maximumValue: myTab.secondsatstart
        value: myTab.seconds
    }
    Timer {
        id: timerCountdown
        interval: 1000; running: false; repeat: true;
        onTriggered: {seconds--;
                converttotime(seconds);
                progressbar.value = myTab.seconds;
                if(seconds<10){clock.color = "yellow"; clock.textColor = "red"};
                if(seconds>10){clock.color = "white"; clock.textColor = clock.defaulttextColor};
                if(seconds<=0){clock.color = "red"; clock.textColor = "white"; timerCountdown.stop(); playSound.play();myTab.timestamp = qsTr("STOP")}
            }
    }

    Audio {
        id: playSound
        source: "../sounds/phone-incoming-call.mp3"
    }

    function converttotime(secs) {
        var totalSec = secs ;//new Date().getTime() / 1000;
        var hours = parseInt( totalSec / 3600 ) % 24;
        var minutes = parseInt( totalSec / 60 ) % 60;
        var seconds = totalSec % 60;

        //var result = (hours < 10 ? "0" + hours : hours) + ":" + (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds  < 10 ? "0" + seconds : seconds);
        var result = (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds  < 10 ? "0" + seconds : seconds);
        console.log(result);
        timestamp = result;
        return result;
    }
}



