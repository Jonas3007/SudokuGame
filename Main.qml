import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

Window {
    id: root

    width: 900
    height: 720
    minimumWidth: 620
    minimumHeight: 600
    visible: true
    title: qsTr("Sudoku")
    color: "#f4f7fb"

    property int selectedCell: -1
    property string statusText: qsTr("Trage deine Zahlen ein und löse das Sudoku.")
    signal clearBoardRequested()

    function selectNumber(number) {
        if (selectedCell < 0)
            return

        var cell = boardRepeater.itemAt(selectedCell)
        if (cell)
            cell.setValue(number.toString())
    }

    function clearSelectedCell() {
        if (selectedCell < 0)
            return

        var cell = boardRepeater.itemAt(selectedCell)
        if (cell)
            cell.setValue("")
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 32
        spacing: 24

        RowLayout {
            Layout.fillWidth: true
            spacing: 14

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 3

                Label {
                    text: qsTr("SUDOKU")
                    color: "#637083"
                    font.pixelSize: 13
                    font.weight: Font.Bold
                    font.letterSpacing: 2
                }

                Label {
                    text: qsTr("Finde die fehlenden Zahlen")
                    color: "#182333"
                    font.pixelSize: 28
                    font.weight: Font.DemiBold
                }
            }

            Button {
                text: qsTr("Neues Spiel")
                Layout.preferredHeight: 42
                leftPadding: 18
                rightPadding: 18
                onClicked: {
                    root.clearBoardRequested()
                    root.selectedCell = -1
                    root.statusText = qsTr("Ein neues leeres Sudoku wurde gestartet.")
                }
                background: Rectangle {
                    radius: 10
                    color: parent.down ? "#dbeafe" : "#e5eefb"
                    border.color: "#c6d9f2"
                }
                contentItem: Text {
                    text: parent.text
                    color: "#2361a8"
                    font.pixelSize: 14
                    font.weight: Font.DemiBold
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 28

            Rectangle {
                id: boardFrame
                Layout.preferredWidth: Math.min(560, root.height - 190, root.width * 0.58)
                Layout.preferredHeight: width
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                color: "#ffffff"
                radius: 14
                border.width: 1
                border.color: "#d7e0eb"

                Grid {
                    id: board
                    anchors.fill: parent
                    anchors.margins: 10
                    rows: 9
                    columns: 9

                    Repeater {
                        id: boardRepeater
                        model: 81

                        delegate: Rectangle {
                            id: cell
                            property int row: Math.floor(index / 9)
                            property int column: index % 9
                            property bool active: root.selectedCell === index
                            property bool highlighted: root.selectedCell >= 0 &&
                                (root.selectedCell % 9 === column ||
                                 Math.floor(root.selectedCell / 9) === row)
                            width: board.width / 9
                            height: board.height / 9
                            color: active ? "#dbeafe" : (highlighted ? "#f3f7fd" : "#ffffff")
                            border.width: active ? 2 : 1
                            border.color: active ? "#3278c8" : "#d8e1ec"

                            function setValue(value) {
                                input.text = value
                                root.statusText = value === ""
                                    ? qsTr("Zelle geleert.")
                                    : qsTr("Zahl %1 eingetragen.").arg(value)
                            }

                            TextField {
                                id: input
                                anchors.fill: parent
                                anchors.margins: 1
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pixelSize: Math.max(18, cell.width * 0.42)
                                font.weight: Font.DemiBold
                                color: "#1f5f9f"
                                selectByMouse: true
                                maximumLength: 1
                                validator: IntValidator {
                                    bottom: 1
                                    top: 9
                                }
                                background: null
                                onActiveFocusChanged: {
                                    if (activeFocus)
                                        root.selectedCell = index
                                }
                                onTextChanged: {
                                    if (text.length > 0)
                                        root.statusText = qsTr("Zahl %1 eingetragen.").arg(text)
                                }
                                Keys.onPressed: function(event) {
                                    if (event.key === Qt.Key_Backspace ||
                                        event.key === Qt.Key_Delete) {
                                        root.clearSelectedCell()
                                        event.accepted = true
                                    }
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    root.selectedCell = index
                                    input.forceActiveFocus()
                                }
                            }

                            Connections {
                                target: root
                                function onClearBoardRequested() {
                                    input.clear()
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    x: board.x + board.width / 3 - 1
                    width: 2
                    y: board.y
                    height: board.height
                    color: "#7e91a8"
                }
                Rectangle {
                    x: board.x + board.width * 2 / 3 - 1
                    width: 2
                    y: board.y
                    height: board.height
                    color: "#7e91a8"
                }
                Rectangle {
                    x: board.x
                    y: board.y + board.height / 3 - 1
                    width: board.width
                    height: 2
                    color: "#7e91a8"
                }
                Rectangle {
                    x: board.x
                    y: board.y + board.height * 2 / 3 - 1
                    width: board.width
                    height: 2
                    color: "#7e91a8"
                }
            }

            ColumnLayout {
                Layout.preferredWidth: 220
                Layout.alignment: Qt.AlignVCenter
                spacing: 16

                Label {
                    text: qsTr("Ziffer auswählen")
                    color: "#26364a"
                    font.pixelSize: 16
                    font.weight: Font.DemiBold
                }

                GridLayout {
                    Layout.fillWidth: true
                    columns: 3
                    rowSpacing: 10
                    columnSpacing: 10

                    Repeater {
                        model: 9
                        delegate: Button {
                            required property int index
                            Layout.fillWidth: true
                            Layout.preferredHeight: 48
                            text: (index + 1).toString()
                            onClicked: root.selectNumber(index + 1)
                            background: Rectangle {
                                radius: 9
                                color: parent.down ? "#dbeafe" : "#ffffff"
                                border.color: "#cfdae8"
                                border.width: 1
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "#245e98"
                                font.pixelSize: 19
                                font.weight: Font.DemiBold
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }
                }

                Button {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 42
                    text: qsTr("Zelle löschen")
                    onClicked: root.clearSelectedCell()
                    background: Rectangle {
                        radius: 9
                        color: parent.down ? "#fce7e7" : "#fff4f4"
                        border.color: "#f2cccc"
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#b04d4d"
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Label {
                    Layout.fillWidth: true
                    text: root.statusText
                    color: "#637083"
                    font.pixelSize: 13
                    wrapMode: Text.WordWrap
                }
            }
        }

        Label {
            Layout.fillWidth: true
            text: qsTr("Tipp: Klicke auf ein Feld und gib eine Zahl von 1 bis 9 über die Tastatur oder den Ziffernblock ein.")
            color: "#7a8798"
            font.pixelSize: 13
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
