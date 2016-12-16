import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: root

    property var roles: []

    property alias labelText: label.text
    property alias labelFontPixelSize: label.font.pixelSize
    property alias amountPlaceholderText: amountTextField.placeholderText
    property alias amount: amountTextField.text
    property alias currencyPlaceholderText: currencyTextField.placeholderText
    property alias currency: currencyTextField.text

    function getRoleValue(role) {
        if (role.indexOf("amount") > -1) {
            return amount
        } else if (role.indexOf("currency") > -1) {
            return currency
        }
    }

    function setRoleValue(role, value) {
        if (role.indexOf("amount") > -1) {
            amount = value
        } else if (role.indexOf("currency") > -1) {
            currency = value
        }
    }

    function clear() {
        amount = ""
        currency = ""
    }

    Text {
        id: label
        anchors {
            left: parent.left
            top: parent.top
        }
    }

    TextField {
        id: amountTextField
        horizontalAlignment: TextInput.AlignRight
        //validator: DoubleValidator { decimals: 2; notation: DoubleValidator.StandardNotation }
        anchors {
            left: label.left
            top: label.bottom
            topMargin: 5
            right: currencyTextField.left
            bottom: parent.bottom
        }
    }

    TextField {
        id: currencyTextField
        width: 60
        //inputMask: ">AAA"
        anchors {
            top: label.bottom
            topMargin: 5
            right: parent.right
            bottom: parent.bottom
        }
    }
}
