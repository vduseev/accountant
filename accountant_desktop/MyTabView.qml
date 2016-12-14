import QtQuick 2.6
import QtQuick.Controls 1.4

TabView {
    id: tabView

    function isCurrentTabTransactionTable() {
        var currentTabViewType = getCurrentTabViewType()
        if (currentTabViewType !== undefined) {
            return currentTabViewType === "transactionTable"
        }
        return false
    }

    function isTransactionSelected() {
        if (isCurrentTabTransactionTable()) {
            return getCurrentTabItem().currentRow > -1
        }
        return false;
    }

    function getCurrentTabItem() {
        var currentTab = tabView.getTab(tabView.currentIndex)
        if (currentTab !== undefined) {
            return currentTab.item
        }
        return undefined
    }

    function getCurrentTabViewType() {
        var currentItem = getCurrentTabItem()
        if (currentItem !== undefined) {
            return currentItem.viewType
        }
        return undefined
    }

    function openNewTransactionTableTab() {
        var transactionTableTab =  addNewTab("TransactionTable.qml", qsTr("Transactions"), "transactionTable")

        if (transactionTableTab !== null) {
            transactionTableTab.item.doubleClickedOnTransaction.connect(openNewTransactionViewTabToEditTransaction)
        }
    }

    function openNewTransactionViewTabToEditTransaction(modelIndex, model) {
        var currentTransactionTable = getCurrentTabItem()
        var transactionViewTab = addNewTab("TransactionView.qml", qsTr("Edit Transaction"), "transactionView")

        if (transactionViewTab !== null) {
            // Tab needs to be activated first, because it's a Loader.
            // Unless loader loads its content we can't address the methods inside the
            // content as we do in the next line.
            transactionViewTab.active = true
            transactionViewTab.item.setupView(modelIndex, model)
            // Switch to opened tab. Use last index since added tab is always the last.
            tabView.currentIndex = tabView.count - 1

            transactionViewTab.item.submit.connect(closeCurrentTab)
            transactionViewTab.item.cancel.connect(closeCurrentTab)
            transactionViewTab.item.submit.connect(currentTransactionTable.resizeColumnsToContents)
        }
    }

    function openNewTransactionViewTabToAddTransaction(model) {
        var currentTransactionTable = getCurrentTabItem()
        var transactionViewTab = addNewTab("TransactionView.qml", qsTr("Add Transaction"), "transactionView")

        if (transactionViewTab !== null) {
            // Tab needs to be activated first, because it's a Loader.
            // Unless loader loads its content we can't address the methods inside the
            // content as we do in the next line.
            transactionViewTab.active = true
            transactionViewTab.item.setupView(-1, model)
            // Switch to opened tab. Use last index since added tab is always the last.
            tabView.currentIndex = tabView.count - 1

            transactionViewTab.item.submit.connect(closeCurrentTab)
            transactionViewTab.item.cancel.connect(closeCurrentTab)
            transactionViewTab.item.submit.connect(currentTransactionTable.resizeColumnsToContents)
        }
    }

    function addNewTab(componentSourceName, title, tabType) {
        var component = Qt.createComponent(componentSourceName)
        var tab = tabView.addTab(title, component)

        if (tab === null) {
            console.log("Error creating " + componentSourceName + " component")
        }

        return tab
    }

    function closeCurrentTab() {
        var currentIndex = tabView.currentIndex
        tabView.removeTab(currentIndex)
    }
}
