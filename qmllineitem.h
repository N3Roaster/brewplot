#ifndef QMLLINEITEM_H
#define QMLLINEITEM_H

#include <QDeclarativeItem>
#include <QPainter>

class QmlLineItem : public QDeclarativeItem
{
    Q_OBJECT
    Q_PROPERTY(int x1 READ x1 WRITE setX1 NOTIFY x1Changed);
    Q_PROPERTY(int y1 READ y1 WRITE setY1 NOTIFY y1Changed);
    Q_PROPERTY(int x2 READ x2 WRITE setX2 NOTIFY x2Changed);
    Q_PROPERTY(int y2 READ y2 WRITE setY2 NOTIFY y2Changed);
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged);
    Q_PROPERTY(int penWidth READ penWidth WRITE setPenWidth NOTIFY penWidthChanged);
public:
    QmlLineItem(QDeclarativeItem *parent = NULL);
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option,
               QWidget *widget);
    int x1() const;
    int y1() const;
    int x2() const;
    int y2() const;
    QColor color() const;
    int penWidth() const;
    void setX1(int x1);
    void setY1(int y1);
    void setX2(int x2);
    void setY2(int y2);
    void setColor(const QColor &color);
    void setPenWidth(int newWidth);

signals:
    void x1Changed();
    void y1Changed();
    void x2Changed();
    void y2Changed();
    void colorChanged();
    void penWidthChanged();

private:
    void updateSize();
    int m_x1;
    int m_y1;
    int m_x2;
    int m_y2;
    QColor m_color;
    int m_penWidth;
};

QML_DECLARE_TYPE(QmlLineItem)

#endif
