/**
 * Copyright (c) 2020 Hnuda Dzmitry. All rights reserved. This software is
 * distributed under GNU GPL v3 licence For feedbacks and questions please feel
 * free to contact me at siriusbeta100@gmail.com
**/

import QtQuick 2.0
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.11 as Kirigami

Kirigami.Page {
    ColumnLayout {
        anchors.centerIn: parent
        Image {
            source: "network-disconnect"
        }
        Kirigami.Heading {
            text: qsTr("No internet connection, check it out")
            level: 2
        }
    }
}
