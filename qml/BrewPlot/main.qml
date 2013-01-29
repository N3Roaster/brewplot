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

    BrewingControlChart {
        id: graph

        width: 450; height: 600
        anchors {right: parent.right; rightMargin: 20; top: parent.top; topMargin: 20}
    }
    Item {
        anchors {left: parent.left; leftMargin: 10; top: parent.top; topMargin: 10}

        Column {
            spacing: 8

            ListView {
                spacing: 3
                height: 400
                width: 100
                z: -1
                contentHeight: dataViewModel.count * 35

                model: ListModel {
                    id: dataViewModel
                }
                delegate: Row {
                    spacing: 3

                    Rectangle {
                        width: 30; height: 30
                        color: dataViewModel.get(index).color
                    }
                    Column {
                        Text {
                            text: "Strength: " + dataViewModel.get(index).ptds + "% TDS"
                        }
                        Text {
                            text: "Extraction: " + Number(dataViewModel.get(index).extraction * 100).toFixed(2) + "%"
                        }
                    }
                }
            }
        }
    }


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
        window.newPoint.connect(function(pointDescription) {
            graph.plotPoint(pointDescription.extraction,
                            pointDescription.ptds / 100,
                            pointDescription.color)
            dataViewModel.append(pointDescription)
            root.n += 1
            root.sumy += pointDescription.ptds / 100
            root.sumx += pointDescription.extraction
            root.sumxy += ((pointDescription.ptds / 100) * extraction)
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
                    y2 = 0.016
                }
                if(y2 > 0.016) {
                    x2 = (0.016 - a) / b
                    y2 = 0.016
                }
                graph.setFit(x1, y1, x2, y2)
            }
        });
    }
}
