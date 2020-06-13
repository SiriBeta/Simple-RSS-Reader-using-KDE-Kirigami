/**
 * Copyright (c) 2020 Hnuda Dzmitry. All rights reserved. This software is
 * distributed under GNU GPL v3 licence For feedbacks and questions please feel
 * free to contact me at siriusbeta100@gmail.com
**/

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QUrl>
#include <KLocalizedContext>
#include <include/urlrssmodel.h>
#include <include/appsettings.h>

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);
    QCoreApplication::setOrganizationName("KDE");
    QCoreApplication::setOrganizationDomain("kde.org");
    QCoreApplication::setApplicationName("RSS Reader");

    QQmlApplicationEngine engine;
    AppSettings appSettings;

    qmlRegisterType<UrlRssModel>("Backend", 1, 0, "UrlRssModel");
    qmlRegisterType<AppSettings>("AppSettings", 1, 0, "AppSettings");
    QQmlContext* cntx = engine.rootContext();
    cntx->setContextProperty("AppSettings", &appSettings);
    engine.addImportPath("qrc:/");
    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
    engine.load(QUrl(QStringLiteral("qrc:///contents/ui/main.qml")));

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
