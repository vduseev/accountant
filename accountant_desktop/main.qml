import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Window 2.0

ApplicationWindow {
    id: mainApplicationWindow
    visible: true

    /* Window is automatically resized to to maximized state.
       It feels more comfortable to use. */
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
                    //openNewTransactionViewTabToAddTransaction()
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
        var transactionTableTab =  addNewTab("TransactionTable.qml", qsTr("Transactions"))

        if (transactionTableTab !== null) {
            transactionTableTab.item.doubleClickedOnTransaction.connect(openNewTransactionViewTabToEditTransaction)
        }
    }

    function openNewTransactionViewTabToEditTransaction(model, modelIndex, transaction) {
        var transactionViewTab = addNewTab("TransactionView.qml", qsTr("Edit Transaction"))

        if (transactionViewTab !== null) {
            // Tab needs to be activated first, because it's a Loader.
            // Unless loader loads its content we can't address the methods inside the
            // content as we do in the next line.
            transactionViewTab.active = true
            transactionViewTab.item.setupView(model, modelIndex, transaction)
            // Switch to opened tab. Use last index since added tab is always the last.
            tabView.currentIndex = tabView.count - 1
        }
    }

    function openNewTransactionViewTabToAddTransaction(model) {
        var transactionViewTab = addNewTab("TransactionView.qml", qsTr("Add Transaction"))

        if (transactionViewTab !== null) {
            // Tab needs to be activated first, because it's a Loader.
            // Unless loader loads its content we can't address the methods inside the
            // content as we do in the next line.
            transactionViewTab.active = true
            // Switch to opened tab. Use last index since added tab is always the last.
            tabView.currentIndex = tabView.count - 1
        }
    }

    function addNewTab(componentSourceName, title) {
        var component = Qt.createComponent(componentSourceName)
        var tab = tabView.addTab(title, component)

        if (tab === null) {
            console.log("Error creating " + componentSourceName + " component")
        }

        return tab
    }
}
