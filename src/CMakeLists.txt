#################
 ## Copyright (c) 2020 Hnuda Dzmitry. All rights reserved. This software is
 ## distributed under GNU GPL v3 licence For feedbacks and questions please feel
 ## free to contact me at siriusbeta100@gmail.com
#################

qt5_add_resources(rss_reader_SRCS resources.qrc)
include_directories("./include")
add_executable(rss_reader main.cpp include/urlrssmodel.h include/urlrssmodel.cpp include/appsettings.h include/appsettings.cpp ${rss_reader_SRCS})
target_link_libraries(rss_reader Qt5::Core Qt5::Gui Qt5::Qml Qt5::Quick Qt5::Svg Qt5::Xml KF5::I18n)
install(TARGETS rss_reader ${KF5_INSTALL_TARGETS_DEFAULT_ARGS})
