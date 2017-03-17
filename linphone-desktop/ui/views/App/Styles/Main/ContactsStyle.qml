pragma Singleton
import QtQuick 2.7

import Common 1.0

// =============================================================================

QtObject {
  property color backgroundColor: Colors.k
  property int spacing: 20

  property QtObject bar: QtObject {
    property color backgroundColor: Colors.e
    property int height: 60
    property int leftMargin: 18
    property int rightMargin: 18
  }

  property QtObject contact: QtObject {
    property int actionButtonsSize: 36
    property int avatarSize: 30
    property int deleteButtonSize: 18
    property int height: 50
    property int leftMargin: 40
    property int presenceLevelSize: 12
    property int rightMargin: 25
    property int spacing: 15
    property int presenceStringFontSize: 10
    property color presenceStringColor: Colors.w

    property QtObject backgroundColor: QtObject {
      property color normal: Colors.k
      property color hovered: Colors.p
    }

    property QtObject border: QtObject {
      property color color: Colors.f
      property int width: 1
    }

    property QtObject indicator: QtObject {
      property color color: Colors.i
      property int width: 5
    }

    property QtObject username: QtObject {
      property color color: Colors.j
      property int fontSize: 9
      property int width: 220
    }
  }
}
