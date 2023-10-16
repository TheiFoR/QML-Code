import QtQuick 6.2
import Qt5Compat.GraphicalEffects
import "qrc:/ico/"

Item {
    property int personCount: 0
    property string roomName: "Room"
    property int roomId: 0
    property int access: 0

    property color noSelected: "#bbbbbb"
    property color selected: "#ffffff"
    property color main: "#577cd3"
    property color current: noSelected

    property int colorDuration: 100
    property int rotateDuration: 1000

    Rectangle{
        id: rectangle
        height: 45

        color: "#00000000"
        radius: 50

        border.color: main
        border.width: 3

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        anchors.topMargin: 20
        anchors.rightMargin: 20
        anchors.leftMargin: 20

        Image{
            id: status
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            source: access == 1 ? "ico/room_connect_info.svg" : access == 0 ? "ico/connecting.svg" : "ico/no_connect.svg"
            sourceSize.width: 22
            sourceSize.height: 22
            anchors.leftMargin: 16

            ColorOverlay {
                id: statusOverlay
                source: parent
                color: access == -1 ? "#d84c4c" : current
                anchors.fill: parent
            }

            RotationAnimation {
                id: rotationAnim
                target: status
                property: "rotation"
                from: 0
                to: 360
                duration: rotateDuration
                loops: Animation.Infinite
                running: access == 0
            }
        }

        Text{
            id: roomLabel
            color: current
            text: roomName
            anchors.left: status.right
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

        Text{
            id: peopleCount
            color: current
            text: personCount.toString()
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: person.left
            verticalAlignment: Text.AlignVCenter
            anchors.rightMargin: 5
            font.pointSize: 12

            Behavior on color{
                ColorAnimation {
                    duration: colorDuration
                }
            }
        }

        Image{
            id: person
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            source: "ico/person.svg"
            anchors.rightMargin: 17
            sourceSize.width: 20
            sourceSize.height: 20

            ColorOverlay {
                id: personOverlay
                source: parent
                color: current
                anchors.fill: parent
            }

            PropertyAnimation {
                target: parent
                property: "color"
                from: noSelected
                to: selected
                duration: 500
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on color{
            ColorAnimation {
                duration: colorDuration // Продолжительность анимации в миллисекундах
            }
        }
        Behavior on border.color {
            ColorAnimation {
                duration: colorDuration // Продолжительность анимации в миллисекундах
            }
        }
        PropertyAnimation {
            target: parent
            property: "border.color"
            from: main
            to: "#00000000"
            duration: rotateDuration
            easing.type: Easing.InOutQuad
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                rectangle.border.color = "#00000000"
                rectangle.color = main

                roomLabel.color = selected
                peopleCount.color = selected

                personOverlay.color = selected
                statusOverlay.color = selected
            }
            onExited: {
                rectangle.border.color = main
                rectangle.color = "#00000000"

                roomLabel.color = noSelected
                peopleCount.color = noSelected

                personOverlay.color = noSelected
                statusOverlay.color = noSelected
            }
            onPressed: {

            }
            onReleased: {

            }
        }
    }
}
