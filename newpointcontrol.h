#ifndef NEWPOINTCONTROL_H
#define NEWPOINTCONTROL_H

#include <QWidget>
#include <QVariant>
#include <QLineEdit>

class NewPointControl : public QWidget
{
    Q_OBJECT
public:
    explicit NewPointControl(QWidget *parent = 0);
signals:
    void newPoint(QVariantMap pointDescription);
public slots:
    void plotButtonClicked();
private:
    QLineEdit *groundsMass;
    QLineEdit *brewMass;
    QLineEdit *tds;
};

#endif // NEWPOINTCONTROL_H
