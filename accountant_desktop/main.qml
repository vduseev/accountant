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
                    var currentTab = tabView.getTab(tabView.currentIndex)
                    var model = currentTab.item.model
                    openNewTransactionViewTabToAddTransaction(model)
                }
                Component.onCompleted: { enabled = Qt.binding(isCurrentTabTransactionTable) }
            }

            MenuItem {
                text: qsTr("Edit transaction...")
                onTriggered: {
                    var currentTab = tabView.getTab(tabView.currentIndex)
                    var model = currentTab.item.model
                    var row = currentTab.item.currentRow
                    openNewTransactionViewTabToEditTransaction(model, row)
                }
                Component.onCompleted: { enabled = Qt.binding(isTransactionSelected) }
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
        var transactionViewTab = addNewTab("TransactionView.qml", qsTr("Edit Transaction"), "transactionView")

        if (transactionViewTab !== null) {
            // Tab needs to be activated first, because it's a Loader.
            // Unless loader loads its content we can't address the methods inside the
            // content as we do in the next line.
            transactionViewTab.active = true
            transactionViewTab.item.setupView(model, modelIndex)
            // Switch to opened tab. Use last index since added tab is always the last.
            tabView.currentIndex = tabView.count - 1

            transactionViewTab.item.submit.connect(closeCurrentTab)
            transactionViewTab.item.cancel.connect(closeCurrentTab)
        }
    }

    function openNewTransactionViewTabToAddTransaction(model) {
        var transactionViewTab = addNewTab("TransactionView.qml", qsTr("Add Transaction"), "transactionView")

        if (transactionViewTab !== null) {
            // Tab needs to be activated first, because it's a Loader.
            // Unless loader loads its content we can't address the methods inside the
            // content as we do in the next line.
            transactionViewTab.active = true
            transactionViewTab.item.setupView(model)
            // Switch to opened tab. Use last index since added tab is always the last.
            tabView.currentIndex = tabView.count - 1

            transactionViewTab.item.submit.connect(closeCurrentTab)
            transactionViewTab.item.cancel.connect(closeCurrentTab)
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
