import QtQuick 2.3
import QtQuick.Controls 1.2
import QtMultimedia 5.0

MyTab{
    id: myTab
    headertext: qsTr("Random Number")
    property int prevouiousOutcome: -1


    ClockLayout{
        id: clockText
        anchors.top: topsection.bottom
        height: parent.height-topsection.height
        timetext: "1"

        Row{
            id: buttonsrow
            width: parent.width
            //anchors.top: topsection.bottom

            TouchButton{
                width: parent.width/2
                text: qsTr("Set Interval")

                onClicked: {
                    picker.visible = true
                }
            }
            TouchButton{
                width: parent.width/2
                text: qsTr("New outcome")
                enabled: fromNumberSpinner.value<toNumberSpinner.value ? true : false

                onClicked: {
                    newOutcome();
                }
            }
        }

        CheckBox{
            id: checkoutSameoutcome
            anchors.top: buttonsrow.bottom
            width: 100
            text: qsTr("Allow the same outcome \nto appear twice.")
            checked: false
        }
    }




    //---------------------The Picker element---------------------
    Rectangle {
        property int selectedtime: 0
        signal okclicked

        id: picker
        width: 280
        height: 240
        color: "steelblue"
        anchors.centerIn: parent

        Row {
            id: spinners
            width: parent.width
            height: 150
            anchors.horizontalCenter: parent.horizontalCenter

            Column{
                height: parent.height
                width: parent.width*2/5

                Text{
                    id: fromNumberText
                    width: parent.width
                    text: qsTr("From")
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                }
                SpinnerList{
                    id: fromNumberSpinner
                    width: parent.width
                    spinnermodel: 99
                }

            }


            Column{
                height: parent.height
                width: parent.width*2/5
                anchors.right: parent.right

                Text{
                    width: parent.width
                    text: qsTr("To")
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                }
                SpinnerList{
                    id: toNumberSpinner
                    width: parent.width
                    spinnermodel: 99
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
                enabled: fromNumberSpinner.value<toNumberSpinner.value ? true : false

                onClicked: {
                    newOutcome();
                }
            }
            Row{
                height: 40
                width: parent.width
                TouchButton{
                    text: qsTr("Cancel")
                    width: parent.width*3/4
                    onClicked: {
                        picker.visible = false;
                    }
                }
                TouchButton{
                    text: qsTr("Reset")
                    width: parent.width*1/4
                    onClicked: {
                        picker.visible = true;
                        fromNumberSpinner.setValue = 0;
                        toNumberSpinner.setValue = 0;

                    }
                }
            }
            Rectangle{
                id: errorinterval
                width: parent.width
                height: 25
                color: "red"
                visible: fromNumberSpinner.value>=toNumberSpinner.value ? true : false

                Text{
                    color: "white"
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    text: qsTr("Error: The <u><b>to</b></u> value must be greater than the <u><b>from</b></u> value")
                }
            }
        }

     }


    function newOutcome(){
        if(fromNumberSpinner.value<toNumberSpinner.value){
            console.log("Interval set from "+fromNumberSpinner.value +" to " + toNumberSpinner.value)
            clockText.timetext = findRandomNumber(fromNumberSpinner.value,toNumberSpinner.value)
            picker.visible = false
            errorinterval.visible = false;
        }
        else{
            console.log("Error: The <b>to value</b> must be greater than the <b>from value</b>.")
            errorinterval.visible = true
        }
    }

    function findRandomNumber(fromNumber, toNumber){
        console.log("Finding random number between "+ fromNumber + " and " + toNumber)

        //If fromNumber is zero, then the toNumber will be increased with 1.
        if(fromNumber == 0){
            toNumber = toNumber +1
        }

        var randomNumber =  Math.floor((Math.random() * toNumber) + fromNumber);

        if(!checkoutSameoutcome.checked){
            while(prevouiousOutcome == randomNumber){
                console.log("Outcome: " + randomNumber + " has was also the previous outcome. Finding new"  )
                randomNumber =  Math.floor((Math.random() * toNumber) + fromNumber);
            }
        }

        prevouiousOutcome = randomNumber;

        console.log("Found randomnumber: " + randomNumber  )

        return randomNumber;
    }
}



