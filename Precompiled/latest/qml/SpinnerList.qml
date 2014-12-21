import QtQuick 2.3

Rectangle {
    property int spinnermodel: 10
    property int value: list.currentIndex
    property int setValue: 0

    width: parent.width
    height: width
    color: "black"

    Rectangle {
        id: mSpinner

        anchors.centerIn: parent
        width: parent.width
        height: width
        radius: 20
        color: "white"

        ListView {
            id: list
            anchors.fill: parent
            clip: true
            currentIndex: setValue

            snapMode: ListView.SnapToItem
            model: spinnermodel
            delegate: Rectangle{
              width: list.width
              height: list.height
              color: "transparent"
              //rotation: (index % 2) ? -10 : 10

              Text {
                  id: textValue
                  anchors.centerIn: parent
                  horizontalAlignment: Text.AlignHCenter
                  text: index
                  font.pixelSize: list.width
              }
            }

            //onCurrentIndexChanged: console.log("Spinner index set to: " + Math.round(list.visibleArea.yPosition * list.count))
            onMovementEnded: setValue = Math.round(list.visibleArea.yPosition * list.count)

            // Workaround: Compute visibleArea
            Component.onCompleted: list.visibleArea
        }

        Rectangle {
            id: overlay
            anchors.fill: parent
            gradient: Gradient {
                     GradientStop { position: 0.0; color: "grey" }
                     GradientStop { position: 0.20; color: "transparent" }
                     GradientStop { position: 0.45; color: "transparent" }
                     GradientStop { position: 0.5; color: "black" }
                     GradientStop { position: 0.55; color: "transparent" }
                     GradientStop { position: 0.80; color: "transparent" }
                     GradientStop { position: 1.0; color: "grey" }
            }
        }
    }
}
