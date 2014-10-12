#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QTranslator>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QString locale = QLocale::system().name();
    qDebug() << "..::Translation::.. " ;
    qDebug() << "- System locale:" << locale;

    QTranslator translator;
    if(translator.load("i18n/"+locale)){
     qDebug() << "- Translation found";
     app.installTranslator(&translator);
    }
    else {
        qDebug() << "- Translation not found";
    }

    QQmlApplicationEngine engine;
    //qDebug() << engine.offlineStoragePath();
    engine.setOfflineStoragePath(QCoreApplication::applicationDirPath()+"/Databases");
    qDebug() << "Setting offlineStoragePath to:" << engine.offlineStoragePath();
    //engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    engine.load(QUrl(QStringLiteral("qml/MainWindow.qml")));

    return app.exec();
}
