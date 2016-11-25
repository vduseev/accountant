import QtQuick 2.0
import QtQuick.Controls 1.4

TableView {
    id: root

    selectionMode: SelectionMode.ExtendedSelection

    TableViewColumn { role: "date"; title: "Date" }
    TableViewColumn { role: "from_account"; title: "From" }
    TableViewColumn { role: "to_account"; title: "To" }
    TableViewColumn { role: "description"; title: "Description" }
    TableViewColumn { role: "amount"; title: "Amount" }

//    itemDelegate: Component {
//        Loader {
//            property var modelValue: styleData.value
//            sourceComponent: cellComponents[styleData.column]
//        }
//    }

//    itemDelegate: Item {
//        Text {
//            anchors { left: parent.left; leftMargin: 5; verticalCenter: parent.verticalCenter; right: parent.right }
//            maximumLineCount: 1
//            text: styleData.value
//            elide: Text.ElideRight
//            //visible: styleData.column !== 3
//        }/*

//        TextField {
//            text: styleData.value
//            visible: styleData.column === 3
//        }*/
//    }
}
