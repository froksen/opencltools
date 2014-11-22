import QtQuick 2.3
import QtQuick.Controls 1.2

MyTab{
    property int runningtime: 0
    property bool arrowrotating: false

    id: myTab
    headertext: qsTr("Start chooser (Number)")
    anchors.fill: parent
    color: "green"

    // The row where the buttons are placed
    Row{
        id: buttons
        anchors.top: topsection.bottom
        width: parent.width

        TouchButton{
            id: newOutcomeButton
            width: parent.width
            text: qsTr("New outcome")

            onClicked: {
                //Resets the image rotation
                animationImage.enabled = false; //Disables the smooth animation, for faster reset
                image.rotation = 0
                animationImage.enabled = true; //Enables the smooth animation again


                //Clears the variables
                var step = 0
                var numberofsteps = 0
                var rotationangle = 0;

                switch(boardsizecombobox.currentIndex){
                case 0:
                    step = Math.floor(360/5) // For five fields
                    numberofsteps = calulateStep(5);
                    break;
                case 1:
                    step = (360/4) // For four fields
                    numberofsteps = Math.floor(Math.random() * 4)
                    break;
                case 2:
                    step = (360/3) // For three fields
                    numberofsteps = Math.floor(Math.random() * 3)
                    break;
                }
                //Sets the rotation
                rotationangle = Math.floor(step * numberofsteps);

                //Setting the angle that the arrow should have.
                image.rotation = rotationangle + 1440

                //Storing the current rotation to prevent it from happening again.
                image.previousrotation = numberofsteps

            }
        }
    }

    //Finds a random number between 0 and "maxStep". If number is equal "previousrotation" then it will try again
    function calulateStep(maxStep){
        var randomnumber = Math.floor(Math.random() * maxStep);

        while( randomnumber == image.previousrotation){
            randomnumber = Math.floor(Math.random() * maxStep)
            console.log("Number " + randomnumber + " was previous outcome, finding new.")
        }

        return randomnumber;
    }

    // Board with four fields/numbers
    Rectangle{
        //id: boardfour
        visible: false
        //color: "yellow"
        width: height
        height: 260
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: buttons.bottom

        Column{
            id: boardrows
            anchors.fill: parent

            Row{
                id: boardrow1
                width: parent.width/2
                height: parent.height/2

                Rectangle{
                  width: parent.width
                  height: parent.height
                  color: "white"
                  border.color: "black"
                  border.width: 1

                  Text{
                      width: parent.width
                      height: parent.height
                      horizontalAlignment: TextInput.AlignLeft
                      verticalAlignment: TextInput.AlignTop
                      text: " 1 "
                      font.family: "Helvetica"
                      font.pointSize: 90
                  }

                }
                Rectangle{
                    width: parent.width
                    height: parent.height
                    color: "white"
                    border.color: "black"
                    border.width: 1
                    Text{
                        width: parent.width
                        height: parent.height
                        horizontalAlignment: TextInput.AlignRight
                        verticalAlignment: TextInput.AlignTop
                        text: " 2 "
                        font.family: "Helvetica"
                        font.pointSize: 90
                    }
                }
            }

            Row{
                width: parent.width/2
                height: parent.height/2

                Rectangle{
                  width: parent.width
                  height: parent.height
                  color: "white"
                  border.color: "black"
                  border.width: 1
                  Text{
                      width: parent.width
                      height: parent.height
                      horizontalAlignment: TextInput.AlignLeft
                      verticalAlignment: TextInput.AlignBottom
                      text: " 3 "
                      font.family: "Helvetica"
                      font.pointSize: 90
                  }

                }
                Rectangle{
                    width: parent.width
                    height: parent.height
                    color: "white"
                    border.color: "black"
                    border.width: 1
                    Text{
                        width: parent.width
                        height: parent.height
                        horizontalAlignment: TextInput.AlignRight
                        verticalAlignment: TextInput.AlignBottom
                        text: " 4 "
                        font.family: "Helvetica"
                        font.pointSize: 90
                    }
                }
            }
        }

    }

    // Board with five fields/numbers
    Rectangle {
        id:boardcircle
         //width: parent.width<parent.height?parent.width:parent.height
        anchors.top: buttons.bottom
        width: height
         height: parent.height/2
         color: "white"
         border.color: "black"
         border.width: 1
         visible: true
         radius: width*0.5
         anchors.verticalCenter: parent.verticalCenter
         anchors.horizontalCenter: parent.horizontalCenter

             Rectangle{
                 id: line1
                 width: 1
                 height: boardcircle.height/2
                 anchors.bottom: parent.bottom
                 anchors.horizontalCenter: parent.horizontalCenter
                 color: "black"
                 transform: Rotation {  angle: 0 }
                          smooth: true
             }
             Rectangle{
                 id: line2
                 width: 1
                 height: boardcircle.height/2
                 anchors.bottom: boardcircle.bottom
                 anchors.horizontalCenter: parent.horizontalCenter
                 color: "black"
                 transform: Rotation {  angle: 72 }
                          smooth: true

             }
             Rectangle{
                 id: line3
                 width: 1
                 height: boardcircle.height/2
                 anchors.bottom: boardcircle.bottom
                 anchors.horizontalCenter: parent.horizontalCenter
                 color: "black"
                 transform: Rotation {  angle: 144 }
                          smooth: true

             }
             Rectangle{
                 id: line4
                 width: 1
                 height: boardcircle.height/2
                 anchors.bottom: boardcircle.bottom
                 anchors.horizontalCenter: parent.horizontalCenter
                 color: "black"
                 transform: Rotation {  angle: 216 }
                          smooth: true
             }
             Rectangle{
                 id: line5
                 width: 1
                 height: boardcircle.height/2
                 anchors.bottom: boardcircle.bottom
                 anchors.horizontalCenter: parent.horizontalCenter
                 color: "black"
                 transform: Rotation {  angle: 288 }
                          smooth: true
             }


             Text{
                 //anchors.bottom: parent.bottom
                 //anchors.fill: boardcircle
                 height: parent.height
                 text: "1"
                 font.family: "Helvetica"
                 font.pointSize: 60
                 anchors.verticalCenter: parent.verticalCenter
                 anchors.horizontalCenter: parent.horizontalCenter
                 rotation: 0
             }
             Text{
                 //anchors.bottom: parent.bottom
                 //anchors.fill: boardcircle
                 height: parent.height
                 text: "2"
                 font.family: "Helvetica"
                 font.pointSize: 60
                 anchors.verticalCenter: parent.verticalCenter
                 anchors.horizontalCenter: parent.horizontalCenter
                 rotation: 72
             }
             Text{
                 //anchors.bottom: parent.bottom
                 //anchors.fill: boardcircle
                 height: parent.height
                 text: "3"
                 font.family: "Helvetica"
                 font.pointSize: 60
                 anchors.verticalCenter: parent.verticalCenter
                 anchors.horizontalCenter: parent.horizontalCenter
                 rotation: 144
             }
             Text{
                 //anchors.bottom: parent.bottom
                 //anchors.fill: boardcircle
                 height: parent.height
                 text: "4"
                 font.family: "Helvetica"
                 font.pointSize: 60
                 anchors.verticalCenter: parent.verticalCenter
                 anchors.horizontalCenter: parent.horizontalCenter
                 rotation: 216
             }
             Text{
                 //anchors.bottom: parent.bottom
                 //anchors.fill: boardcircle
                 height: parent.height
                 text: "5"
                 font.family: "Helvetica"
                 font.pointSize: 60
                 anchors.verticalCenter: parent.verticalCenter
                 anchors.horizontalCenter: parent.horizontalCenter
                 rotation: 288
             }

    }

    // Board with four fields/numbers
    Rectangle {
        id:boardfour
        anchors.top: buttons.bottom
        width: height
         height: parent.height/2
         color: "white"
         visible: false
         border.color: "black"
         border.width: 1
         radius: width*0.5
         anchors.verticalCenter: parent.verticalCenter
         anchors.horizontalCenter: parent.horizontalCenter

             Rectangle{
                 id: line4one
                 width: 1
                 height: boardfour.height/2
                 anchors.bottom: parent.bottom
                 anchors.horizontalCenter: parent.horizontalCenter
                 color: "black"
                 transform: Rotation {  angle: 45 }
                          smooth: true
             }
             Rectangle{
                 id: line4two
                 width: 1
                 height: boardfour.height/2
                 anchors.bottom: boardfour.bottom
                 anchors.horizontalCenter: parent.horizontalCenter
                 color: "black"
                 transform: Rotation {  angle: 135 }
                          smooth: true

             }
             Rectangle{
                 id: line4three
                 width: 1
                 height: boardfour.height/2
                 anchors.bottom: boardfour.bottom
                 anchors.horizontalCenter: parent.horizontalCenter
                 color: "black"
                 transform: Rotation {  angle: 225 }
                          smooth: true

             }
             Rectangle{
                 id: line4four
                 width: 1
                 height: boardfour.height/2
                 anchors.bottom: boardfour.bottom
                 anchors.horizontalCenter: parent.horizontalCenter
                 color: "black"
                 transform: Rotation {  angle: 315 }
                          smooth: true

             }

             Text{
                 //anchors.bottom: parent.bottom
                 //anchors.fill: boardcircle
                 height: parent.height
                 text: "1"
                 font.family: "Helvetica"
                 font.pointSize: 60
                 anchors.verticalCenter: parent.verticalCenter
                 anchors.horizontalCenter: parent.horizontalCenter
                 rotation: 0
             }
             Text{
                 //anchors.bottom: parent.bottom
                 //anchors.fill: boardcircle
                 height: parent.height
                 text: "2"
                 font.family: "Helvetica"
                 font.pointSize: 60
                 anchors.verticalCenter: parent.verticalCenter
                 anchors.horizontalCenter: parent.horizontalCenter
                 rotation: 90
             }
             Text{
                 //anchors.bottom: parent.bottom
                 //anchors.fill: boardcircle
                 height: parent.height
                 text: "3"
                 font.family: "Helvetica"
                 font.pointSize: 60
                 anchors.verticalCenter: parent.verticalCenter
                 anchors.horizontalCenter: parent.horizontalCenter
                 rotation: 180
             }
             Text{
                 //anchors.bottom: parent.bottom
                 //anchors.fill: boardcircle
                 height: parent.height
                 text: "4"
                 font.family: "Helvetica"
                 font.pointSize: 60
                 anchors.verticalCenter: parent.verticalCenter
                 anchors.horizontalCenter: parent.horizontalCenter
                 rotation: 270
             }

    }

    // Board with three fields/numbers
    Rectangle {
        id:boardcirclewiththree
        anchors.top: buttons.bottom
        width: height
         height: parent.height/2
         color: "white"
         visible: false
         border.color: "black"
         border.width: 1
         radius: width*0.5
         anchors.verticalCenter: parent.verticalCenter
         anchors.horizontalCenter: parent.horizontalCenter

             Rectangle{
                 id: lineone
                 width: 1
                 height: boardcirclewiththree.height/2
                 anchors.bottom: parent.bottom
                 anchors.horizontalCenter: parent.horizontalCenter
                 color: "black"
                 transform: Rotation {  angle: 0 }
                          smooth: true
             }
             Rectangle{
                 id: linetwo
                 width: 1
                 height: boardcirclewiththree.height/2
                 anchors.bottom: boardcirclewiththree.bottom
                 anchors.horizontalCenter: parent.horizontalCenter
                 color: "black"
                 transform: Rotation {  angle: 120 }
                          smooth: true

             }
             Rectangle{
                 id: linethree
                 width: 1
                 height: boardcirclewiththree.height/2
                 anchors.bottom: boardcirclewiththree.bottom
                 anchors.horizontalCenter: parent.horizontalCenter
                 color: "black"
                 transform: Rotation {  angle: 240 }
                          smooth: true

             }

             Text{
                 //anchors.bottom: parent.bottom
                 //anchors.fill: boardcircle
                 height: parent.height
                 text: "1"
                 font.family: "Helvetica"
                 font.pointSize: 60
                 anchors.verticalCenter: parent.verticalCenter
                 anchors.horizontalCenter: parent.horizontalCenter
                 rotation: 0
             }
             Text{
                 //anchors.bottom: parent.bottom
                 //anchors.fill: boardcircle
                 height: parent.height
                 text: "2"
                 font.family: "Helvetica"
                 font.pointSize: 60
                 anchors.verticalCenter: parent.verticalCenter
                 anchors.horizontalCenter: parent.horizontalCenter
                 rotation: 120
             }
             Text{
                 //anchors.bottom: parent.bottom
                 //anchors.fill: boardcircle
                 height: parent.height
                 text: "3"
                 font.family: "Helvetica"
                 font.pointSize: 60
                 anchors.verticalCenter: parent.verticalCenter
                 anchors.horizontalCenter: parent.horizontalCenter
                 rotation: 240
             }

    }

    //The Arrow
    Image {
        property int previousrotation: -1

        id: image
        visible: true
        source: "../images/black_arrow.png";
        width: boardcircle.height/3.5
        z: 1
        rotation: 0
        height: boardcircle.height/2
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Behavior on rotation {
            id: animationImage
            SmoothedAnimation{
                velocity: 1500;

            }
        }
    }



    Rectangle{
        id: imagenail
        visible: true
        color: "red"
        width: image.width/4
        height: width
        z: 2
        radius: width*0.5
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        gradient: Gradient {
                 GradientStop { position: 0.0; color: "red" }
                 GradientStop { position: 0.90; color: "darkred" }
        }
    }

    // The combobox where you can choose which board to show.
    ComboBox {
        id: boardsizecombobox
        anchors.top: buttons.bottom
        editable: false
        model:mmodel
        width: 100
        height: 40
        onCurrentTextChanged: {
            boardcircle.visible = false;
            boardfour.visible = false;
            boardcirclewiththree.visible = false;

            if (boardsizecombobox.currentIndex == 0) {
                boardcircle.visible = true;
            }
            else if(boardsizecombobox.currentIndex == 1){
                boardfour.visible = true
            }
            else if(boardsizecombobox.currentIndex == 2){
                boardcirclewiththree.visible = true
            }

            //Resets the image rotation
            animationImage.enabled = false; //Disables the smooth animation, for faster reset
            image.rotation = 0
            image.previousrotation = -1
            animationImage.enabled = true; //Enables the smooth animation again

        }

         property var mmodel: [
                    {
                        text: qsTr("5 fields")
                    },
                    {
                        text: qsTr("4 fields")
                    },
                    {
                        text: qsTr("3 fields")
                    }
                ]
    }



    //Creating the background effect
    gradient: Gradient {
             GradientStop { position: 0.0; color: "#669900" }
             GradientStop { position: 0.90; color: "#006600" }
    }
}
