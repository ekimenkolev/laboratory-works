import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    property int chel: 0
    property int computer: 0
    property int chelovek: 0
    property int computerc: 0
    property int gamerounds : rounds

    Label {
        id: score
        x: 20
        y: 100
        width: parent.width
        text: ""
        font.pixelSize: Theme.fontSizeExtraLarge
    }
    Label {
        id: round
        x: parent.width /2
        y: 100
        width: parent.width
        text: gamerounds
        font.pixelSize: Theme.fontSizeExtraLarge
    }

    Label {
        id: computerWins
        x:  parent.width - 160
        y: 100
        width: parent.width
        text: computerc
        font.pixelSize: Theme.fontSizeExtraLarge
    }

    Label {
        id: humanWins
        x: 100
        y: 100
        width: parent.width
        text: chelovek
        font.pixelSize: Theme.fontSizeExtraLarge
    }

    Button {
        id: kamen
        text: qsTr("Камень")
        y: 500
        x: Theme.horizontalPageMargin
        width: parent.width - 2*x
        onClicked: {
            chel = 0
            gameplay()
            }
    }

    Button {
        id: noznitsi
        text: qsTr("Ножницы")
        y: 600
        x: Theme.horizontalPageMargin
        width: parent.width - 2*x
        onClicked: {
            chel = 1
            gameplay()
        }
    }

    Button {
        id: bumaga
        text: qsTr("Бумага")
        y: 700
        x: Theme.horizontalPageMargin
        width: parent.width - 2*x
        onClicked: {
            chel = 2
            gameplay()
            }
    }
    Label {
        id: humanСhoice
        x: 20
        y: 200
        text: ""
        color: Theme.secondaryColor
        font.pixelSize: Theme.fontSizeExtraLarge
    }


    Label {
        id: computerСhoice
        x: 20
        y: 300
        text: ""
        color: Theme.secondaryColor
        font.pixelSize: Theme.fontSizeExtraLarge
    }


    Label {
        id: roundWin
        x: 20
        y: 400
        text: ""
        color: Theme.secondaryColor
        font.pixelSize: Theme.fontSizeExtraLarge
    }


    Button {
        text: qsTr("Новая игра")
        y: 900
        x: Theme.horizontalPageMargin
        width: parent.width - 2*x
        onClicked: newGame()
    }

    Button {
        text: qsTr("Выбрать кол-во раундов")
        y: 1000
        x: Theme.horizontalPageMargin
        width: parent.width - 2*x
        onClicked: pageStack.push(Qt.resolvedUrl("FirstPage.qml"))
    }
    Button {
        x: Theme.horizontalPageMargin
        y: 1100
        text: qsTr("Выход")
        width: parent.width - 2*x
        color: Theme.secondaryHighlightColor
        onClicked: Qt.quit();
    }
    function afalse()
    {
        humanWins.visible = false
        computerWins.visible = false
        round.visible = false
        humanСhoice.visible = false
        computerСhoice.visible = false
        roundWin.visible = false
        noznitsi.visible = false
        bumaga.visible = false
        kamen.visible = false
    }
    function atrue()
    {
        humanWins.visible = true
        computerWins.visible = true
        round.visible = true
        humanСhoice.visible = true
        computerСhoice.visible = true
        roundWin.visible = true
        noznitsi.visible = true
        bumaga.visible = true
        kamen.visible = true
    }

        function gameplay() {

            if (gamerounds != 0){

                computer = Math.floor(Math.random() * 3)
                showChoice()

                if (chel === computer){
                    roundWin.text = "Ничья"
                }
                else if ((chel === 0 ? 3 : chel) - computer === 1) {
                    computerc++
                    roundWin.text = "Победитель: Компьютер"
                }
                else if ((computer === 0 ? 3 : computer) - chel === 1) {
                    roundWin.text = "Победитель: Вы"
                    chelovek++
                }
                if(chel != computer)
                gamerounds--
                if(chelovek > (rounds/2) ||computerc > (rounds/2) || gamerounds === 0)
                {
                    result()
                    afalse()
                }
            }
        }



        function result()
        {
                if (chelovek > computerc)
                    score.text = "Вы победили \ncо счётом: " + chelovek + " : " + computerc
                if (chelovek < computerc)
                    score.text = "Вы проиграли \nсо счётом: " + chelovek + " : " + computerc
                if (chelovek === computerc)
                    score.text = "Ничья. Счёт: " + chelovek + " : " + computerc
        }

        function newGame(){
            atrue()

            gamerounds = rounds
            chelovek = 0
            computerc = 0
            score.text = ""
            humanСhoice.text = ""
            computerСhoice.text =""
            roundWin.text = ""
        }
        function showChoice(){
            if (chel == 0) humanСhoice.text = "Вы: Камень"
            if (chel == 1) humanСhoice.text = "Вы: Ножницы"
            if (chel == 2) humanСhoice.text = "Вы: Бумага"

            if (computer == 0) computerСhoice.text = "Компьютер: Камень"
            if (computer == 1) computerСhoice.text = "Компьютер: Ножницы"
            if (computer == 2) computerСhoice.text = "Компьютер: Бумага"
        }

}
