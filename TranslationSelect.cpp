#include "TranslationSelect.h"
#include <QGuiApplication>
#include <QDebug>

TranslationSelect::TranslationSelect(QObject *parent)
    : QObject(parent)
    , mCurrentLanguage( "en" )
    , mCurrentTranslator( nullptr )
{
    // English
    QTranslator* en_translator = new QTranslator( this );
    if ( en_translator->load( ":/Translation/DemoQtWS_en.qm" ) )
        mMap["en"] = en_translator;

    // French
    QTranslator* fr_translator = new QTranslator( this );
    if ( fr_translator->load( ":/Translation/DemoQtWS_fr.qm" ) )
        mMap["fr"] = fr_translator;

    // Intalian
    QTranslator* it_translator = new QTranslator( this );
    if ( it_translator->load( ":/Translation/DemoQtWS_it.qm" ) )
        mMap["it"] = it_translator;

    // German
    QTranslator* de_translator = new QTranslator( this );
    if ( de_translator->load( ":/Translation/DemoQtWS_de.qm" ) )
        mMap["de"] = de_translator;
}

bool TranslationSelect::selectLanguage( const QString& language )
{
    if ( language == mCurrentLanguage )
        return true;
    mCurrentLanguage = language;
    QTranslator* translation = mMap.value( language, nullptr );
    if ( !translation )
        return false;
    if ( mCurrentTranslator == translation  )
        return true;

    if ( mCurrentTranslator )
        qApp->removeTranslator( mCurrentTranslator );
    mCurrentTranslator = translation;
    if ( qApp->installTranslator( mCurrentTranslator ) )
    {
        emit languageChanged();
        return true;
    }
    return false;
}
