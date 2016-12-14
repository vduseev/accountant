import QtQuick 2.0
import QtQuick.Controls 1.4 as OldControls
import QtQuick.Controls 2.0
import QtQml 2.2
import QtQuick.Layouts 1.1

Rectangle {
    id: workspaceView

    readonly property string viewType: "abstractView"
    property var fields: []

    // model is set when TransactionView is instantiated from
    // TransactionTable, so it is shared between TransactionTable
    // and TransactionView.
    // If TransactionTable will be closed model will be preserved.
    property ListModel model

    // modelIndex is set when TransactionView is instantiated.
    // It is used when submit signal is emitted as parameter to signal.
    // Also it is used in __updateModelWithTransaction function as part
    // of the logic to determine whether we add a new item to the model
    // or update an existing one.
    property int modelIndex: -1
    property int textFieldHeight: 50

    signal submit(int modelIndex, var transaction)
    signal cancel()

    function setupView(modelIndex, model) {
        workspaceView.model = model
        if (modelIndex !== -1) {
            var element = model.get(modelIndex)
            workspaceView.modelIndex = modelIndex
            workspaceView.__setFieldsUsingExistingElement(element)
        }
    }

    function clearView() {
        workspaceView.__cleanUpFields()
        workspaceView.modelIndex = -1
    }

    color: "white"
    width: 640
    height: 440

    function __submit() {
        var element = __getElementFromFields()
        __updateModelWithElement(element)
        submit(modelIndex, element)
    }

    function __cancel() {
        cancel()
    }

    function __updateModelWithElement(element) {
        if (modelIndex == -1) {
            workspaceView.model.append(element)
        } else {
            workspaceView.model.set(modelIndex, element)
        }
    }

    function __setFieldsUsingExistingElement(element) {
        for (var i = 0; i < fields.length; i++) {
            var field = fields[i]
            for (var j = 0; j < field.roles.length; j++) {
                var role = field.roles[j]
                field.setRoleValue(role, element[role])
            }
        }
    }

    function __cleanUpFields() {
        for (var i = 0; i < fields.length; i++) {
            var field = fields[i]
            field.clear()
        }
    }

    function __getElementFromFields() {
        var element = {}
        for (var i = 0; i < fields.length; i++) {
            var field = fields[i]
            for (var j = 0; j < field.roles.length; j++) {
                var role = field.roles[j]
                element[role] = field.getRoleValue(role)
            }
        }
        return element
    }
}
