import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 1.0

Window {
    width: 480
    height: 300
    minimumHeight: 150
    minimumWidth: 300
    title: qsTr("About")

    Rectangle{
        id: topSection
        width: parent.width
        height: 30
        color: "steelblue"

        Text {
            id: header
            width: parent.width
            font.family: 'Titillium Web'
            font.pointSize: parent.height*0.6
            font.capitalization: Font.AllUppercase
            color: "white"
            horizontalAlignment: TextInput.AlignHCenter
            text: qsTr("About")
        }

        gradient: Gradient {
                 GradientStop { position: 0.0; color: topSection.color }
                 GradientStop { position: 0.90; color: "black" }
        }
    }

    Column{
        id: aboutme
        anchors.top: topSection.bottom
        width: parent.width
        height: 70

        Text{
            width: parent.width
            font.pixelSize: 12
            text: "<b>"+qsTr("Created by")+"</b>" + ": Ole Holm Frandsen"
        }
        Text{
            width: parent.width
            text: "<b>"+qsTr("Version")+"</b>" + ": 0.15"
        }
        Text{
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            text: "<b>"+qsTr("Licence")+"</b>" + ": GPLv2"
        }
    }

    Rectangle{
        id: horizontalline
        width: parent.width
        height: 1
        color: "black"
        anchors.top: aboutme.bottom
    }

    ScrollView{
        anchors.top: horizontalline.bottom
        width: parent.width; height: parent.height - header.height - aboutme.height
        ListView {
            anchors.top: parent.top
            width: parent.width; height: parent.height - header.height
            model: creditsModel
            delegate: creditsDelegate



            Component {
                id: creditsDelegate
                Rectangle {
                    width: parent.width; height: 70
                    Column {
                        width: parent.width
                        Text { width: parent.width; font.pixelSize: 12; horizontalAlignment: Text.AlignHCenter; text: '<b>' + name + "</b>"}
                        Text{width: parent.width;text:  contentdescription; wrapMode: Text.WrapAtWordBoundaryOrAnywhere}
                        Text { width: parent.width;text: '<b>By:</b> ' + author; wrapMode: Text.WrapAtWordBoundaryOrAnywhere}
                        Text { width: parent.width;text: '<b>Licence:</b> ' + licence; wrapMode: Text.WrapAtWordBoundaryOrAnywhere}
                        Text { width: parent.width; text: '<b>Homepage:</b> <a href="' + homepage + '">'+homepage+"</a>"; wrapMode: Text.WrapAnywhere }
                    }
                }
            }

            ListModel{
                id: creditsModel

                function addCredit(name,contentdescription, author, licence, homepage){
                    append({"name":name, "contentdescription":contentdescription, "author":author,"licence":licence, "homepage":homepage})
                }
            }

            Component.onCompleted: {
                creditsModel.addCredit("Open CL Tools logo", "Based on 'Tutorial Icon' and 'Ecommerce Handshake Icon'. For license and information, see below","anonymous contributor","CC Attribution-Noncommercial-Share Alike 4.0","-");
                creditsModel.addCredit("Tutorial Icon","","Kyo-Tux","CC Attribution-Noncommercial-Share Alike 4.0","http://www.iconarchive.com/show/soft-icons-by-kyo-tux/Tutorial-icon.html")
                creditsModel.addCredit("Ecommerce Handshake Icon","The world's largest icon packs for windows 8, ios 7 and android","Icons8","Linkware (http://icons8.com/license/)","http://icons8.com/")
                creditsModel.addCredit("Audio: phone-incoming-call/phone-outgoing-busy","Part of the soundtheme 'Fresh and Clean'","mrhmouse","GPL","http://gnome-look.org/content/show.php/Fresh+and+Clean?content=123207");
                creditsModel.addCredit("Image: black_arrow.png","From Wikipedia","Mr. Unknown","Public domain","http://en.wikipedia.org/wiki/File:Black_Down_Arrow.png");
            }
        }
    }
/*
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

*/
    function open(){
        visible = true
    }
    function close(){
        visible = false
    }
}
