import CustomComponents 1.0
import QtQuick 1.0

Item {
	id: chartOuter

	function plotPoint(px, py, pcolor) {
		chart.plotPoint(px, py, pcolor);
	}
	function setFit(x1, y1, x2, y2) {
		chart.setFit(x1, y1, x2, y2)
	}
	function setFitVisible(visible) {
		fitline.visible = visible
	}
	function setFitColor(color) {
		fitline.color = color
	}
	function clear() {
		points.clear();
	}

	Item {
		id: chart
		height: parent.height
		width: parent.width

		function plotPoint(px, py, pcolor) {
			points.append({"px": px, "py": py, "pcolor": pcolor});
		}
		function mapToX(px) {
			return (chart.width / xrange) * (px - xmin)
		}
		function mapToY(py) {
			return chart.height - ((chart.height / yrange) * (py - ymin))
		}
		function setFit(x1, y1, x2, y2) {
			fitline.x1 = mapToX(x1);
			fitline.x2 = mapToX(x2);
			fitline.y1 = mapToY(y1);
			fitline.y2 = mapToY(y2);
		}
		Line {
			id: fitline

			x1: 0
			x2: 0
			y1: 0
			y2: 0
			color: "red"
			visible: false
		}
		ListModel {
			id: xGridLines
		}
		ListModel {
			id: yGridLines
		}
		ListModel {
			id: points
		}

		Repeater {
			model: xGridLines

			Line {
				x1: (chart.width / xrange) * (value - xmin)
				x2: x1
				y1: 0
				y2: chart.height
				penWidth: pwidth
				color: "black"
			}
		}
		Repeater {
			model: yGridLines

			Line {
				x1: 0
				x2: chart.width
				y1: chart.height - ((chart.height / yrange) * (value - ymin))
				y2: y1
				penWidth: pwidth
				color: "black"
			}
		}
		Repeater {
			model: points

			Item {
				Rectangle {
					x: ((chart.width / xrange) * (px - xmin)) - (width / 2)
					y: chart.height - ((chart.height / yrange) * (py - ymin)) - (height / 2)
					width: 5
					height: 5
					color: pcolor
					smooth: true
				}
			}
		}
	}
	
	property real xmin: 0.14
	property real xmax: 0.26
	property real ymin: 0.008
	property real ymax: 0.016
	property real xrange: xmax - xmin
	property real yrange: ymax - ymin
	
	Item {
		id: yLabels

        anchors.right: chart.left
        anchors.rightMargin: 10
        y: chart.y
        Text {
            text: "0.8%"
            y: chart.mapToY(0.008) - (height/2)
            x: -width
        }
        Text {
            text: "0.9%"
            y: chart.mapToY(0.009) - (height/2)
            x: -width
        }
        Text {
            text: "1.0%"
            y: chart.mapToY(0.01) - (height/2)
            x: -width
        }
        Text {
            text: "1.1%"
            y: chart.mapToY(0.011) - (height/2)
            x: -width
        }
        Text {
            text: "1.2%"
            y: chart.mapToY(0.012) - (height/2)
            x: -width
        }
        Text {
            text: "1.3%"
            y: chart.mapToY(0.013) - (height/2)
            x: -width
        }
        Text {
            text: "1.4%"
            y: chart.mapToY(0.014) - (height/2)
            x: -width
        }
        Text {
            text: "1.5%"
            y: chart.mapToY(0.015) - (height/2)
            x: -width
        }
        Text {
            text: "1.6%"
            y: chart.mapToY(0.016) - (height/2)
            x: -width
        }
    }
    Item {
        id: xLabels

        x: chart.x
        anchors.top: chart.bottom
        anchors.topMargin: 10
        Text {
            text: "14%"
            x: chart.mapToX(0.14) - (width/2)
        }
        Text {
            text: "15%"
            x: chart.mapToX(0.15) - (width/2)
        }
        Text {
            text: "16%"
            x: chart.mapToX(0.16) - (width/2)
        }
        Text {
            text: "17%"
            x: chart.mapToX(0.17) - (width/2)
        }
        Text {
            text: "18%"
            x: chart.mapToX(0.18) - (width/2)
        }
        Text {
            text: "19%"
            x: chart.mapToX(0.19) - (width/2)
        }
        Text {
            text: "20%"
            x: chart.mapToX(0.2) - (width/2)
        }
        Text {
            text: "21%"
            x: chart.mapToX(0.21) - (width/2)
        }
        Text {
            text: "22%"
            x: chart.mapToX(0.22) - (width/2)
        }
        Text {
            text: "23%"
            x: chart.mapToX(0.23) - (width/2)
        }
        Text {
            text: "24%"
            x: chart.mapToX(0.24) - (width/2)
        }
        Text {
            text: "25%"
            x: chart.mapToX(0.25) - (width/2)
        }
        Text {
            text: "26%"
            x: chart.mapToX(0.26) - (width/2)
        }
    }
    Text {
        text: "EXTRACTION - Solubles Yield"
        x: chart.x + (chart.width/2) - (width/2)
        anchors.top: xLabels.bottom
        anchors.topMargin: 20
    }
    Item {
        anchors.right: yLabels.left
        anchors.rightMargin: 40
        y: chart.y + (chart.height/2) - (strengthLabel.height/2)
        Text {
            id: strengthLabel

            text: "STRENGTH - Solubles Concentration (%TDS)"
            rotation: -90
            x: -(width/2)
        }
    }
	Component.onCompleted: {
		xGridLines.append({"value": 0.14, "pwidth": 1})
		xGridLines.append({"value": 0.15, "pwidth": 1})
		xGridLines.append({"value": 0.16, "pwidth": 1})
		xGridLines.append({"value": 0.17, "pwidth": 1})
		xGridLines.append({"value": 0.18, "pwidth": 2})
		xGridLines.append({"value": 0.19, "pwidth": 1})
		xGridLines.append({"value": 0.20, "pwidth": 1})
		xGridLines.append({"value": 0.21, "pwidth": 1})
		xGridLines.append({"value": 0.22, "pwidth": 2})
		xGridLines.append({"value": 0.23, "pwidth": 1})
		xGridLines.append({"value": 0.24, "pwidth": 1})
		xGridLines.append({"value": 0.25, "pwidth": 1})
		xGridLines.append({"value": 0.26, "pwidth": 1})
		
		yGridLines.append({"value": 0.008, "pwidth": 1})
		yGridLines.append({"value": 0.0085, "pwidth": 1})
		yGridLines.append({"value": 0.009, "pwidth": 1})
		yGridLines.append({"value": 0.0095, "pwidth": 1})
		yGridLines.append({"value": 0.01, "pwidth": 1})
		yGridLines.append({"value": 0.0105, "pwidth": 1})
		yGridLines.append({"value": 0.011, "pwidth": 1})
		yGridLines.append({"value": 0.0115, "pwidth": 2})
		yGridLines.append({"value": 0.012, "pwidth": 1})
		yGridLines.append({"value": 0.0125, "pwidth": 1})
		yGridLines.append({"value": 0.013, "pwidth": 1})
		yGridLines.append({"value": 0.0135, "pwidth": 2})
		yGridLines.append({"value": 0.014, "pwidth": 1})
		yGridLines.append({"value": 0.0145, "pwidth": 1})
		yGridLines.append({"value": 0.015, "pwidth": 1})
		yGridLines.append({"value": 0.0155, "pwidth": 1})
		yGridLines.append({"value": 0.016, "pwidth": 1})
	}
}
