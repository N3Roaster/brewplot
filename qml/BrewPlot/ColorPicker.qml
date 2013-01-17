import QtQuick 1.0

Rectangle {
    id: colorpicker

    color: "red"
    Rectangle {
        id: pickControl

        x: 40; y: 0; z: 10
        width: 260; height: 50
        color: "white"
        border {color: "black"; width: 3}
        radius: 5
        opacity: 0

        Repeater {
            model: ListModel {

                ListElement {
                    theColor: "red"
                }
                ListElement {
                    theColor: "orange"
                }
                ListElement {
                    theColor: "yellow"
                }
                ListElement {
                    theColor: "green"
                }
                ListElement {
                    theColor: "blue"
                }
                ListElement {
                    theColor: "indigo"
                }
                ListElement {
                    theColor: "violet"
                }
            }
            Rectangle {
                width: 30; height: 30
                x: (35*index)+10; y: 10
                color: theColor
                opacity: 1

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        pickControl.opacity = 0
                        colorpicker.color = parent.color
                    }
                }
            }
        }

        Behavior on opacity {
            PropertyAnimation {
                duration: 250
            }
        }
    }
    MouseArea {
        anchors.fill: parent

        onClicked: {
            pickControl.opacity = 1
        }
    }
}
