import QtQuick 2.3

Rectangle {
    property string timetext: "00:00"
    property string textColor: "black"
    readonly property string defaulttextColor: "black"
    property int maxPixelSize: height
    property int textPixelsize: parent.width*0.45

    height: parent.height
    width: parent.width

    Text{
        width: parent.width
        height: parent.height

        font.family: "Helvetica"
        font.pixelSize: textPixelsize - 50
        color: textColor
        horizontalAlignment: Text.AlignHCenter
        text: timetext
        verticalAlignment: Text.AlignVCenter

        onWidthChanged: {
            textPixelsize = parent.width*0.45 // Resets the setting

            if(height == font.pixelSize){ //Finds the maxPixelSize
                maxPixelSize = textPixelsize
                console.log("maxPixelSize set to: " + maxPixelSize)
                textPixelsize = textPixelsize + 1
            }
            else if(font.pixelSize<maxPixelSize){ //If less than maxPixelSize
                textPixelsize = parent.width*0.45 - 50
            }
            else if(font.pixelSize>maxPixelSize){ //If greater than maxPixelSize
                textPixelsize = maxPixelSize
            }

            /* DEBUGGING TEXT
            console.log("height: " + height)
            console.log ("maxPixelSize: " + maxPixelSize )
            console.log("font.pixelSize: " + font.pixelSize)
            */
        }
        onHeightChanged: {
            widthChanged();
        }
    }

}
