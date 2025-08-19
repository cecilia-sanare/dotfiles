pragma ComponentBehavior: Bound
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import "../common"

Scope {
    id: screenCorners
    readonly property Toplevel activeWindow: ToplevelManager.activeToplevel

    component CornerPanelWindow: PanelWindow {
        id: cornerPanelWindow
        visible: !screenCorners.activeWindow?.fullscreen
        property var corner

        exclusionMode: ExclusionMode.Ignore
        mask: Region {
            item: null
        }
        WlrLayershell.namespace: "quickshell:screenCorners"
        WlrLayershell.layer: WlrLayer.Overlay
        color: "transparent"

        anchors {
            top: cornerPanelWindow.corner === RoundCorner.CornerEnum.TopLeft || cornerPanelWindow.corner === RoundCorner.CornerEnum.TopRight
            left: cornerPanelWindow.corner === RoundCorner.CornerEnum.TopLeft || cornerPanelWindow.corner === RoundCorner.CornerEnum.BottomLeft
            bottom: cornerPanelWindow.corner === RoundCorner.CornerEnum.BottomLeft || cornerPanelWindow.corner === RoundCorner.CornerEnum.BottomRight
            right: cornerPanelWindow.corner === RoundCorner.CornerEnum.TopRight || cornerPanelWindow.corner === RoundCorner.CornerEnum.BottomRight
        }

        implicitWidth: cornerWidget.implicitWidth
        implicitHeight: cornerWidget.implicitHeight
        RoundCorner {
            id: cornerWidget
            size: 20
            corner: cornerPanelWindow.corner
        }
    }

    Variants {
        model: Quickshell.screens

        Scope {
            id: scope
            required property var modelData

            CornerPanelWindow {
                screen: scope.modelData
                corner: RoundCorner.CornerEnum.TopLeft
            }

            CornerPanelWindow {
                screen: scope.modelData
                corner: RoundCorner.CornerEnum.TopRight
            }

            CornerPanelWindow {
                screen: scope.modelData
                corner: RoundCorner.CornerEnum.BottomLeft
            }

            CornerPanelWindow {
                screen: scope.modelData
                corner: RoundCorner.CornerEnum.BottomRight
            }
        }
    }
}
