import QtQuick 2.6
import QtQuick.Controls 1.4

TabView {
    id: tabView

    function openTransactionTable() {
        var transactionTableTab =  __openTab("TransactionTable.qml", qsTr("Transactions"))

        if (transactionTableTab !== null) {
            transactionTableTab.item.rowDoubleClicked.connect(openEditTransactionView)
        }
    }

    function openAccountTable() {
        var accountTableTab =  __openTab("AccountTable.qml", qsTr("Accounts"))

        if (accountTableTab !== null) {
            accountTableTab.item.rowDoubleClicked.connect(openEditAccountView)
        }
    }

    function openEditTransactionView(modelIndex, model) {
        __openElementView(modelIndex, model, "TransactionView.qml", qsTr("Edit Transaction"))
    }

    function openAddTransactionView(model) {
        __openElementView(-1, model, "TransactionView.qml", qsTr("Add Transaction"))
    }

    function openEditAccountView(modelIndex, model) {
        __openElementView(modelIndex, model, "AccountView.qml", qsTr("Edit Account"))
    }

    function openAddAccountView(model) {
        __openElementView(-1, model, "AccountView.qml", qsTr("Add Account"))
    }

    function getCurrentTabItem() {
        var currentItem = tabView.getTab(tabView.currentIndex).item
        return currentItem
    }

    function __openElementView(modelIndex, model, componentSourceName, title) {
        var currentTable = getCurrentTabItem()
        var tab = __openTab(componentSourceName, title)

        if (tab !== null) {
            // Tab needs to be activated first, because it's a Loader.
            // Unless loader loads its content we can't address the methods inside the
            // content as we do in the next line.
            tab.active = true
            tab.item.setupView(modelIndex, model)
            // Switch to opened tab. Use last index since added tab is always the last.
            tabView.currentIndex = tabView.count - 1

            tab.item.submit.connect(__closeCurrentTab)
            tab.item.cancel.connect(__closeCurrentTab)
            tab.item.submit.connect(currentTable.resizeColumnsToContents)
        }
    }

    function __openTab(componentSourceName, title) {
        var component = Qt.createComponent(componentSourceName)
        var tab = tabView.addTab(title, component)

        if (tab !== null) {
            tab.active = true
            tabView.currentIndex = tabView.count - 1
        } else {
            console.log("Error creating " + componentSourceName + " component")
        }

        return tab
    }

    function __closeCurrentTab() {
        var currentIndex = tabView.currentIndex
        tabView.removeTab(currentIndex)
    }
}
