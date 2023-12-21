import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    SilicaListView {
        id: listView
        model: exchangeratesModel
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Валюты")
        }
        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.horizontalPageMargin
                text: valute + "\n" + exchangerates
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: {
              kyrs = exchangerates.replace(",",".")
                valuta = valute
                pageStack.push(Qt.resolvedUrl("FirstPage.qml"))
        }
        VerticalScrollDecorator {}
        }
    }
}
