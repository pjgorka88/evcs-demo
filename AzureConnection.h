#ifndef AZURECONNECTION_H
#define AZURECONNECTION_H

#include <stdio.h>
#include <stdlib.h>

#include "azure_c_shared_utility/platform.h"
#include "azure_c_shared_utility/threadapi.h"
#include "azure_c_shared_utility/crt_abstractions.h"
#include "azure_c_shared_utility/shared_util_options.h"
#include "iothub_client.h"
#include "iothub_client_options.h"
#include "iothub_message.h"
#include "iothubtransportamqp.h"

#include <QString>
#include <QObject>
#include <QThread>
#include <QMutex>
#include <QQueue>
#include <QMutexLocker>


typedef struct EVENT_INSTANCE_TAG
{
    IOTHUB_MESSAGE_HANDLE messageHandle;
    size_t messageTrackingId;  // For tracking the messages within the user callback.
} EVENT_INSTANCE;

class CAzureConnectionThread;
class CAzureConnectionWorker
{
public:
    explicit CAzureConnectionWorker(CAzureConnectionThread* thread);

    bool init(const QString& connectionString);
    bool sendMessage(const QByteArray& inMessage);
    bool update();
    bool release();

    void messageReceived(const QByteArray& message);

private:
    IOTHUB_CLIENT_LL_HANDLE mIOTClientHandle;
    size_t mMessageId;
    CAzureConnectionThread* mConnectionThread;
};
//-------------------------------------------------------------------------------------------------

class CAzureConnectionThread : public QThread
{
    Q_OBJECT
public:
    explicit CAzureConnectionThread( const QString& connectionString );
    ~CAzureConnectionThread();

    void stopThread();
    void sendMessage( const QByteArray& message );
    void messageReceived( const QByteArray& message );
Q_SIGNALS:
    void signalMessageReceived(const QByteArray& message);
protected:
    void run() override;

private:
    bool isRunning();
    QString mConnectionString;
    QMutex mMutex;
    bool mRunning;
    QQueue<QByteArray> mMessages;
};

//-------------------------------------------------------------------------------------------------
class CAzureConnection : public QObject
{
    Q_OBJECT
public:
    CAzureConnection();
    ~CAzureConnection();

    void init( const QString& connectionString );
    void release();

public Q_SLOTS:
    void slotSendMessage(const QByteArray& message);
Q_SIGNALS:
    void signalMessageReceived(const QByteArray& message);

private:
    CAzureConnectionThread* mThread;
};

#endif // AZURECONNECTION_H
