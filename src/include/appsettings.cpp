/**
 * Copyright (c) 2020 Hnuda Dzmitry. All rights reserved. This software is
 * distributed under GNU GPL v3 licence For feedbacks and questions please feel
 * free to contact me at siriusbeta100@gmail.com
**/

#include "appsettings.h"
#include <QNetworkAccessManager>
#include <QEventLoop>
#include <QNetworkReply>

AppSettings::AppSettings(QObject *parent) : QObject(parent)
{

}

bool AppSettings::isConnect(QString url)
{
    QNetworkAccessManager nam;
    QNetworkRequest req(url);
    QNetworkReply *reply = nam.get(req);
    QEventLoop loop;
    connect(reply, SIGNAL(finished()), &loop, SLOT(quit()));
    loop.exec();
    if(reply->bytesAvailable())
        return true;
    else
        return false;
}
