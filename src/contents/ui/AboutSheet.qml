/**
 * Copyright (c) 2020 Hnuda Dzmitry. All rights reserved. This software is
 * distributed under GNU GPL v3 licence For feedbacks and questions please feel
 * free to contact me at siriusbeta100@gmail.com
**/

import QtQuick 2.1
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.4 as Kirigami
import QtQuick.Controls 2.0 as Controls

Kirigami.OverlaySheet {
    id: sheet

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
                       "Copyright (c) 2019 Sirius Beta")
        }
        Controls.Label {
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
            text: qsTr("This application was created within the framework of the ITI BSUIR Computer Network course project. It is an example of a program demonstrating the work of Qt/QML and Kirigami technologies")
        }
    }
}
