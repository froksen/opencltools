TEMPLATE = app

TARGET = opencltools

QT += qml quick widgets

Qt -= gui

SOURCES += main.cpp

lupdate_only{
    SOURCES =  qml/*.qml \
               qml/settingsdialog/*.qml\
               qml/aboutdialog/*.qml\

}

TRANSLATIONS =  i18n/base.ts\
                i18n/da_DK.ts\

RESOURCES +=

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

OTHER_FILES += sounds/*.mp3 \
               images/*.png \
               i18n/*.qm\

RC_FILE = cltools.rc
