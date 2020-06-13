/**
 * Copyright (c) 2020 Hnuda Dzmitry. All rights reserved. This software is
 * distributed under GNU GPL v3 licence For feedbacks and questions please feel
 * free to contact me at siriusbeta100@gmail.com
**/

#include "urlrssmodel.h"
#include <QtDebug>
#include <QVariant>
#include <QMetaType>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include <QFile>
#include <QDir>
#include <QUrl>
#include <QNetworkReply>
#include <QtXml>

UrlRssModel::UrlRssModel(QObject *parent)
    : QAbstractListModel(parent)
{
    readModel();
}

int UrlRssModel::rowCount(const QModelIndex &parent) const
{
    return m_urlRssChanel.count();
}

QVariant UrlRssModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < rowCount())
        switch (role) {
        case NameRole: return m_urlRssChanel.at(index.row()).name;
        case UrlRole: return m_urlRssChanel.at(index.row()).url;
        default: return QVariant();
        }
    return QVariant();
}

QHash<int, QByteArray> UrlRssModel::roleNames() const
{
    static const QHash<int, QByteArray> roles {
        {NameRole, "nameRole"},
        {UrlRole, "urlRole"}
    };
    return roles;
}

QVariantMap UrlRssModel::get(int row) const
{
    const RssChanel rssChanel = m_urlRssChanel.value(row);
    return {{"name", rssChanel.name}, {"url", rssChanel.url}};
}

void UrlRssModel::append(const QString &url)
{
    if (urlCheck(url)) {
        int row = 0;
        while (row < m_urlRssChanel.count() && url > m_urlRssChanel.at(row).name)
            ++row;
        beginInsertRows(QModelIndex(), row, row);
        m_urlRssChanel.insert(row, {url, url});
        endInsertRows();
        saveModel();
    }
    else {

    }
}

void UrlRssModel::set(int row, const QString &beforeUrl, const QString afterUrl)
{
    if (beforeUrl != afterUrl) {
        if (urlCheck(afterUrl))
        {
            if (row < 0 || row >= m_urlRssChanel.count())
                return;
            m_urlRssChanel.replace(row, { afterUrl, afterUrl });
            dataChanged(index(row, 0), index(row, 0), { NameRole, UrlRole });
            saveModel();
        }
        else {

        }
    }
}

void UrlRssModel::remove(int row)
{
    if (row < 0 || row >= m_urlRssChanel.count())
        return;
    beginRemoveRows(QModelIndex(), row, row);
    m_urlRssChanel.removeAt(row);
    endRemoveRows();
    saveModel();
}

void UrlRssModel::saveModel()
{
    QJsonArray jsonArray;
    for (auto & rssChanel : m_urlRssChanel)
        jsonArray.append(rssChanel.toJson());
    QFile jsonFile(QDir::homePath() + "/.config/kde.org/RSS/urlrssmodel.txt");
    QJsonObject jsonObject;
    jsonObject["UrlRssModel"] = jsonArray;
    if (!jsonFile.open(QIODevice::WriteOnly | QIODevice::Truncate)) {

    }
    jsonFile.write (QJsonDocument(jsonObject).toJson(QJsonDocument::Indented));
    jsonFile.close();
}

void UrlRssModel::readModel()
{
    QFile jsonFile(QDir::homePath() + "/.config/kde.org/RSS/urlrssmodel.txt");
    if (!jsonFile.open(QIODevice::ReadOnly | QIODevice::Text)) {
        return ;
    }
    QString jsonValue = jsonFile.readAll();
    QJsonDocument jsonDocument = QJsonDocument::fromJson(jsonValue.toUtf8());
    QJsonObject jsonObject = jsonDocument.object();
    QJsonArray jsonArray = jsonObject["UrlRssModel"].toArray();

    foreach (const QJsonValue & value, jsonArray) {
        QJsonObject jobj = value.toObject();
        QJsonValue name = jobj.value(QString("name"));
        QJsonValue url = jobj.value(QString("url"));
        m_urlRssChanel.append(RssChanel {name.toString(), url.toString()});
    }
}

bool UrlRssModel::urlCheck(const QString &url)
{
    QUrl urlChecker(url);
    if (urlChecker.isValid())
        return true;
    else
        return false;
}

QString UrlRssModel::getRssName(const QString &url)
{
    QNetworkReply *reply = manager->get(QNetworkRequest(QUrl(url)));
    if (!reply->error()) {
        QString data = reply->readAll();
        QXmlStreamReader xml(reply);
        return xml.text().toString();
    }
    else {
        qDebug() << reply->errorString();
        return "ERROR";
    }
}






