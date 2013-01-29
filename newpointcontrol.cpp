#include <QBoxLayout>
#include <QFormLayout>
#include <QLineEdit>
#include <QPushButton>
#include "newpointcontrol.h"

NewPointControl::NewPointControl(QWidget *parent) :
    QWidget(parent), groundsMass(new QLineEdit), brewMass(new QLineEdit),
    tds(new QLineEdit)
{
    QVBoxLayout *layout = new QVBoxLayout;
    QFormLayout *flayout = new QFormLayout;
    QPushButton *plot = new QPushButton(tr("Plot"));
    flayout->addRow(tr("Mass of ground coffee:"), groundsMass);
    flayout->addRow(tr("Mass of brewed coffee:"), brewMass);
    flayout->addRow(tr("% total dissolved solids:"), tds);
    layout->addLayout(flayout);
    layout->addWidget(plot);
    layout->addStretch();
    setLayout(layout);
    connect(plot, SIGNAL(clicked()), this, SLOT(plotButtonClicked()));
}

void NewPointControl::plotButtonClicked()
{
    QVariantMap pointDescription;
    pointDescription.insert("groundMass", groundsMass->text());
    pointDescription.insert("brewedMass", brewMass->text());
    pointDescription.insert("ptds", tds->text());
    pointDescription.insert("color", "red");
    double extraction = (brewMass->text().toDouble() *
            (tds->text().toDouble() / 100)) /
            groundsMass->text().toDouble();
    pointDescription.insert("extraction", extraction);
    emit newPoint(pointDescription);
}
