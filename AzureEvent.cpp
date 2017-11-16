#include "AzureEvent.h"

#include <QtCore/QJsonObject>
#include <QtCore/QJsonDocument>
#include <QtCore/QStandardPaths>
#include <QtCore/QFile>

CAzureEvent::CAzureEvent()
    : mCost( 0 )
    , mCharging( 0 )
    , mCounter( 0 )
{
}

float CAzureEvent::cost()
{
    return mCost;
}

void CAzureEvent::setCost( float cost )
{
    mCost = cost;
    sendEvent();
}
QString CAzureEvent::userName()
{
    return mUserName;
}

void CAzureEvent::setUserName( QString str )
{
    mUserName = str;
    sendEvent();
}

void CAzureEvent::setCharging( float charge )
{
    mCharging = charge;
    sendEvent();
}

float CAzureEvent::charging()
{
    return mCharging;
}

void CAzureEvent::resetAll()
{
    mUserName.clear();
    mCharging = 0;
    mCost = 0;
    sendEvent();
}

void CAzureEvent::sendEvent()
{
    QJsonObject jobject;
    jobject["Id"] = QString::number( mCounter );
    jobject["UserName"] = mUserName;
    jobject["TotalCost"] = QString::number( mCost );
    jobject["Charging"] = QString::number( mCharging );
    mCounter++;

    QJsonDocument doc( jobject );
    Q_EMIT(signalSendEvent(doc.toJson()));
}
