/**
 * Copyright (c) 2020 Hnuda Dzmitry. All rights reserved. This software is
 * distributed under GNU GPL v3 licence For feedbacks and questions please feel
 * free to contact me at siriusbeta100@gmail.com
**/

#ifndef APPSETTINGS_H
#define APPSETTINGS_H

#include <QObject>

class AppSettings : public QObject
{
    Q_OBJECT
public:
    explicit AppSettings(QObject *parent = nullptr);
    //Q_INVOKABLE bool isConnect();
    Q_INVOKABLE bool isConnect(QString url);

signals:

public slots:
};

#endif // APPSETTINGS_H
