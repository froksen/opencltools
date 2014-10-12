import QtQuick 2.3
import QtQuick.Controls 1.1
import "settingsdialog"
import "aboutdialog"
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.1  // needed for the Window component


ApplicationWindow {
    property variant settingsdialog;
    property string windowtitleExtra: " "

    id: mainWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Open CL Tools") + " " + windowtitleExtra


    /* The Menubar */
    menuBar: MenuBar {
        Menu {
            title: qsTr("Files")
            MenuItem{
                text: qsTr("About")
                onTriggered: {
                    aboutdialog.open()
                }
            }
           /* MenuItem{
                text: qsTr("Settings")
                onTriggered: {
                    settingsdialog.open()
                }
            }*/

            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    /* The TabViews */
    TabView {
        anchors.fill: parent
        id: tabView

        Component.onCompleted: {
            addTab(qsTr("Countdown timer"), tab_countdowntimer)
            addTab(qsTr("Stopwatch"), tab_stopwatch)
            addTab(qsTr("Start chooser (Thing)"),tab_startchooser)
            addTab(qsTr("Start chooser (Number)"),tab_startchooserbynumber)
         }

        onCurrentIndexChanged: {
            windowtitleExtra = ""
        }

        Component {
            id: tab_countdowntimer
            TimerCountdown{
            }
        }

        Component {
            id: tab_stopwatch
            TimerStopwatch{

            }
        }
        Component{
            id: tab_startchooser
            StartChooserByThing{

            }
        }

        Component{
            id:tab_startchooserbynumber
            StartChooserByNumber{

            }
        }

    }

    /* The Settingsdialog */
    AboutDialog{
        id: aboutdialog

    }

    /* The Settingsdialog */
    /*SettingsDialog{
        id: settingsdialog
    }*/
}
