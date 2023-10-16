import QtQuick 6.2
import Qt5Compat.GraphicalEffects
import "qrc:/"

Rectangle{
    id: mainWindows
    color: "#2a2a2a"

    property int marginTop: 0
    property int marginBetween: 15

    Rectangle{
        id: roomList
        anchors.fill: parent
        anchors.bottomMargin: 70
        color: "#00000000"
        clip: true

        ListView{
            id: list
            anchors.fill: parent

            model: roomListModel

            delegate: RoomButtons{
                personCount: model.PersonCount
                roomName: model.Name
                roomId: model.Id
                access: -1

                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
            }
        }
    }

    Rectangle{
        id: rectangle
        color: "#30000000"
        anchors.top: roomList.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 10
        anchors.bottomMargin: 16
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        radius: 50

        RoundedButton{
            label: "Create room"
            ico: "ico/add.svg"

            width: 157

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right

            anchors.rightMargin: 5
            anchors.topMargin: 5
            anchors.bottomMargin: 5

            MouseArea{
                anchors.fill: parent

                onClicked: {
                    roomListModel.add("Room", "0.0.0.0", 1708);
                }
            }
        }

        Image {
            id: roomsCountIco
            anchors.verticalCenter: parent.verticalCenter
            source: "ico/room_info.svg"

            sourceSize.width: 20
            sourceSize.height: 20

            anchors.left: parent.left
            anchors.leftMargin: 18

            ColorOverlay {
                id: roomsCountIcoOverlay
                source: parent
                color: "#bbbbbb"
                anchors.fill: parent
            }
        }

        Text {
            id: roomCount

            property int countRooms: 1

            text: qsTr("Total rooms: " + countRooms.toString())
            color: "#bbbbbb"

            font.pointSize: 12

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: roomsCountIco.right
            anchors.leftMargin: 8
        }
    }
}
