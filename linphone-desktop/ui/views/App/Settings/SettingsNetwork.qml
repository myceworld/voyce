import QtQuick 2.7

import Common 1.0
import Linphone 1.0

import App.Styles 1.0

// =============================================================================

TabContainer {
  Column {
    spacing: SettingsWindowStyle.forms.spacing
    width: parent.width

    // -------------------------------------------------------------------------
    // Network protocol and ports.
    // -------------------------------------------------------------------------

    Form {
      title: qsTr('networkProtocolAndPortsTitle')
      width: parent.width

      FormHeader {
        FormHeaderGroup {
          text: qsTr('portHeader')
        }

        FormHeaderEntry {
          text: qsTr('randomPortHeader')
        }

        FormHeaderEntry {
          text: qsTr('enabledPortHeader')
        }
      }

      FormLine {
        FormGroup {
          label: qsTr('sipUdpPortLabel')

          NumericField {
            minValue: 0
            maxValue: 65535
            readOnly: randomSipUdpPort.checked || !enableSipUdpPort.checked
          }
        }

        FormEntry {
          Switch {
            id: randomSipUdpPort

            enabled: enableSipUdpPort.checked
          }
        }

        FormEntry {
          Switch {
            id: enableSipUdpPort
          }
        }
      }

      FormLine {
        FormGroup {
          label: qsTr('sipTcpPortLabel')

          NumericField {
            minValue: 0
            maxValue: 65535
            readOnly: randomSipTcpPort.checked || !enableSipTcpPort.checked
          }
        }

        FormEntry {
          Switch {
            id: randomSipTcpPort

            enabled: enableSipTcpPort.checked
          }
        }

        FormEntry {
          Switch {
            id: enableSipTcpPort
          }
        }
      }

      FormLine {
        id: audioRtpUdpPort

        readonly property int defaultPort: 7078

        FormGroup {
          label: qsTr('audioRtpUdpPortLabel')

          PortField {
            readOnly: randomAudioRtpUdpPort.checked
            supportsRange: true
            text: SettingsModel.audioPortRange.join(':')

            onEditingFinished: SettingsModel.audioPortRange = [ portA, portB ]
          }
        }

        FormEntry {
          Switch {
            id: randomAudioRtpUdpPort

            checked: SettingsModel.audioPortRange[0] === -1

            onClicked: SettingsModel.audioPortRange = checked
              ? [ audioRtpUdpPort.defaultPort, -1 ]
              : [ -1, -1 ]
          }
        }
      }

      FormLine {
        id: videoRtpUdpPort

        readonly property int defaultPort: 9078

        FormGroup {
          label: qsTr('videoRtpUdpPortLabel')

          PortField {
            readOnly: randomVideoRtpUdpPort.checked
            supportsRange: true
            text: SettingsModel.videoPortRange.join(':')

            onEditingFinished: SettingsModel.videoPortRange = [ portA, portB ]
          }
        }

        FormEntry {
          Switch {
            id: randomVideoRtpUdpPort

            checked: SettingsModel.videoPortRange[0] === -1

            onClicked: SettingsModel.videoPortRange = checked
              ? [ videoRtpUdpPort.defaultPort, -1 ]
              : [ -1, -1 ]
          }
        }
      }

      FormEmptyLine {}

      FormLine {
        FormGroup {
          label: qsTr('enableTlsLabel')

          Switch {}
        }
      }
    }

    // -------------------------------------------------------------------------
    // Transport.
    // -------------------------------------------------------------------------

    Form {
      title: qsTr('transportTitle')
      width: parent.width

      FormLine {
        FormGroup {
          label: qsTr('sendDtmfsLabel')

          ExclusiveButtons {
            selectedButton: Number(!SettingsModel.useSipInfoForDtmfs)
            texts: [
              'SIP INFO',
              'RFC 2833'
            ]

            onClicked: SettingsModel.useSipInfoForDtmfs = !button
          }
        }

        FormGroup {
          label: qsTr('allowIpV6Label')

          Switch {
            checked: SettingsModel.ipv6Enabled

            onClicked: SettingsModel.ipv6Enabled = !checked
          }
        }
      }
    }

    // -------------------------------------------------------------------------
    // Bandwidth control.
    // -------------------------------------------------------------------------

    Form {
      title: qsTr('bandwidthControlTitle')
      width: parent.width

      FormLine {
        FormGroup {
          label: qsTr('downloadSpeedLimitLabel')

          NumericField {
            minValue: 0
            maxValue: 100000
          }
        }

        FormGroup {
          label: qsTr('uploadSpeedLimitLabel')

          NumericField {
            minValue: 0
            maxValue: 100000
          }
        }
      }

      FormLine {
        FormGroup {
          label: qsTr('enableAdaptiveRateControlLabel')

          Switch {}
        }
      }
    }

    // -------------------------------------------------------------------------
    // NAT and Firewall.
    // -------------------------------------------------------------------------

    Form {
      title: qsTr('natAndFirewallTitle')
      width: parent.width

      FormLine {
        FormGroup {
          label: qsTr('enableIceLabel')

          Switch {
            id: enableIce

            checked: SettingsModel.iceEnabled

            onClicked: SettingsModel.iceEnabled = !checked
          }
        }

        FormGroup {
          label: qsTr('stunServerLabel')

          TextField {
            readOnly: !enableIce.checked

            text: SettingsModel.stunServer

            onEditingFinished: SettingsModel.stunServer = text
          }
        }
      }

      FormLine {
        FormGroup {
          label: qsTr('enableTurnLabel')

          Switch {
            id: enableTurn

            enabled: enableIce.checked
            checked: SettingsModel.turnEnabled

            onClicked: SettingsModel.turnEnabled = !checked
          }
        }

        FormGroup {
          label: qsTr('turnUserLabel')

          TextField {
            id: turnUser

            readOnly: !enableTurn.checked || !enableTurn.enabled
            text: SettingsModel.turnUser

            onEditingFinished: SettingsModel.turnUser = text
          }
        }
      }

      FormLine {
        FormGroup {
          label: ''
        }

        FormGroup {
          label: qsTr('turnPasswordLabel')

          TextField {
            readOnly: !enableTurn.checked || !enableTurn.enabled || !turnUser.text.length
            text: SettingsModel.turnPassword

            onEditingFinished: SettingsModel.turnPassword = text
          }
        }
      }
    }

    // -------------------------------------------------------------------------
    // DSCP fields.
    // -------------------------------------------------------------------------

    Form {
      title: qsTr('dscpFieldsTitle')
      width: parent.width

      FormLine {
        FormGroup {
          label: qsTr('sipFieldLabel')

          HexField {
            text: SettingsModel.dscpSip
            onEditingFinished: SettingsModel.dscpSip = value
          }
        }
      }

      FormLine {
        FormGroup {
          label: qsTr('audioRtpStreamFieldLabel')

          HexField {
            text: SettingsModel.dscpAudio
            onEditingFinished: SettingsModel.dscpAudio = value
          }
        }

        FormGroup {
          label: qsTr('videoRtpStreamFieldLabel')

          HexField {
            text: SettingsModel.dscpVideo
            onEditingFinished: SettingsModel.dscpVideo = value
          }
        }
      }
    }
  }
}
