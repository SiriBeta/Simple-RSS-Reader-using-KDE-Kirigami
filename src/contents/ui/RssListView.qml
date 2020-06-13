/**
 * Copyright (c) 2020 Hnuda Dzmitry. All rights reserved. This software is
 * distributed under GNU GPL v3 licence For feedbacks and questions please feel
 * free to contact me at siriusbeta100@gmail.com
**/

import QtQuick 2.4
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.11 as Kirigami
import QtQuick.XmlListModel 2.12
import "models"
import "components"
import AppSettings 1.0

Kirigami.ScrollablePage {
    id: root

    property string name
    property string url

    title: name

    FeedPage {
        id: feedPage
    }

    RssFeedModel {
        id: feedModel
        source: url
        onStatusChanged: {
            if (feedModel.status == XmlListModel.Ready) {
                busyIndicator.visible = false;
                feedListView.visible = true;
            }
        }
    }

    AppSettings {
        id: appSettings
    }

    NoConnectPage {
        id: noConnectPage
        anchors.fill: parent
        visible: false
    }
    Controls.BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        visible: false
    }

    Kirigami.CardsListView {
        id: feedListView
        visible: false
        model: feedModel
        delegate: Kirigami.Card {
            headerOrientation: Qt.Horizontal
            Rectangle {
                color: Kirigami.Theme.highlightColor
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                width: 10
            }
            contentItem: ColumnLayout {
                height: parent.height
                width: parent.width
                Kirigami.Heading {
                    Layout.fillWidth: true
                    wrapMode: Text.WordWrap
                    level: 2
                    text: removeHtml(model.title)
                }
                Text {
                    Layout.fillWidth: true
                    wrapMode: Text.WordWrap
                    color: Kirigami.Theme.textColor
                    text: slice(removeHtml(model.description), 200)
                }

            }
            onClicked:  {
                feedPage.title = removeHtml(model.title)
                feedPage.description = model.description
                feedPage.link = model.link
                feedPage.pubDate = model.pubDate
                pageStack.push(feedPage);
            }
        }
    }

    Timer {
        id: timer
        interval: 500; running: false; repeat: true
        onTriggered: connectCheck()
    }

    function slice(text, quantity){
        var sl = text
        return sl.slice(0,quantity) + "..."
    }

    function removeHtml(text) {
        return text.replace(/<[^>]+>/g,'');
    }

   function connectCheck() {
        timer.running = false;
        noConnectPage.visible = false;
        busyIndicator.visible = false;
        feedListView.visible = false;
        if (appSettings.isConnect(url)) {
            timer.running = false;
            feedModel.reload()
            noConnectPage.visible = false;
            busyIndicator.visible = true;
            feedListView.visible = false;
        }
        else {
            timer.running = true;
            feedListView.visible = false;
            busyIndicator.visible = false;
            noConnectPage.visible = true;
        }
    }
}
