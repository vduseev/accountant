import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQml 2.2

WorkspaceTable {
    id: transactionTable

    readonly property string viewType: "transactionTable"

    // date & time
    TableViewColumn { role: "payment_date";     title: "Payment Date" }

    // accounts (source, destination)
    TableViewColumn { role: "from_account";     title: "From" }
    TableViewColumn { role: "to_account";       title: "To" }

    TableViewColumn { role: "payment_amount";   title: "Payment Amount" }
    TableViewColumn { role: "payment_currency"; title: "Cur" }

    // description
    TableViewColumn { role: "description";      title: "Description" }

    TableViewColumn { role: "processing_amount";title: "Processing Amount" }
    TableViewColumn { role: "processing_date";  title: "Processing Date" }

    workerScriptSource: "lazyTransactionLoader.js"
}
