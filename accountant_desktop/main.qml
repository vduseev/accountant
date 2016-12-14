import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Window 2.0

ApplicationWindow {
    id: mainApplicationWindow
    visible: true

    /* Window is automatically resized to to maximized state.
       It feels more comfortable to use. */
    //width: Screen.desktopAvailableWidth
    //height: Screen.desktopAvailableHeight

    title: qsTr("The Accountant")

    Component.onCompleted: {
        tabView.openNewTransactionTableTab()
        showMaximized()
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("Transaction")

            MenuItem {
                text: qsTr("Create new transaction...")
                onTriggered: {
                    var currentTab = tabView.getTab(tabView.currentIndex)
                    var model = currentTab.item.model
                    tabView.openNewTransactionViewTabToAddTransaction(model)
                }
                Component.onCompleted: { enabled = Qt.binding(tabView.isCurrentTabTransactionTable) }
            }

            MenuItem {
                text: qsTr("Edit transaction...")
                onTriggered: {
                    var currentTab = tabView.getTab(tabView.currentIndex)
                    var model = currentTab.item.model
                    var row = currentTab.item.currentRow
                    tabView.openNewTransactionViewTabToEditTransaction(row, model)
                }
                Component.onCompleted: { enabled = Qt.binding(tabView.isTransactionSelected) }
            }
        }

        Menu {
            title: qsTr("Account")
        }
    }

    MyTabView {
        id: tabView
        anchors.fill: parent
    }
}
