import QtQuick 2.7

ListModel {
    id: workspaceTableModel

    property string workerScriptSource: ""

    function upsert(modelIndex, element) {
        if (modelIndex === -1) {
            addElement(element)
        } else {
            updateElement(modelIndex, element)
        }
    }

    function addElement(element) {
        append(element)
        // Handle API integration here
    }

    function updateElement(modelIndex, element) {
        set(modelIndex, element)
        // Handle API integration here
    }

    function deleteElement(modelIndex) {
        remove(modelIndex, 1)
    }

    Component.onCompleted: {
        lazyDataLoader.sendMessage('load data')
    }

    property WorkerScript lazyDataLoader: WorkerScript {
        source: workerScriptSource
        onMessage: {
            if (messageObject.messageType === "data") {
                // workerScriptMessage(messageObject.data)
                append(messageObject.data)
            } else if (messageObject.messageType === "finished") {
                // add enough empty rows
//                var viewHeight = tableView.height
//                var bufferRowsCount = (viewHeight / rowHeight) - 4
//                for (var i = 0; i < bufferRowsCount; i++) {
//                    var bufferElement = {}
//                    for (var j = 0; j < columnCount; j++) {
//                        var columnRole = getColumn(j).role
//                        bufferElement[columnRole] = ""
//                    }

//                    __addElement(bufferElement)
//                }
            }
        }
    }
}
