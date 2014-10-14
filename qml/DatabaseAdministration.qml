import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2

Rectangle {
    property ListModel contentmodel: mmodel;
    property var db: null
    signal forceupdate

    id: adminmodule
    width: parent.width/1.5
    height: 100
    visible: false

    color: "steelblue"
    z:1;

    Text {
        id: header
        width: parent.width
        //font.letterSpacing: parent.width/header.
        font.family: "Helvetica"
        font.pointSize: 24
        font.capitalization: Font.AllUppercase
        color: "black"
        horizontalAlignment: TextInput.AlignHCenter
        text: qsTr("Administration")

    }

    Rectangle{
        id: addnew
        anchors.fill: parent
        z: 2;
        color: adminmodule.color
        visible: false

        Text {
            font.pointSize: 12
            text: qsTr("Type the outcome you want and click on '"+addnewAddbutton.text+"'" )
        }

        Rectangle{
            height: 20
            width: parent.width
            color: "white"
            anchors.bottom: addnewbuttons.top
            border.color: "black"
            border.width: 1.5

            TextInput{
                id: addnewTextarea
                anchors.fill: parent
                text: ""
                color: "black"
                font.family: "Helvetica"
                font.pointSize: 12
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                horizontalAlignment: Text.horizontalAlignment
                verticalAlignment: Text.verticalCenter


                onAccepted: {
                    insertOreplace(addnewTextarea.text)
                    addnew.visible = false;
                    contentmodel.clear()
                    forceupdate()
                    addnewTextarea.text = ""
                    rowarea.enabled = true
                }
            }
        }



        Column {
            id: addnewbuttons
            width: parent.width
            height: 50
            anchors.bottom: parent.bottom

            TouchButton{
                id: addnewAddbutton
                height: parent.height/2

                width: parent.width
                text: qsTr("Add")
                tooltip: qsTr("Add a possible outcome")

                onClicked: {
                    insertOreplace(addnewTextarea.text)
                    addnew.visible = false;
                    contentmodel.clear()
                    forceupdate()
                    addnewTextarea.text = ""
                    rowarea.enabled = true

                }
            }
            TouchButton{
                height: parent.height/2
                width: parent.width
                text: qsTr("Close")
                tooltip: qsTr("Closes the dialog")

                onClicked: {
                    addnew.visible = false;
                    rowarea.enabled = true
                }
            }
        }
    }

    Row {
        id: rowarea
        width: parent.width
        enabled: true
        anchors.top: header.bottom

        TouchButton{
            width: parent.width/4
            text: qsTr("Add new")
            tooltip: qsTr("Opens a dialog where you can add a new outcome")

            onClicked: {
                addnew.visible = true;
            }
        }
        TouchButton{
            width: parent.width/4
            text: qsTr("Remove")
            tooltip: qsTr("Removes the chosen outcome")

            onClicked: {
                deleteKey(editableCombo.currentText)
                contentmodel.remove({"text":editableCombo.currentText})
                console.log(editableCombo.currentText);
                editableCombo.currentIndex = -1
                forceupdate()
            }
        }
        TouchButton{
            width: parent.width/4
            text: qsTr("Restore defaults")
            tooltip: qsTr("Removes current, and restores default outcomes")

            onClicked: {
                dialogRestoretodefaults.visible = true
            }
        }

        TouchButton{
            width: parent.width/4
            text: qsTr("Close")
            tooltip: qsTr("Closes the dialog")

            onClicked: {
                adminmodule.visible = false;
                contentmodel.clear();
            }
        }
    }
    MessageDialog {
        id: dialogRestoretodefaults
        title: qsTr("Restore to defaults?")
        text: qsTr("Are you sure that you want to restore to default? Can´t be undone.")
        standardButtons: StandardButton.Yes | StandardButton.No
        onYes: {
            restoreDefaults();
            contentmodel.clear();
            forceupdate()
        }
        onNo: {

        }
    }
    ComboBox {
        id: editableCombo
        anchors.top: rowarea.bottom
        editable: false
        model:contentmodel
        width: parent.width
        onAccepted: {
            if (editableCombo.find(currentText) === -1) {
                model.append({text: editText})
                currentIndex = editableCombo.find(editText)
            }

            return editableCombo.find(currentText);
        }

        ListModel {
                    id: mmodel
                }
    }




}
