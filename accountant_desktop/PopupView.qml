import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2
import QtQml 2.2

Window {
    id: root

    signal submitTransaction(var transaction, var modelIndex)
    signal cancelTransaction()
    signal submitAccount(var account, var modelIndex)
    signal cancelAccount()

    //modal: true
    //focus: true
    //closePolicy: Popup.CloseOnPressOutside | Popup.CloseOnEscape

    function popStack() {
        if (stackView.depth > 1) {
            stackView.pop()
        } else {
            root.close()
        }
    }

//    onClosing: {
//        stackView.clear()
//    }

    width: stackView.width
    height: stackView.height

    StackView {
        id: stackView

        width: currentItem === null ? 0 : currentItem.width
        height: currentItem === null ? 0 : currentItem.height

        //Behavior on width { PropertyAnimation { easing.type: Easing.InOutQuad } }
        //Behavior on height { PropertyAnimation { easing.type: Easing.InOutQuad } }

        Behavior on opacity { PropertyAnimation { easing.type: Easing.InOutQuad } }

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                //duration: 100
            }
        }

        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                //duration: 100
            }
        }

        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                //duration: 100
            }
        }

        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                //duration: 100
            }
        }
    }

    Component {
        id: transactionViewComponent

        TransactionView {
            id: transactionView

            onSubmit: submitTransaction(transaction, modelIndex)
            onCancel: cancelTransaction()
        }
    }

    function openToCreateNewTransaction() {
        stackView.push(transactionViewComponent)
        stackView.currentItem.clearTransactionView()
        root.show()
    }

    function openToEditExistingTransaction(transaction, modelIndex) {
        stackView.push(transactionViewComponent)
        stackView.currentItem.setupTransactionView(transaction, modelIndex)
        root.show()
    }

    Component {
        id: accountViewComponent

        AccountView {
            id: accountView

            onSubmit: submitAccount(account, modelIndex)
            onCancel: cancelAccount()
        }
    }

    function openToCreateNewAccount() {
        stackView.push(accountViewComponent)
        stackView.currentItem.clearView()
        root.open()
    }

    function openToEditExistingAccount(account, modelIndex) {
        stackView.push(accountViewComponent)
        stackView.currentItem.setupView(account, modelIndex)
        root.open()
    }
}
