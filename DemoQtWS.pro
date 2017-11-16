QT += qml quick multimedia
CONFIG += c++11

SOURCES += main.cpp \
    TranslationSelect.cpp \
    AzureEvent.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

TRANSLATIONS += Translation/DemoQtWS_en.ts
TRANSLATIONS += Translation/DemoQtWS_fr.ts
TRANSLATIONS += Translation/DemoQtWS_de.ts
TRANSLATIONS += Translation/DemoQtWS_it.ts

AZURE_PATH = C:/Development/Azure-IOT-ARM/azure-iot-sdk-c

equals(TEMPLATE,"vcapp"):exists($$AZURE_PATH) {
    message("Building with Azure")

    CONFIG(debug, debug|release) {
        AZURE_BUILD = Debug
    } else {
        AZURE_BUILD = Release
    }

    deployFiles.files += $${AZURE_PATH}/iothub_client/$${AZURE_BUILD}/iothub_client_dll.dll
    INSTALLS += deployFiles

    LIBS += $${AZURE_PATH}/iothub_client/$${AZURE_BUILD}/iothub_client.lib
    LIBS += $${AZURE_PATH}/iothub_client/$${AZURE_BUILD}/iothub_client_amqp_transport.lib
    LIBS += $${AZURE_PATH}/iothub_client/$${AZURE_BUILD}/iothub_client_http_transport.lib
    LIBS += $${AZURE_PATH}/iothub_client/$${AZURE_BUILD}/iothub_client_amqp_ws_transport.lib
    LIBS += $${AZURE_PATH}/iothub_client/$${AZURE_BUILD}/iothub_client_mqtt_transport.lib
    LIBS += $${AZURE_PATH}/iothub_client/$${AZURE_BUILD}/iothub_client_mqtt_ws_transport.lib
    LIBS += $${AZURE_PATH}/umqtt/$${AZURE_BUILD}/umqtt.lib
    LIBS += $${AZURE_PATH}/c-utility/$${AZURE_BUILD}/aziotsharedutil.lib
    LIBS += $${AZURE_PATH}/uamqp/$${AZURE_BUILD}/uamqp.lib

    INCLUDEPATH += $${AZURE_PATH}/iothub_client/../deps/parson
    INCLUDEPATH += $${AZURE_PATH}/deps/uhttp/deps/c-utility/inc
    INCLUDEPATH += $${AZURE_PATH}/iothub_client/inc
    INCLUDEPATH += $${AZURE_PATH}/uamqp/inc
    INCLUDEPATH += $${AZURE_PATH}/umqtt/inc

    SOURCES += AzureConnection.cpp
    HEADERS += AzureConnection.h

    DEFINES += DEF_USE_AZURE
}



# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES +=

HEADERS += \
    TranslationSelect.h \
    AzureEvent.h

qtPrepareTool(LRELEASE, lrelease)
for(tsfile, TRANSLATIONS) {
 qmfile = $$shadowed($$tsfile)
 qmfile ~= s,.ts$,.qm,
 qmdir = $$dirname(qmfile)
 !exists($$qmdir) {
 mkpath($$qmdir)|error("Aborting.")
 }
 command = $$LRELEASE -removeidentical $$tsfile -qm $$qmfile
 system($$command)|error("Failed to run: $$command")
 TRANSLATIONS_FILES += $$qmfile
}
