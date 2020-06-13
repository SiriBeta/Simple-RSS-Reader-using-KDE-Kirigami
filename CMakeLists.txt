#################
 ## Copyright (c) 2020 Hnuda Dzmitry. All rights reserved. This software is
 ## distributed under GNU GPL v3 licence For feedbacks and questions please feel
 ## free to contact me at siriusbeta100@gmail.com
#################

project(rss_reader)

cmake_minimum_required(VERSION 3.0)

include(FeatureSummary)

################# set KDE specific information #################
find_package(ECM 0.0.8 REQUIRED NO_MODULE)

# where to look first for cmake modules, before ${CMAKE_ROOT}/Modules/ is checked
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)
include(ECMSetupVersion)
include(ECMGenerateHeaders)
include(ECMPoQmTools)

################# Find dependencies #################
#find_package(Qt5 REQUIRED COMPONENTS Core Gui Qml QuickControls2 Svg Xml)
#find_package(KF5Config)
#find_package(KF5Kirigami2)
#find_package(KF5I18n)
find_package(Qt5Core REQUIRED)
find_package(Qt5Gui REQUIRED)
find_package(Qt5Qml REQUIRED)
find_package(Qt5Quick REQUIRED)
find_package(Qt5Svg REQUIRED)
find_package(Qt5Xml REQUIRED)
find_package(KF5Config)
find_package(KF5Kirigami2)
find_package(KF5I18n)

foreach(c Core Sql Widgets Quick Multimedia Qml)
    if(${Qt5${c}_FOUND})
        message(STATUS "Qt5${c} found!")
    endif()
endforeach()

################# Enable C++11 features for clang and gcc #################
set(CMAKE_CXX_STANDARD 11)

################# build and install #################
add_subdirectory(src)

install(PROGRAMS org.kde.rss_reader.desktop DESTINATION ${KDE_INSTALL_APPDIR})
install(FILES org.kde.rss_reader.appdata.xml DESTINATION ${KDE_INSTALL_METAINFODIR})

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)
