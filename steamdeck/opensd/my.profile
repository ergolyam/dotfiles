[Profile]
Name        = "Grisha's765 OpenSD Profile"
Description = "A basic configuration that should work for most games and provide a few extras."


[Features]
ForceFeedback   = false

MotionDevice    = false

MouseDevice     = true

LizardMode      = false

StickFiltering  = true

TrackpadFiltering  = true


[DeviceInfo]

[Deadzones]
LStick      = 0.1
RStick      = 0.1
LPad        = 0
RPad        = 0
LTrigg      = 0
RTrigg      = 0


[GamepadAxes]
#-----------------------------------------------------------
# Axis            Min       Max         Fuzz    Resolution
#-----------------------------------------------------------
ABS_HAT0X       = -1        1
ABS_HAT0Y       = -1        1
ABS_X           = -32767    32767
ABS_Y           = -32767    32767
ABS_RX          = -32767    32767
ABS_RY          = -32767    32767
ABS_Z           = 0         32767
ABS_RZ          = 0         32767


[MotionAxes]
#-----------------------------------------------------------
# Axis            Min       Max         Fuzz    Resolution
#-----------------------------------------------------------
ABS_X           = -32767    32767
ABS_Y           = -32767    32767
ABS_Z           = -32767    32767
ABS_RX          = -32767    32767
ABS_RY          = -32767    32767
ABS_RZ          = -32767    32767


[Touchpads]
#---------------------------------------
# Axis                x         y
#---------------------------------------
LPadSensitivity     = 0.65       0.65
RPadSensitivity     = 0.65       0.65

#---------------------------------------
# Axis            x         y
#---------------------------------------
LPadDecay       = 0.05      0.05
RPadDecay       = 0.05      0.05


[Bindings]
#-----------------------------------------------------------
# Input             BindType    Mapping     +/-/scale
#-----------------------------------------------------------
# Directional Pad
DpadUp              = Mouse     KEY_UP
DpadDown            = Mouse     KEY_DOWN
DpadLeft            = Mouse     KEY_LEFT
DpadRight           = Mouse     KEY_RIGHT
# Buttons
A                   = Mouse   KEY_ENTER
B                   = Mouse   KEY_ESC
X                   = Command true 300 "hyprctl dispatch killactive"
Y                   = Command true 300 "wofi --show drun"
L1                  = Command true 300 "~/.config/hypr/set_workspace.sh prev"
R1                  = Command true 300 "~/.config/hypr/set_workspace.sh next"
L2                  = Mouse   BTN_RIGHT
R2                  = Mouse   BTN_LEFT
L3                  = Gamepad   BTN_THUMBL
R3                  = Gamepad   BTN_THUMBR
L4                  = None
R4                  = None
L5                  = None
R5                  = None
Menu                = Gamepad   BTN_START
Options             = Gamepad   BTN_SELECT
Steam               = Mouse   KEY_LEFTMETA
QuickAccess         = Mouse     BTN_RIGHT
# Triggers
LTrigg              = None
RTrigg              = None
# Left Stick
LStickUp            = Gamepad   ABS_Y       -
LStickDown          = Gamepad   ABS_Y       +
LStickLeft          = Gamepad   ABS_X       -
LStickRight         = Gamepad   ABS_X       +
LStickTouch         = None
LStickForce         = None
# Right Stick
RStickUp            = Gamepad   ABS_RY      -
RStickDown          = Gamepad   ABS_RY      +
RStickLeft          = Gamepad   ABS_RX      -
RStickRight         = Gamepad   ABS_RX      +
RStickTouch         = None
RStickForce         = None
# Left Trackpad
LPadUp              = None
LPadDown            = None
LPadLeft            = None
LPadRight           = None
LPadTouch           = None
LPadRelX            = None
LPadRelY            = None
LPadTouch           = None
LPadPress           = None
LPadForce           = None
LPadPressQuadUp     = None
LPadPressQuadDown   = None
LPadPressQuadLeft   = None
LPadPressQuadRight  = None
LPadPressOrthUp     = None
LPadPressOrthDown   = None
LPadPressOrthLeft   = None
LPadPressOrthRight  = None
LPadPressGrid2x2_1  = None
LPadPressGrid2x2_2  = None
LPadPressGrid2x2_3  = None
LPadPressGrid2x2_4  = None
LPadPressGrid3x3_1  = None
LPadPressGrid3x3_2  = None
LPadPressGrid3x3_3  = None
LPadPressGrid3x3_4  = None
LPadPressGrid3x3_5  = None
LPadPressGrid3x3_6  = None
LPadPressGrid3x3_7  = None
LPadPressGrid3x3_8  = None
LPadPressGrid3x3_9  = None
# Right Trackpad
RPadUp              = None
RPadDown            = None
RPadLeft            = None
RPadRight           = None
RPadTouch           = None
RPadRelX            = Mouse     REL_X
RPadRelY            = Mouse     REL_Y
RPadTouch           = None
RPadPress           = Mouse     BTN_LEFT
RPadForce           = None
RPadPressQuadUp     = None
RPadPressQuadDown   = None
RPadPressQuadLeft   = None
RPadPressQuadRight  = None
RPadPressOrthUp     = None
RPadPressOrthDown   = None
RPadPressOrthLeft   = None
RPadPressOrthRight  = None
RPadPressGrid2x2_1  = None
RPadPressGrid2x2_2  = None
RPadPressGrid2x2_3  = None
RPadPressGrid2x2_4  = None
RPadPressGrid3x3_1  = None
RPadPressGrid3x3_2  = None
RPadPressGrid3x3_3  = None
RPadPressGrid3x3_4  = None
RPadPressGrid3x3_5  = None
RPadPressGrid3x3_6  = None
RPadPressGrid3x3_7  = None
RPadPressGrid3x3_8  = None
RPadPressGrid3x3_9  = None
# Accelerometers
AccelXPlus          = Motion    ABS_RX      +
AccelXMinus         = Motion    ABS_RX      -
AccelYPlus          = Motion    ABS_RY      +
AccelYMinus         = Motion    ABS_RY      -
AccelZPlus          = Motion    ABS_RZ      +
AccelZMinus         = Motion    ABS_RZ      -
# Gyro / Attitude
RollPlus            = Motion    ABS_X       +
RollMinus           = Motion    ABS_X       -
PitchPlus           = Motion    ABS_Y       +
PitchMinus          = Motion    ABS_Y       -
YawPlus             = Motion    ABS_Z       +
YawMinus            = Motion    ABS_Z       -
