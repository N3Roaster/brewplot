import CustomComponents 1.0
import QtQuick 1.0

Rectangle {
    id: root

    property real sumy : 0
    property real sumxsq : 0
    property real sumx : 0
    property real sumxy : 0
    property int n : 0

    width: 720
    height: 680
    Component.onCompleted: {
        var quitItem = window.addMenuItem("File", "Quit");
        quitItem.shortcut = "Ctrl+Q";
        quitItem.triggered.connect(function() {
                                       Qt.quit();
                                   });
        var clearItem = window.addMenuItem("Plotting", "Clear Data");
        clearItem.triggered.connect(function() {
                                        graph.clear();
                                        dataViewModel.clear();
                                        root.sumy = 0;
                                        root.sumxsq = 0;
                                        root.sumx = 0;
                                        root.sumxy = 0;
                                        root.n = 0;
                                        graph.setFit(0, 0, 0, 0);
                                    });
        var showLeastSquares = window.addMenuItem("Plotting", "Least Squares Fit");
        showLeastSquares.checkable = true;
        showLeastSquares.triggered.connect(function() {
                                               graph.setFitVisible(showLeastSquares.checked);
                                               lsfrow.visible = showLeastSquares.checked;
                                           });
    }
    BrewingControlChart {
        id: graph

        width: 450
        height: 600
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20
    }
    Item {
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        Column {
            spacing: 8
            Row {
                spacing: 5
                Text {
                    text: "Mass of ground coffee: "
                }
                TextInput {
                    id: groundMass

                    width: 30
                    validator: DoubleValidator {
                        bottom: 0
                        decimals: 2
                        notation: DoubleValidator.StandardNotation
                    }

                    Line {
                        x1: -3
                        x2: 33
                        y1: groundMass.height
                        y2: y1
                        penWidth: 1
                        color: "black"
                    }
                }
            }
            Row {
                spacing: 5
                Text {
                    text: "Mass of brewed coffee:"
                }
                TextInput {
                    id: brewedMass

                    width: 30
                    validator: DoubleValidator {
                        bottom: 0
                        decimals: 2
                        notation: DoubleValidator.StandardNotation
                    }

                    Line {
                        x1: -3
                        x2: 33
                        y1: brewedMass.height
                        y2: y1
                        penWidth: 1
                        color: "black"
                    }
                }
            }
            Row {
                spacing: 56
                Text {
                    text: "Percent TDS:"
                }
                TextInput {
                    id: ptds
                    width: 30
                    validator: DoubleValidator {
                        bottom: 0
                        top: 100
                        decimals: 2
                        notation: DoubleValidator.StandardNotation
                    }
                    Line {
                        x1: -3
                        x2: 33
                        y1: ptds.height
                        y2: y1
                        penWidth: 1
                        color: "black"
                    }
                }
            }
            Row {
                spacing: 87
                Text {
                    id: colorlabel
                    text: "Color:"
                }
                ColorPicker {
                    id: colorpicker
                    width: 37
                    height: colorlabel.height
                }
            }
            Row {
                id: lsfrow
                visible: false

                spacing: 1
                Text {
                    id: fitcolorlabel
                    text: "Least Squares Fit Color:"
                }
                ColorPicker {
                    id: fitcolorpicker
                    width: 37
                    height: colorlabel.height
                    onColorChanged: {
                        graph.setFitColor(color)
                    }
                }
            }
            Rectangle {
                z: 0
                anchors.horizontalCenter: parent.horizontalCenter
                height: buttonText.height + 20
                width: buttonText.width + 40
                border.color: "black"
                radius: 10
                Text {
                    id: buttonText

                    text: "Plot This Brew"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        var extraction = (brewedMass.text * (ptds.text / 100)) / groundMass.text
                        graph.plotPoint(extraction, (ptds.text / 100), colorpicker.color)
                        dataViewModel.append({"color": colorpicker.color, "ptds": ptds.text, "extraction": extraction})
                        root.n += 1
                        root.sumy += (ptds.text / 100)
                        root.sumx += extraction
                        root.sumxy += ((ptds.text / 100) * extraction)
                        root.sumxsq += Math.pow(extraction, 2)
                        if(root.n > 1) {
                            var a = ((root.sumy * root.sumxsq)-(root.sumx * root.sumxy))/((root.n * root.sumxsq)-Math.pow(root.sumx, 2))
                            var b = ((root.n * root.sumxy)-(root.sumx * root.sumy))/((root.n * root.sumxsq) - Math.pow(root.sumx, 2))
                            var x1 = 0.14
                            var x2 = 0.26
                            var y1 = a + (b * x1)
                            var y2 = a + (b * x2)
                            if(y1 < 0.008) {
                                x1 = (0.008 - a) / b
                                y1 = 0.008
                            }
                            if(y2 < 0.008) {
                                x2 = (0.008 - a) / b
                                y2 = 0.008
                            }
                            if(y1 > 0.016) {
                                x1 = (0.016 - a) / b
                                y1 = 0.016
                            }
                            if(y2 > 0.016) {
                                x2 = (0.016 - a) / b
                                y2 = 0.016
                            }
                            graph.setFit(x1, y1, x2, y2);
                        }
                    }
                }
            }
            Repeater {
                id: dataView

                model: ListModel {
                    id: dataViewModel
                }
                delegate: Row {
                    spacing: 3
                    Rectangle {
                        width: 30
                        height: 30
                        color: dataViewModel.get(index).color
                    }
                    Column {
                        Text {
                            text: "Strength: "+dataViewModel.get(index).ptds+"% TDS"
                        }
                        Text {
                            text: "Extraction: "+Number(dataViewModel.get(index).extraction*100).toFixed(2)+"%"
                        }
                    }
                }
            }
        }
    }
}
