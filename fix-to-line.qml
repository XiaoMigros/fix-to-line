/*
 * Copyright (C) 2023 Marc Sabatella
 * Edited        2023 XiaoMigros
 */


import MuseScore 3.0
import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

MuseScore {

  title: qsTr("Fix to Line")
  version:  "1.0.1"
  description: qsTr("This plugin allows you to set the fix-to-line property for notes")
  pluginType: "dialog"
  requiresScore: true
  categoryCode: "composing-arranging-tools"

  function applyToNotesAndRestsInSelection(func, value) {
    if (!curScore) {
      return
    }
    for (var i in curScore.selection.elements) {
      var e = curScore.selection.elements[i]
      if (e.pitch) {
        // not currently supported for rests
        func(e, value)
      }
    }
  }

  function setFixed(noterest, fixed) {
    noterest.fixed = fixed
  }

  function setFixedLine(noterest, line) {
    noterest.fixedLine = line
  }

  width: content.implicitWidth
  height: content.implicitHeight

  ColumnLayout {
    id: content
    RowLayout {
      Layout.margins: 5
      Label {
        text: qsTr("Fix")
      }
      CheckBox {
        id: fix
        checked: true
      }
      Label {
        text: qsTr("Line")
      }
      SpinBox {
        id: line
        enabled: fix.checked
        from: -99
        to: 99
        value: 0
      }
    }
	DialogButtonBox {
      standardButtons: StandardButton.Ok | StandardButton.Cancel
      onAccepted: {
        curScore.startCmd()
        applyToNotesAndRestsInSelection(setFixed, fix.checked)
        applyToNotesAndRestsInSelection(setFixedLine, line.value)
        curScore.endCmd()
        quit()
      }
      onRejected: {
         quit()
      }
    }
  }//ColumnLayout

}//MuseScore
