/**
 * Copyright (c) 2020 Hnuda Dzmitry. All rights reserved. This software is
 * distributed under GNU GPL v3 licence For feedbacks and questions please feel
 * free to contact me at siriusbeta100@gmail.com
**/

import QtQuick 2.6
import QtQuick.Controls 2.1 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.11 as Kirigami

Kirigami.ScrollablePage {

    property string name;
    property string url;

    property string description
    property string link
    property string pubDate


    header: Controls.ToolBar {
        contentItem: Kirigami.ActionToolBar {
            id: actionToolBar
            display: Controls.Button.IconOnly
            actions: [
                Kirigami.Action {
                    iconName: "format-text-capitalize"
                    text: qsTr("Increase text size")
                    onTriggered: feedText.font.pixelSize = feedText.font.pixelSize + 1
                },
                Kirigami.Action {
                    iconName: "format-text-lowercase"
                    text: qsTr("Reduce text size")
                    onTriggered: feedText.font.pixelSize = feedText.font.pixelSize - 1
                }
            ]
        }
    }


     ColumnLayout {
         spacing: Kirigami.Units.largeSpacing * 5
         Layout.preferredWidth:  Kirigami.Units.gridUnit * 25

        Kirigami.Label {
            id: feedText
            Layout.fillWidth: true
            anchors {
                left: parent
                right: parent
                top: parent
                bottom: parent
            }
            wrapMode: Text.WordWrap
            color: Kirigami.Theme.textColor
            text: description
        }

        Kirigami.Label {
            text: qsTr("Link: ") + "<a href='" + link + "'>" + link + "</a>"
            color: Kirigami.Theme.textColor
            MouseArea {
                anchors.fill: parent
                onClicked: { Qt.openUrlExternally(link) }
            }
        }

        Kirigami.Label {
            text: qsTr("Publication Date ") + pubDate
            color: Kirigami.Theme.textColor
        }
    }
}

