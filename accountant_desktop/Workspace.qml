import QtQuick 2.6
import QtQuick.Controls 1.4

TabView {
    id: tabView

    function getCurrentTabItem() {
        var currentItem = tabView.getTab(tabView.currentIndex).item
        return currentItem
    }

    function openTransactionTable() {
        var transactionTableTab =  __openTab("TransactionTable.qml", qsTr("Transactions"))

        if (transactionTableTab !== null) {
            transactionTableTab.item.rowDoubleClicked.connect(openEditTransactionView)
        }
    }

    function openEditTransactionView(modelIndex, model) {
        __openTransactionView(modelIndex, model, qsTr("Edit Transaction"))
    }

    function openAddTransactionView(model) {
        __openTransactionView(-1, model, qsTr("Add Transaction"))
    }

    function __openTransactionView(modelIndex, model, title) {
        var currentTransactionTable = getCurrentTabItem()
        var transactionViewTab = __openTab("TransactionView.qml", title)

        if (transactionViewTab !== null) {
            // Tab needs to be activated first, because it's a Loader.
            // Unless loader loads its content we can't address the methods inside the
            // content as we do in the next line.
            transactionViewTab.active = true
            transactionViewTab.item.setupView(modelIndex, model)
            // Switch to opened tab. Use last index since added tab is always the last.
            tabView.currentIndex = tabView.count - 1

            transactionViewTab.item.submit.connect(__closeCurrentTab)
            transactionViewTab.item.cancel.connect(__closeCurrentTab)
            transactionViewTab.item.submit.connect(currentTransactionTable.resizeColumnsToContents)
        }
    }

    function __openTab(componentSourceName, title) {
        var component = Qt.createComponent(componentSourceName)
        var tab = tabView.addTab(title, component)

        if (tab === null) {
            console.log("Error creating " + componentSourceName + " component")
        }

        return tab
    }

    function __closeCurrentTab() {
        var currentIndex = tabView.currentIndex
        tabView.removeTab(currentIndex)
    }
}
