#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFontDatabase>
#include "TranslationSelect.h"
#include "AzureEvent.h"
#ifdef DEF_USE_AZURE
    #include "AzureConnection.h"
#endif

static const char* connectionString = "";

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    //QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QFontDatabase::addApplicationFont( ":/Assets/Fonts/TitilliumWeb-Black.ttf" );
    QFontDatabase::addApplicationFont( ":/Assets/Fonts/TitilliumWeb-Bold.ttf" );
    QFontDatabase::addApplicationFont( ":/Assets/Fonts/TitilliumWeb-BoldItalic.ttf" );
    QFontDatabase::addApplicationFont( ":/Assets/Fonts/TitilliumWeb-ExtraLight.ttf" );
    QFontDatabase::addApplicationFont( ":/Assets/Fonts/TitilliumWeb-ExtraLightItalic.ttf" );
    QFontDatabase::addApplicationFont( ":/Assets/Fonts/TitilliumWeb-Italic.ttf" );
    QFontDatabase::addApplicationFont( ":/Assets/Fonts/TitilliumWeb-Light.ttf" );
    QFontDatabase::addApplicationFont( ":/Assets/Fonts/TitilliumWeb-LightItalic.ttf" );
    QFontDatabase::addApplicationFont( ":/Assets/Fonts/TitilliumWeb-Regular.ttf" );
    QFontDatabase::addApplicationFont( ":/Assets/Fonts/TitilliumWeb-SemiBold.ttf" );
    QFontDatabase::addApplicationFont( ":/Assets/Fonts/TitilliumWeb-SemiBoldItalic.ttf" );

    QFont font( "Titillium Web" );
    QGuiApplication::setFont(font);

    qmlRegisterSingletonType(QUrl("qrc:///Variables.qml"), "App", 1, 0, "Variables");
    QQmlApplicationEngine engine;
    TranslationSelect translation;
    engine.rootContext()->setContextProperty( "translation", (QObject*)&translation);
    CAzureEvent aev;
    engine.rootContext()->setContextProperty( "azureEvent", (QObject*)&aev);
    #ifdef DEF_USE_AZURE
        CAzureConnection connection;
        connection.init(connectionString);
        QObject::connect(&aev, &CAzureEvent::signalSendEvent,
                         &connection, &CAzureConnection::slotSendMessage);
    #endif

#if ( QT_VERSION >= QT_VERSION_CHECK(5, 10, 0) )
    QObject::connect( &translation, &TranslationSelect::languageChanged,
                      &engine, &QQmlApplicationEngine::retranslate );
#endif
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    int rep = app.exec();
    #ifdef DEF_USE_AZURE
        connection.release();
    #endif
    return rep;
}
