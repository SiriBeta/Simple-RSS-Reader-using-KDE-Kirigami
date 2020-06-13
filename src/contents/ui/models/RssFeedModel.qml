/**
 * Copyright (c) 2020 Hnuda Dzmitry. All rights reserved. This software is
 * distributed under GNU GPL v3 licence For feedbacks and questions please feel
 * free to contact me at siriusbeta100@gmail.com
**/

import QtQuick 2.4
import QtQuick.XmlListModel 2.12

XmlListModel {
    query: "/rss/channel/item"
    XmlRole { name: "title"; query: "title/string()" }
    XmlRole { name: "description"; query: "fn:replace(description/string(),'\&lt;a href=.*\/a\&gt;', '')" }
    XmlRole { name: "link"; query: "link/string()" }
    XmlRole { name: "pubDate"; query: "pubDate/string()" }
}
