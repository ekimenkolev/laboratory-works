import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    property var textfield
    allowedOrientations: Orientation.All

    SilicaFlickable {
        anchors.fill: parent
        PullDownMenu {
            MenuItem {
                text: qsTr("Выбор валюты")
                onClicked: pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
            }
        }

        contentHeight: column.height

        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("Конвертер валют")
            }
            Label {
                x: 0
                text: valuta
                color: "#ffffff"
                font.pixelSize: Theme.fontSizeExtraLarge
            }
            TextField{
                id: t2
                x: 0
                color: "#ffffff"
                text: " "
                onClicked: {
                     textfield = t2
                }
            }
            Label {
                x: 0
                text: qsTr("Рубли")
                color: "#ffffff"
                font.pixelSize: Theme.fontSizeExtraLarge
            }
           TextField{
                id: t1
                x: 0
                color: "#ffffff"
                text: " "
                onClicked: {
                    textfield = t1
                }
           }

           Button{
               x: 0
               text: qsTr("Перевод")
               color: "#ffffff"
               onClicked: {
                   if (textfield === t1) {
                       t2.text = ((t1.text * 1.0) / (kyrs * 1.0)).toFixed(4)
                   }
                   if (textfield === t2) {
                       t1.text = ((t2.text * 1.0) * (kyrs * 1.0)).toFixed(4)
                   }
               }
           }
        }
    }
}

