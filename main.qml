import QtQuick 6.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects
import "qrc:/"

Window {
    id: window
    objectName: "mainWindow"

    visible: true

    minimumHeight: 400
    minimumWidth: 7
    width: 735
    height: 400
    color: windowBackgroundColor

/*-------------- Settings -------------------*/

    property color mainColor: "#577cd3"
    property color panelBackgroundColor: "#2a2a2a"
    property color windowBackgroundColor: "#121212"
    property color overlayIcoColor: "#bbbbbb"
    property color textColor1: "#ffffff"

    property int borderRadius: 30
    property int panelDistance: 15

    property int leftPanelWidth: 150
    property int bottomPanelHeight: 50

    property int itemBorderDistance: 10
    property int itemDistance: 20
    property int itemRadius: 20
    property int itemSize: 70

    property int bottomIcoSize: 25                  //Size of all icons at the bottom
    property int bottomLeftRightMargin: 17               //Icon margin at the bottom left
    property int bottomSpaceMargin: 10               //Icon margin at the bottom left

    property int buttonSize: 40                     //Size of all buttons on the left panel
    property int buttonMargin: 10                   //Margin button

    property int visualHeight: 3                    //Slider height
    property int knobHeight: 20                     //Slider Knob height

/*-------------------------------------------*/

    property int itemBorderDistanceW: itemBorderDistance
    property int itemBorderDistanceH: itemBorderDistance

    property int itemDistanceW: itemDistance
    property int itemDistanceH: itemDistance

    property int itemDistanceWOffset: 0
    property int itemBorderDistanceWOffset: 0

    GridLayout {
        id: grid
        objectName: "Grid"
        anchors.fill: parent
        columnSpacing: panelDistance
        rowSpacing: panelDistance
        anchors.rightMargin: panelDistance
        anchors.leftMargin: panelDistance
        anchors.bottomMargin: panelDistance
        anchors.topMargin: panelDistance

        rows: 2
        columns: 4

        Rectangle{
            id: leftPanel

            width: leftPanelWidth
            color: panelBackgroundColor;
            radius: borderRadius

            Layout.fillHeight: true
            Layout.fillWidth: false

            Layout.columnSpan: 1
            Layout.rowSpan: 2

            Layout.row: 0
            Layout.column: 0

            PanelButton{
                id: home

                height: buttonSize

                text: "Home"
                iconSource: "qrc:/ico/home.svg"

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top

                anchors.topMargin: buttonMargin
                anchors.rightMargin: buttonMargin
                anchors.leftMargin: buttonMargin

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        mainLoader.source = "qrc:/home.qml"
                    }
                }
            }

            PanelButton{
                id: rooms

                height: buttonSize

                text: "Rooms"
                iconSource: "qrc:/ico/rooms.svg"

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: home.bottom

                anchors.topMargin: buttonMargin
                anchors.rightMargin: buttonMargin
                anchors.leftMargin: buttonMargin

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        mainLoader.source = "qrc:/rooms.qml"
                    }
                }
            }

            PanelButton{
                id: settings

                height: buttonSize

                text: "Settings"
                iconSource: "qrc:/ico/settings.svg"

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: rooms.bottom

                anchors.topMargin: buttonMargin
                anchors.rightMargin: buttonMargin
                anchors.leftMargin: buttonMargin
            }

            PanelButton{
                id: about

                height: buttonSize

                text: "About"
                iconSource: "qrc:/ico/about.svg"

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: settings.bottom

                anchors.topMargin: buttonMargin
                anchors.rightMargin: buttonMargin
                anchors.leftMargin: buttonMargin

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        mainLoader.source = "qrc:/about.qml"
                    }
                }
            }

            PanelButton{
                id: exit

                height: buttonSize

                text: "Exit"
                iconSource: "qrc:/ico/exit.svg"

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                anchors.bottomMargin: buttonMargin
                anchors.rightMargin: buttonMargin
                anchors.leftMargin: buttonMargin
            }
        }

        Rectangle{
            id: mainPanel
            color: panelBackgroundColor
            radius: borderRadius

            Layout.fillHeight: true
            Layout.fillWidth: true

            Layout.columnSpan: 1
            Layout.rowSpan: 1

            Layout.row: 0
            Layout.column: 1

            clip: true

            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Item {
                    width: mainPanel.width
                    height: mainPanel.height
                    Rectangle {
                        anchors.centerIn: parent

                        width: mainPanel.width
                        height: mainPanel.height

                        radius: borderRadius
                    }
                }
            }

            Loader{
                id: mainLoader

                width: parent.width
                height: parent.height

                source: "qrc:/home.qml"
            }
        }

        Rectangle{
            id: bottomPanel
            color: panelBackgroundColor;
            radius: borderRadius
            height: bottomPanelHeight

            Layout.fillWidth: true

            Layout.columnSpan: 1
            Layout.rowSpan: 1

            Layout.row: 1
            Layout.column: 1

            Image {
                id: sound
                width: bottomIcoSize
                height: bottomIcoSize
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                source: "qrc:/ico/sound.svg"

                anchors.rightMargin: bottomLeftRightMargin

                ColorOverlay {
                    source: sound
                    color: overlayIcoColor
                    anchors.fill: sound
                }
            }

            Slider {
                id: slider

                height: knobHeight
                anchors.verticalCenter: parent.verticalCenter

                anchors.right: sound.left
                anchors.rightMargin: bottomSpaceMargin

                width: 100

                value: 100
                from: 0
                to: 100

                onValueChanged: {
                    volumeController.setVolume(value)
                }

                background: Rectangle {
                    id: sliderBack
                    x: slider.leftPadding
                    y: parent.height/2-2
                    implicitWidth: 200
                    implicitHeight: visualHeight
                    width: slider.width
                    height: visualHeight
                    radius: 20
                    border.width: 0
                    color: overlayIcoColor

                    Rectangle {
                        id: fillSlider
                        width: slider.visualPosition * parent.width
                        height: visualHeight
                        color: mainColor
                        radius: sliderBack.radius
                    }

                    Glow {
                        radius:sliderBack.radius
                        anchors.fill: fillSlider
                        samples: 32
                        color: mainColor
                        source: fillSlider
                        spread: 0
                    }
                }


                handle: Rectangle {
                }
            }

            Image{
                id: yaMusic
                source: "qrc:/ico/yandex_music.svg"

                anchors.right: slider.left
                anchors.rightMargin: bottomSpaceMargin

                height: bottomIcoSize
                width: bottomIcoSize

                y: parent.height/2 - height/2

                Glow {
                    radius:15
                    id: yaMusicGlow
                    anchors.fill: yaMusic
                    samples: 32
                    color: "#0fffca28"
                    visible: false
                    source: yaMusic
                    spread: 0
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        bottomPanelController.search("yandexMusic")
                    }

                    onEntered: {
                        yaMusicGlow.visible = true
                    }

                    onExited: {
                        yaMusicGlow.visible = false
                    }
                }
            }

            Image{
                id: spotify
                source: "qrc:/ico/spotify.svg"

                anchors.right: yaMusic.left
                anchors.rightMargin: bottomSpaceMargin*0.5

                height: bottomIcoSize
                width: bottomIcoSize

                y: parent.height/2 - height/2

                Glow {
                    visible: false
                    radius: 15
                    id: spotifyGlow
                    anchors.fill: spotify
                    samples: 32
                    color: "#0f4baf50"
                    source: spotify
                    spread: 0
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        bottomPanelController.search("spotify")
                    }

                    onEntered: {
                        spotifyGlow.visible = true
                    }

                    onExited: {
                        spotifyGlow.visible = false
                    }
                }
            }

            Rectangle {
                id: textField

                anchors.right: spotify.left
                anchors.left: play.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                color: "#00000000"

                clip: true

                Flickable {
                    id: flickable
                    width: parent.width
                    height: parent.height
                    flickableDirection: Flickable.HorizontalFlick
                    Text {
                        id: content
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        text: qsTr(bottomPanelController.currentTitle);
                        font.pointSize: 10
                        color: textColor1
                        Behavior on x {
                            NumberAnimation {
                                properties: "x"
                                easing.type: Easing.InOutQuad
                                duration: 200
                            }
                        }
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onWheel: {
                        if(content.width > textField.width && -content.x-10 < content.width - textField.width){
                            if(content.x <= 0 && wheel.angleDelta.y / 120 * 20 >= content.x){
                                content.x -= wheel.angleDelta.y / 120 * 20;
                            }
                            else{
                                content.x = 0
                            }
                        }
                        timer.restart()
                    }
                }
                Timer {
                    id: timer
                    interval: 700
                    repeat: false
                    onTriggered: {
                        content.x = 0;
                    }
                }
                Rectangle{
                    height: parent.height
                    width: 50
                    anchors.right: parent.right
                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop { position: 0.0; color: "#00000000" }
                        GradientStop { position: 0.8; color: panelBackgroundColor }
                    }
                }
            }



            Rectangle {
                color: "#00666666"
                id: play
                height: bottomIcoSize
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: bottomLeftRightMargin
                width: bottomIcoSize

                Image {
                    id: playIcon
                    anchors.verticalCenter: parent.verticalCenter
                    height: bottomIcoSize*bottomPanelController.scaleMultiplier
                    width: bottomIcoSize*bottomPanelController.scaleMultiplier
                    source: bottomPanelController.imageUrl
                }
                ColorOverlay {
                    source: playIcon
                    color: overlayIcoColor
                    anchors.fill: playIcon
                }

                ColorOverlay {
                    id:playOverlay
                    source: playIcon
                    color: mainColor
                    anchors.fill: playIcon
                    visible: false
                }

                Glow {
                    radius:15
                    id: playGlow
                    anchors.fill: playOverlay
                    samples: 32
                    color: mainColor
                    visible: false
                    source: playOverlay
                    spread: 0
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        bottomPanelController.playerHandler();
                    }

                    onEntered: {
                        playOverlay.visible = true
                        playGlow.visible = false
                    }

                    onExited: {
                        playOverlay.visible = false
                        playGlow.visible = false
                    }

                    onPressed: {
                        playOverlay.visible = true
                        playGlow.visible = true
                    }
                    onReleased: {
                        playOverlay.visible = true
                        playGlow.visible = false
                    }
                }
            }
        }
    }
    Text {
        id: version
        text: qsTr("v0.1.1")
        color: "#222222"

        anchors.right: parent.right
        anchors.rightMargin: 4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 2

    }
}
