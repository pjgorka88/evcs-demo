#ifndef TRANSLATIONSELECT_H
#define TRANSLATIONSELECT_H

#include <QObject>
#include <QHash>
#include <QTranslator>

class TranslationSelect : public QObject
{
    Q_OBJECT
public:
    explicit TranslationSelect(QObject *parent = nullptr);

    Q_INVOKABLE bool selectLanguage( const QString& language );

signals:
    void languageChanged();

private:
    QHash<QString, QTranslator* > mMap;
    QString mCurrentLanguage;
    QTranslator* mCurrentTranslator;
};

#endif // TRANSLATIONSELECT_H
