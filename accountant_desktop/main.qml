import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Window 2.0

ApplicationWindow {
    id: mainApplicationWindow
    visible: true
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight

    title: qsTr("The Accountant")

    Component.onCompleted: {
        openNewTransactionTableTab()
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("Transaction")

            MenuItem {
                text: qsTr("Create new transaction...")
                onTriggered: {
                    //popup.openToCreateNewTransaction()
                }
            }

            MenuItem {
                text: qsTr("Edit transaction...")
                onTriggered: {
                    var row = 0//transactionTable.currentRow
                    if (row > -1) {
                        var transaction = transactionListModel.get(row)
                        //popup.openToEditExistingTransaction(transaction, row)
                    }
                }
            }
        }

        Menu {
            title: qsTr("Account")
        }
    }

    TabView {
        id: tabView
        anchors.fill: parent
    }

    function openNewTransactionTableTab() {
        var transactionTableComponent = Qt.createComponent("TransactionTable.qml")
        var transactionTableTab = tabView.addTab(qsTr("Transactions"), transactionTableComponent)

        if (transactionTableTab == null) {
            console.log("Error creating TransactionTable component")
        } else {
            transactionTableTab.item.doubleClickedOnTransaction.connect(openNewTransactionViewTabToEdit)
        }
    }

    function fun(modelIndex, transaction) {
        console.log("Clicked: " + modelIndex)
    }

    function openNewTransactionViewTabToEdit(model, modelIndex, transaction) {
        var transactionViewComponent = Qt.createComponent("TransactionView.qml")
        var transactionViewTab = tabView.addTab(qsTr("Edit Transaction"), transactionViewComponent)

        if (transactionViewTab === null) {
            console.log("Error creating transactionView component")
        } else {
            transactionViewTab.active = true
            transactionViewTab.item.setupView(model, modelIndex, transaction)
            //transactionViewTab.item.modelIndex = 1
            //transactionViewTab.item.submit.connect(fun)
        }
    }
}
