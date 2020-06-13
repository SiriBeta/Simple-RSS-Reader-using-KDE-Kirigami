import QtQuick 2.1
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.4 as Kirigami

Kirigami.Page {
    id: root

    property int depth: 0

    title: "Page " + depth
    objectName: "settingsPage"
        ColumnLayout {
            width: root.width
            spacing: Units.smallSpacing
            anchors.fill: parent
            Controls.Button {
                anchors.centerIn: parent
                text: "Remove Page"
                onClicked: pageStack.pop();
            }
            Controls.Button {
                anchors.centerIn: parent
                text: "Add Page"
                onClicked: pageStack.push(Qt.resolvedUrl("TestPage.qml"), {"depth": root.depth + 1});
            }
        }
    }
