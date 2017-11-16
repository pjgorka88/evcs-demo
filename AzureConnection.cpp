#include "AzureConnection.h"

static void SendConfirmationCallback(IOTHUB_CLIENT_CONFIRMATION_RESULT result, void* userContextCallback)
{
    Q_UNUSED(result)
    EVENT_INSTANCE* eventInstance = (EVENT_INSTANCE*)userContextCallback;
    IoTHubMessage_Destroy(eventInstance->messageHandle);
    delete eventInstance;
}

static IOTHUBMESSAGE_DISPOSITION_RESULT ReceiveMessageCallback(IOTHUB_MESSAGE_HANDLE message, void* userContextCallback)
{
    CAzureConnectionWorker* connection = (CAzureConnectionWorker*)userContextCallback;

    IOTHUBMESSAGE_CONTENT_TYPE contentType = IoTHubMessage_GetContentType(message);
    if (contentType == IOTHUBMESSAGE_BYTEARRAY)
    {
        const unsigned char* buffer = NULL;
        size_t size = 0;
        if (IoTHubMessage_GetByteArray(message, &buffer, &size) == IOTHUB_MESSAGE_OK)
        {
            connection->messageReceived( QByteArray((const char*)buffer,size));
        }
    }
    return IOTHUBMESSAGE_ACCEPTED;
}

CAzureConnectionWorker::CAzureConnectionWorker(CAzureConnectionThread* thread)
    : mIOTClientHandle(NULL)
    , mMessageId(0)
    , mConnectionThread(thread)
{
}

bool CAzureConnectionWorker::init(const QString& connectionString)
{
    // Initialize
    if (platform_init() != 0)
        return false;

    // Create the connection string
    mIOTClientHandle = IoTHubClient_LL_CreateFromConnectionString(qPrintable(connectionString), AMQP_Protocol);
    if (mIOTClientHandle == NULL)
        return false;

    // Register the receiving function
    IOTHUB_CLIENT_RESULT receiveEvent = IoTHubClient_LL_SetMessageCallback(mIOTClientHandle, ReceiveMessageCallback, this);
    if (receiveEvent != IOTHUB_CLIENT_OK)
        return false;

    return true;
}

bool CAzureConnectionWorker::sendMessage(const QByteArray& inMessage)
{
    // Create the message
    EVENT_INSTANCE* message = new EVENT_INSTANCE;
    message->messageHandle = IoTHubMessage_CreateFromByteArray((const unsigned char*)inMessage.constData(), inMessage.size());
    if (message->messageHandle == NULL)
        return false;
    message->messageTrackingId = mMessageId++;

    IOTHUB_CLIENT_RESULT sendEvent = IoTHubClient_LL_SendEventAsync(mIOTClientHandle, message->messageHandle, SendConfirmationCallback, message);
    if (sendEvent != IOTHUB_CLIENT_OK)
    {

        IoTHubMessage_Destroy(message->messageHandle);
        delete message;
        return false;
    }
    return true;
}

bool CAzureConnectionWorker::update()
{
    IoTHubClient_LL_DoWork(mIOTClientHandle);
    return true;
}

bool CAzureConnectionWorker::release()
{
    IoTHubClient_LL_Destroy(mIOTClientHandle);
    platform_deinit();
    return true;
}

void CAzureConnectionWorker::messageReceived(const QByteArray& message)
{
    if (mConnectionThread)
        mConnectionThread->messageReceived(message);
}

/*************************************************************************************************/
/*                                  CAzureConnectionThread                                       */
/*************************************************************************************************/

CAzureConnectionThread::CAzureConnectionThread(const QString& connectionString)
    : mConnectionString(connectionString)
    , mRunning(true)
{
}

CAzureConnectionThread::~CAzureConnectionThread()
{
}

void CAzureConnectionThread::stopThread()
{
    QMutexLocker lock(&mMutex);
    mRunning = false;
}

bool CAzureConnectionThread::isRunning()
{
    QMutexLocker lock(&mMutex);
    return mRunning;
}

void CAzureConnectionThread::sendMessage(const QByteArray& message)
{
    QMutexLocker lock(&mMutex);
    if (mMessages.size() < 20)
        mMessages.enqueue(message);
}

void CAzureConnectionThread::messageReceived(const QByteArray& message)
{
    Q_EMIT(signalMessageReceived(message));
}

void CAzureConnectionThread::run()
{
    CAzureConnectionWorker worker(this);
    if (!worker.init(mConnectionString))
        return;
    unsigned long sleepTime = 1;
    while (isRunning())
    {
        mMutex.lock();
        if (mMessages.size() > 0)
        {
            worker.sendMessage(mMessages.dequeue());
        }
        mMutex.unlock();
        worker.update();
        QThread::msleep(sleepTime);
    }
    worker.release();
}

/*************************************************************************************************/
/*                                  CAzureConnectionThread                                       */
/*************************************************************************************************/
CAzureConnection::CAzureConnection()
    : mThread( NULL )
{
}

CAzureConnection::~CAzureConnection()
{
}

void CAzureConnection::init( const QString& connectionString )
{
    if ( mThread )
        return;
    mThread = new CAzureConnectionThread(connectionString);
    QObject::connect(mThread, &CAzureConnectionThread::signalMessageReceived,
                     this, &CAzureConnection::signalMessageReceived, Qt::QueuedConnection);
    mThread->start();

}

void CAzureConnection::release()
{
    if (mThread)
    {
        mThread->stopThread();
        mThread->wait();
        delete mThread;
    }
    mThread = NULL;
}

void CAzureConnection::slotSendMessage(const QByteArray& inMessage)
{
    if (mThread)
        mThread->sendMessage(inMessage);
}
