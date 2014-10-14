import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 1.0

Window {
    width: 300
    height: 300
    title: qsTr("About")

    Text {
        id: header
        width: parent.width
        //font.letterSpacing: parent.width/header.
        //font.family: "Helvetica"
        font.family: 'Titillium Web'
        font.pointSize: 16
        font.capitalization: Font.AllUppercase
        color: "black"
        horizontalAlignment: TextInput.AlignHCenter
        text: qsTr("About")
    }

    Column{
        id: aboutme
        anchors.top: header.bottom
        width: parent.width

        Text{
            width: parent.width
            text: qsTr("Created by") + ": Ole Holm Frandsen"
        }
        Text{
            width: parent.width
            text: qsTr("Version") + ": 0.15"
        }
        Text{
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            text: qsTr("Licence") + ": GPLv2 (http://www.gnu.org/licenses/gpl-2.0.html)"
        }
    }

    Text {
        id: creditsheader
        width: parent.width
        anchors.top: aboutme.bottom
        //font.letterSpacing: parent.width/header.
        //font.family: "Helvetica"
        font.family: 'Titillium Web'
        font.pointSize: 16
        font.capitalization: Font.AllUppercase
        color: "black"
        horizontalAlignment: TextInput.AlignHCenter
        text: qsTr("Credits")
    }

    Column{
        anchors.top: creditsheader.bottom
        width: parent.width

        Text{
            font.bold: true
            text: "Sounds: phone-incoming-call/phone-outgoing-busy"
        }
        Text {
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            text: "Part of the soundtheme 'Fresh and Clean' by mrhmouse.\nhttp://gnome-look.org/content/show.php/Fresh+and+Clean?content=123207"
        }

        Text{
            font.bold: true
            text: "Image: black_arrow.png"
        }
        Text {
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            text: "From Wikipedia by 'Mr. Unknown'.\nhttp://en.wikipedia.org/wiki/File:Black_Down_Arrow.png"
        }
    }

    function open(){
        visible = true
    }
    function close(){
        visible = false
    }
}
