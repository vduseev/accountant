import QtQuick 2.0
import QtQuick.Controls 1.4

TableView {
    id: root

    TableViewColumn { role: "date"; title: "Date" }
    TableViewColumn { role: "from_account"; title: "From" }
    TableViewColumn { role: "to_account"; title: "To" }
    TableViewColumn { role: "description"; title: "Description" }
    TableViewColumn { role: "amount"; title: "Amount" }
}
