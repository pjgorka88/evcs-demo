#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFontDatabase>
#include "TranslationSelect.h"

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
    QObject::connect( &translation, &TranslationSelect::languageChanged,
                      &engine, &QQmlApplicationEngine::retranslate );
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
