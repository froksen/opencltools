import QtQuick 2.3
import QtQuick.Controls 1.2

MyTab{
    id: myTab
    property int secondsatstart: 1
    property int seconds : 0
    property string timestamp: "00:00"
    property int milisecs: 0
    headertext: qsTr("Stopwatch")

    ClockLayout{
        Row{
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



