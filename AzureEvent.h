#ifndef AZUREEVENT_H
#define AZUREEVENT_H

#include <QObject>

class CAzureEvent : public QObject
{
    Q_OBJECT
    Q_PROPERTY( QString userName READ userName WRITE setUserName NOTIFY userNameChanged)
    Q_PROPERTY( float cost READ cost WRITE setCost NOTIFY costChanged )
    Q_PROPERTY( float charging READ charging WRITE setCharging NOTIFY chargingChanged )
public:
    CAzureEvent( );

    float cost();
    void setCost( float cost );
    QString userName();
    void setUserName( QString str );

    float charging();
    void setCharging( float charge );

    Q_INVOKABLE void sendEvent();
    Q_INVOKABLE void resetAll();

Q_SIGNALS:
    void userNameChanged();
    void costChanged();
    void chargingChanged();
    void signalSendEvent(const QByteArray&);
public:
    QString mUserName;
    float mCost;
    float mCharging;
    int mCounter;
};

#endif // AZUREEVENT_H
