#include <QBoxLayout>
#include <QFormLayout>
#include <QLineEdit>
#include <QPushButton>
#include "newpointcontrol.h"

NewPointControl::NewPointControl(QWidget *parent) :
    QWidget(parent)
{
    QVBoxLayout *layout = new QVBoxLayout;
    QFormLayout *flayout = new QFormLayout;
    QLineEdit *groundsMass = new QLineEdit;
    QLineEdit *brewMass = new QLineEdit;
    QLineEdit *tds = new QLineEdit;
    QPushButton *plot = new QPushButton(tr("Plot"));
    flayout->addRow(tr("Mass of ground coffee:"), groundsMass);
    flayout->addRow(tr("Mass of brewed coffee:"), brewMass);
    flayout->addRow(tr("% total dissolved solids:"), tds);
    layout->addLayout(flayout);
    layout->addWidget(plot);
}
