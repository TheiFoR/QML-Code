import QtQuick 6.2
import Qt5Compat.GraphicalEffects
import "qrc:/ico/"

Item {
    property string label: "label"
    property string ico: "ico/play.svg"

    property color noSelected: "#bbbbbb"
    property color selected: "#ffffff"
    property color main: "#577cd3"
    property color current: noSelected

    property int colorDuration: 100

    width: parent.width
    height: parent.height

    Rectangle{
        id: rectangle

        color: "#00000000"
        radius: 50

        border.color: main
        border.width: 3

        width: parent.width
        height: parent.height

        Image{
            id: image
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            source: ico
            sourceSize.width: 22
            sourceSize.height: 22
            anchors.leftMargin: 13

            ColorOverlay {
                id: imageOverlay
                source: parent
                color: current
                anchors.fill: parent
            }
        }

        Text{
            id: labelText
            color: current
            text: label
            anchors.left: image.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 10
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            font.pointSize: 12

            Behavior on color{
                ColorAnimation {
                    duration: colorDuration
                }
            }
        }

        Behavior on color{
            ColorAnimation {
                duration: colorDuration
            }
        }
        Behavior on border.color {
            ColorAnimation {
                duration: colorDuration
            }
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                rectangle.border.color = "#00000000"
                rectangle.color = main

                labelText.color = selected

                imageOverlay.color = selected
            }
            onExited: {
                rectangle.border.color = main
                rectangle.color = "#00000000"

                labelText.color = noSelected

                imageOverlay.color = noSelected
            }
            onPressed: {

            }
            onReleased: {

            }
        }
    }
}
