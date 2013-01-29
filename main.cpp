#include <QtGui>
#include <QtDeclarative>
#include "qmlapplicationviewer.h"
#include "qmllineitem.h"
#include "newpointcontrol.h"

class QmlWindow : public QMainWindow
{
    Q_OBJECT
public:
    QmlWindow(QWidget *parent = NULL);
    Q_INVOKABLE QAction *addMenuItem(QString menu, QString item);
private:
    QHash<QString,QMenu *> menus;
};

QmlWindow::QmlWindow(QWidget *parent) : QMainWindow(parent)
{

}

QAction *QmlWindow::addMenuItem(QString menu, QString item)
{
    QMenu *theMenu;
    if(menus.contains(menu))
    {
        theMenu = menus.value(menu);
    }
    else
    {
        theMenu = menuBar()->addMenu(menu);
        menus.insert(menu, theMenu);
    }
    return theMenu->addAction(item);
}

QML_DECLARE_TYPE(QmlWindow)

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterType<QmlLineItem>("CustomComponents", 1, 0, "Line");
    qmlRegisterType<QmlWindow>("CustomComponents", 1, 0, "Window");

    QmlWindow *window = new QmlWindow(NULL);
    window->setWindowTitle("BrewPlot");
    QmlApplicationViewer *viewer = new QmlApplicationViewer;
    viewer->setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer->rootContext()->setContextProperty("window", window);
    viewer->setSource(QUrl("qrc:/qml/qml/BrewPlot/main.qml"));
    app.connect(viewer->engine(), SIGNAL(quit()), SLOT(quit()));
    QWidget *central = new QWidget;
    QHBoxLayout *layout = new QHBoxLayout;
    NewPointControl *control = new NewPointControl;
    layout->addWidget(control);
    layout->addWidget(viewer);
    central->setLayout(layout);
    window->setCentralWidget(central);
    viewer->setMinimumSize(viewer->sizeHint());
    window->show();

    return app.exec();
}

#include "moc_main.cpp"
