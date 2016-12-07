import QtQuick 2.7
import QtQuick.Controls 1.4 as DesktopControls
import QtQuick.Controls 2.0 as MobileControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
import QtQml 2.2

DesktopControls.ApplicationWindow {
    id: root
    visible: true
    width: 1000//Screen.desktopAvailableWidth
    height: 600//Screen.desktopAvailableHeight

    title: qsTr("The Accountant")

    menuBar: DesktopControls.MenuBar {
        DesktopControls.Menu {
            title: qsTr("Transaction")
            DesktopControls.MenuItem {
                text: qsTr("Create new transaction...")
                onTriggered: {
                    popup.openToCreateNewTransaction()
                }
            }
            DesktopControls.MenuItem {
                text: qsTr("Edit transaction...")
                onTriggered: {
                    var row = 0//transactionTable.currentRow
                    if (row > -1) {
                        var transaction = transactionListModel.get(row)
                        popup.openToEditExistingTransaction(transaction, row)
                    }
                }
            }
        }
        DesktopControls.Menu {
            title: qsTr("Account")
        }
    }

    DesktopControls.TabView {
        id: tabView
        anchors.fill: parent

        DesktopControls.Tab {
            id: transactionsTab
            title: qsTr("Transactions")
            TransactionTable {
                id: transactionTable
                //anchors.fill: parent
                model: transactionListModel

                onDoubleClicked: {
                    var transaction = transactionListModel.get(row)
                    popup.openToEditExistingTransaction(transaction, row)
                }

                Component.onCompleted: lazyDataLoader.sendMessage('load these damn items')

                WorkerScript {
                    id: lazyDataLoader
                    source: "lazyLoader.js"

                    onMessage: {
                        var listModelItem = messageObject
                        listModelItem.date = messageObject.date.toLocaleString(Locale.ShortFormat)
                        transactionListModel.append(listModelItem)
                        transactionTable.resizeColumnsToContents()
                    }
                }
            }
        }

        DesktopControls.Tab {
            id: accountsTab
            title: qsTr("Accounts")
            Item {
                id: accountTable
            }
        }
    }

    PopupView {
        id: popup

        x: root.width / 2 - width / 2
        y: root.height / 2 - height / 2

        onSubmitTransaction: {
            if (modelIndex === -1) {
                transactionListModel.addTransaction(transaction)
            }
            else {
                transactionListModel.updateTransaction(transaction, modelIndex)
            }
            popup.popStack()
        }

        onCancelTransaction: {
            popup.popStack()
        }

        onSubmitAccount: {

        }

        onCancelAccount: {
            popup.popStack()
        }
    }

    ListModel {
        id: transactionListModel

        function updateTransaction(transaction, modelIndex) {
            transactionListModel.set(modelIndex, transaction)
        }

        function addTransaction(transaction) {
            transactionListModel.append(transaction)
        }
    }
}
