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
import Backend 1.0
import AppSettings 1.0

Kirigami.ScrollablePage {
    id: pageRoot

    implicitWidth: Kirigami.Units.gridUnit * 20
    background: Rectangle {
        color: Kirigami.Theme.backgroundColor
    }

    title: qsTr("RSS Reader")

    AboutSheet {
        id: sheet
    }
    UrlRssModel {
        id: dataModel
    }
    RssListView {
        id: rssListView
    }
    XmlListModel {
        id: rssModelCheck
        query: "/rss/channel"

        XmlRole { name: "title"; query: "title/string()" }
    }

    actions {
        main: Kirigami.Action {
            iconName: addRssDrawer.opened ? "dialog-cancel" : "document-edit"
            checkable: true
            onTriggered: addRssDrawer.open()
        }
        contextualActions: [
            Kirigami.Action {
                text: i18n(qsTr("Settings"))
                iconName: "settings-configure"
                onTriggered: showPassiveNotification("Setting clicked")
            },
            Kirigami.Action {
                text: i18n(qsTr("About App"))
                iconName: "help-about"
                onTriggered: sheet.open()
            }
        ]
    }

    ListView {
        id: mainList
        highlightFollowsCurrentItem: false

        model: dataModel

        moveDisplaced: Transition {
            YAnimator {
                duration: Kirigami.Units.longDuration
                easing.type: Easing.InOutQuad
            }
        }
        delegate: Kirigami.SwipeListItem {
            id: listItem
            onClicked: {
                if (pageStack.depth !== 1) {
                    while (pageStack.depth  !== 1)
                        pageStack.pop()
                }
                rssListView.name = model.nameRole
                rssListView.url = model.urlRole
                pageStack.push(rssListView)
                rssListView.connectCheck()
            }

            Controls.Label {
                Layout.fillWidth: true
                height: Math.max(implicitHeight, Kirigami.Units.iconSizes.smallMedium)
                text: nameRole
                color: listItem.checked || (listItem.pressed && !listItem.checked && !listItem.sectionDelegate) ? listItem.activeTextColor : listItem.textColor
            }
            actions: [
                Kirigami.Action {
                    iconName: "edittext"
                    text: "Edit URL"
                    onTriggered: {
                        editRssDrawer.index = model.row
                        editRssDrawer.url = model.nameRole
                        editRssDrawer.open()
                    }
                },
                Kirigami.Action {
                    iconName: "edit-delete-remove"
                    text: "Delete " + model.nameRole
                    onTriggered: {
                        nameRole: model.nameRole
                        dataModel.remove(model.row)
                        showPassiveNotification("Delete")
                        if (rssListView.name == nameRole) {
                            pageStack.clear();
                            pageStack.push(mainPageComponent)
                        }
                    }
                }]
        }
    }

    Kirigami.OverlaySheet {
        id: she

        parent: applicationWindow().overlay

        header: Kirigami.Heading {
            text: qsTr("About App")
        }
        ColumnLayout {
            spacing: Kirigami.Units.largeSpacing * 5
            Layout.preferredWidth:  Kirigami.Units.gridUnit * 25
            Controls.Label {
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                text: qsTr("GNU GPL v.3 License\n" +
                           "Copyright (c) 2019 Hnuda Dzmitry")
            }
            Controls.Label {
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                text: qsTr("This application was created within the framework of the ITI BSUIR Computer Network course project. It is an example of a program demonstrating the work of Qt/QML and Kirigami technologies")
            }
        }

    }

    Kirigami.OverlayDrawer {
        id: addRssDrawer
        modal: true
        edge: Qt.BottomEdge
        ColumnLayout {
            anchors.fill: parent
            Kirigami.Heading {
                text: qsTr("Add URL RSS")
            }
            Layout.alignment: fillHeight
            Kirigami.InlineMessage {
                id: addRssInlineMessage
                visible: false
                type: Kirigami.MessageType.Warning
                Layout.fillWidth: true
                showCloseButton: true
            }
            Controls.TextField {
                id: rssAddTextField
                Layout.fillWidth: true
                Kirigami.FormData.label: "URL RSS Chanel:"
                placeholderText: "Bring it in here..."
            }
            RowLayout {
                anchors.fill: parent.parent
                Controls.Button {
                    Layout.alignment: Qt.AlignLeft
                    text: qsTr("Ok")
                    onClicked: {
                        if (rssAddTextField.text !== null) {
                            addRssInlineMessage.visible = false
                            dataModel.append(rssAddTextField.text)
                            rssAddTextField.text = ""
                            addRssDrawer.close()
                        }
                        else {
                            addRssInlineMessage.text = qsTr("URL address is incorrect or does not exist. Error: ")
                            addRssInlineMessage.visible = true
                        }
                        /*if (rssAddTextField.text !== null && rssAddTextField.text.length !== 0) {
                            //rssModelCheck.source = rssAddTextField.text
                            //rssModelCheck.reload()
                            //while (rssModelCheck.progress < 1) { showPassiveNotification(rssModelCheck.progress) }
                            if (rssModelCheck.get(0).title !== null) {
                                addRssInlineMessage.visible = false
                                dataModel.append(rssAddTextField.text)
                                rssAddTextField.text = ""
                                addRssDrawer.close()
                            }
                            else {
                                addRssInlineMessage.text = qsTr("URL address is incorrect or does not exist. Error: ")
                                addRssInlineMessage.visible = true
                            }
                        }
                        else {
                            addRssInlineMessage.text = qsTr("The field can't be empty")
                            addRssInlineMessage.visible = true
                        }*/
                    }
                }
                Controls.Button {
                    Layout.alignment: Qt.AlignRight
                    text: qsTr("Close")
                    onClicked: {
                        rssAddTextField.text = ""
                        addRssInlineMessage.visible = false
                        addRssDrawer.close()
                    }
                }
            }
        }
    }

    Kirigami.OverlayDrawer {

        property int index: 0;
        property string url;

        id: editRssDrawer
        modal: true
        edge: Qt.BottomEdge
        ColumnLayout {
            anchors.fill: parent
            Kirigami.Heading {
                text: qsTr("Edit URL RSS")
            }
            Kirigami.InlineMessage {
                id: editRssInlineMessage
                visible: false
                type: Kirigami.MessageType.Warning
                Layout.fillWidth: true
                showCloseButton: true
                text: qsTr("The field can't be empty")
            }
            Layout.alignment: fillHeight
            Controls.TextField {
                id: rssEditTextField
                Layout.fillWidth: true
                Kirigami.FormData.label: "URL RSS Chanel:"
                placeholderText: "Bring it in here..."
                //text: editRssDrawer.url
            }
            RowLayout {
                Controls.Button {
                    Layout.alignment: Qt.AlignLeft
                    text: qsTr("Ok")
                    onClicked: {
                        if (rssAddTextField.text !== null && rssAddTextField.text.length !== 0) {
                            editRssInlineMessage.visible = false
                            dataModel.set(editRssDrawer.index, rssEditTextField.text)
                            editRssDrawer.close()
                        }
                        else {
                            editRssInlineMessage.visible = true
                        }
                    }
                }
                Controls.Button {
                    Layout.alignment: Qt.AlignRight
                    text: qsTr("Close")
                    onClicked: {
                        editRssInlineMessage.visible = false
                        rssEditTextField.text = ""
                        editRssDrawer.close()
                    }
                }
            }
        }
        onOpened: {
            rssEditTextField.text = url
        }
    }

}


