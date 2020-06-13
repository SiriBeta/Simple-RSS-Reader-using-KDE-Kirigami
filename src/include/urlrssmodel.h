/**
 * Copyright (c) 2020 Hnuda Dzmitry. All rights reserved. This software is
 * distributed under GNU GPL v3 licence For feedbacks and questions please feel
 * free to contact me at siriusbeta100@gmail.com
**/

#ifndef URLRSSMODEL_H
#define URLRSSMODEL_H

#include <QSettings>
#include <QAbstractListModel>
#include <QVariant>
#include <QMetaType>
#include <QJsonObject>
#include <QNetworkAccessManager>

struct RssChanel {
    QString name;
    QString url;
    QJsonObject toJson() const {
          return {{"name", name}, {"url", url}};
    }
};

Q_DECLARE_METATYPE(RssChanel)
Q_DECLARE_METATYPE(QList<RssChanel>)

class UrlRssModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum UrlRssRoles {
        NameRole = Qt::UserRole,
        UrlRole
    };
    Q_ENUM(UrlRssRoles)

    UrlRssModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    virtual QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE QVariantMap get(int row) const;
    Q_INVOKABLE void append(const QString &url);
    Q_INVOKABLE void set(int row, const QString &beforeUrl, const QString afterUrl);
    Q_INVOKABLE void remove(int row);

    QString getRssName(const QString &url);

private:
    QList<RssChanel> m_urlRssChanel;
    QNetworkAccessManager *manager = new QNetworkAccessManager(this);
    void saveModel();
    void readModel();
    bool urlCheck(const QString &url);
};

#endif // URLRSSMODEL_H
