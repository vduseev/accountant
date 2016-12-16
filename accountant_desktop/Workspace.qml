import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.0 as MobileControls

TabView {
    id: tabView

    function openTransactionTable() {
        var transactionTableTab =  __openTab("TransactionTable.qml", qsTr("Transactions"))

        if (transactionTableTab !== null) {
            transactionTableTab.item.editRow.connect(openEditTransactionView)
        }
    }

    function openAccountTable() {
        var accountTableTab =  __openTab("AccountTable.qml", qsTr("Accounts"))

        if (accountTableTab !== null) {
            accountTableTab.item.editRow.connect(openEditAccountView)
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

    function closeCurrentTab() {
        var currentIndex = tabView.currentIndex
        tabView.removeTab(currentIndex)
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

            tab.item.submit.connect(closeCurrentTab)
            tab.item.cancel.connect(closeCurrentTab)
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

    style: TabViewStyle {
        id: tabViewStyle
        tabsMovable: true
        frameOverlap: 1
        tab: Rectangle {
            SystemPalette {
                id: tabPalette
            }

            property int totalOverlap: tabViewStyle.tabOverlap * (control.count - 1)
            property real maxTabWidth: control.count > 0 ? (control.width + totalOverlap) / control.count : 0

            implicitWidth: Math.min(maxTabWidth, Math.max(50, tabTitle.width)  + closeButton.width /*+ tabHSpace*/ + 2 + 22)
            implicitHeight: Math.max(tabTitle.font.pixelSize /*+ tabVSpace*/ + 12, 0)

            radius: 2

            border {
                color: "#AAA"
                width: 1
            }

            gradient: Gradient {
                GradientStop { position: 0; color: styleData.selected ? tabPalette.light : tabPalette.midlight }
                GradientStop { position: 1; color: styleData.selected ? tabPalette.midlight : tabPalette.mid }
            }

            Text {
                id: tabTitle
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 12
                }
                text: styleData.title
            }

            MobileControls.Button {
                id: closeButton
                width: parent.height * 0.6
                height: parent.height * 0.6
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: tabTitle.right
                    leftMargin: 4
                }
                flat: true
                text: "x"

                onClicked: {
                    closeCurrentTab()
                }
            }
        }
    }
}
