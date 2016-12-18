import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Window 2.0

ApplicationWindow {
    id: mainApplicationWindow
    visible: true

    width: Screen.desktopAvailableWidth / 2
    height: Screen.desktopAvailableHeight / 2

    title: qsTr("The Accountant")

    Component.onCompleted: {
        workspace.openAccountTable()
        workspace.openTransactionTable()

        // Window is automatically resized to to maximized state.
        // It feels more comfortable to use.
        // showMaximized()
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("Transactions")

            MenuItem {
                text: qsTr("Create new transaction...")
                onTriggered: {
                    var currentTab = workspace.getTab(workspace.currentIndex)
                    var model = currentTab.item.model
                    workspace.openAddTransactionView(model)
                }
                Component.onCompleted: { enabled = Qt.binding( function() {
                    return workspace.getCurrentTabItem().viewType === "transactionTable"
                } ) }
            }

            MenuItem {
                text: qsTr("Edit transaction...")
                onTriggered: {
                    var currentTab = workspace.getTab(workspace.currentIndex)
                    var model = currentTab.item.model
                    var row = currentTab.item.currentRow
                    workspace.openEditTransactionView(row, model)
                }
                Component.onCompleted: { enabled = Qt.binding( function() {
                    var item = workspace.getCurrentTabItem()
                    if (item.viewType === "transactionTable")
                        if (item.currentRow > -1)
                            return true
                    return false
                } ) }
            }

            MenuSeparator { }

            MenuItem {
                text: qsTr("Open transactions table...")
                onTriggered: {
                    workspace.openTransactionTable()
                }
            }
        }

        Menu {
            title: qsTr("Accounts")

            MenuItem {
                text: qsTr("Create new account...")
                onTriggered: {
                    var currentTab = workspace.getTab(workspace.currentIndex)
                    var model = currentTab.item.model
                    workspace.openAddAccountView(model)
                }
                Component.onCompleted: { enabled = Qt.binding( function() {
                    return workspace.getCurrentTabItem().viewType === "accountTable"
                } ) }
            }

            MenuItem {
                text: qsTr("Edit account...")
                onTriggered: {
                    var currentTab = workspace.getTab(workspace.currentIndex)
                    var model = currentTab.item.model
                    var row = currentTab.item.currentRow
                    workspace.openEditAccountView(row, model)
                }
                Component.onCompleted: {
                    enabled = Qt.binding( function() {
                        var item = workspace.getCurrentTabItem()
                        if (item.viewType === "accountTable")
                            if (item.currentRow > -1)
                                return true
                        return false
                    } )
                }
            }

            MenuSeparator { }

            MenuItem {
                text: qsTr("Open account table...")
                onTriggered: {
                    workspace.openAccountTable()
                }
            }
        }
    }

    WorkspaceTableView {
        id: workspace
        anchors.fill: parent
    }
}
