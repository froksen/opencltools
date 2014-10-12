import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 1.0


Window {
    width: 300
    height: 60
    title: "Indstillinger"


    SoundSettings{

    }

    Row{
        width: parent.width
        height: savebuttom.height
        anchors.bottom: parent.bottom

        Button{
            id: savebuttom
            width: parent.width - cancelbutton.width
            text: "Gem"
        }
        Button {
            id: cancelbutton
            width: parent.width/3
            text: "Annuller"
        }
    }

    function open(){
        visible = true
    }
    function close(){
        visible = false
    }
}
