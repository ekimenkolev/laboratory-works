import QtQuick 2.0
import Sailfish.Silica 1.0



Page {
    id: options

    Label {
        x:  20
        y: 300
        width: parent.width
        text: "Количество раундов: " + rounds
        font.pixelSize: Theme.fontSizeExtraLarge
        }
    Button {
        id: input
        y: 600
        x: Theme.horizontalPageMargin
        width: parent.width - 2*x
        text: qsTr("OK")
        onClicked: {
                rounds = tf1.text
       }
    }

        TextField{
            id:tf1
            y: 500
             width: parent.width - 2*x
             placeholderText: ;
        }
        Button {
            text: qsTr("Играть")
            y: 700
            x: Theme.horizontalPageMargin
            width: parent.width - 2*x
            onClicked: pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
        }
        Button {
            x: Theme.horizontalPageMargin
            y:900
            text: qsTr("Выход")
            width: parent.width - 2*x
            color: Theme.secondaryHighlightColor
            onClicked: Qt.quit();
        }
}
