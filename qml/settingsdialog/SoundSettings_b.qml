import QtQuick 2.0
import QtQuick.Controls 1.2

Rectangle {
    width: parent.width
    height: parent.height
    color: "blue"

    Text{
        text: "test"
    }

    Row{
        id: alarmsoundrow
        width: parent.width
        height: 16

        Text{
            font.pixelSize: parent.height
            text: "Alarmlyd"
        }

        ComboBox{
            id: alarmsoundcombo
            width: parent.width
            height: parent.height
            model: ListModel{
                    ListElement {
                        text: "Bip"
                    }
            }
        }

    }
}
