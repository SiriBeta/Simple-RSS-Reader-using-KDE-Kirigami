/**
 * Copyright (c) 2020 Hnuda Dzmitry. All rights reserved. This software is
 * distributed under GNU GPL v3 licence For feedbacks and questions please feel
 * free to contact me at siriusbeta100@gmail.com
**/

import QtQuick 2.1
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0 as Controls
import org.kde.kirigami 2.11 as Kirigami

Kirigami.ApplicationWindow {
    id: root

    title: i18n("RSS Reader")

    globalDrawer: Kirigami.GlobalDrawer {
        title: i18n("RSS Reader")
        titleIcon: "akregator"
        bannerImageSource: "banner.jpg"

        actions: [
            Kirigami.Action {
                text: i18n(qsTr("Home"))
                iconName: "go-home"
                onTriggered: {
                    pageStack.clear();
                    pageStack.push(mainPageComponent)
                }
            }
        ]
    }

    contextDrawer: Kirigami.ContextDrawer {
        id: contextDrawer
    }

    AboutSheet {
        id: sheet;
    }

    pageStack.initialPage: mainPageComponent

    Component {
        id: mainPageComponent
        MainPage {}
    }
}
