import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import Graphics.X11.ExtraTypes.XF86
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

myAdditionalKeys = [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        , ((0, xF86XK_MonBrightnessUp), spawn "scrot")
        , ((0, xF86XK_MonBrightnessDown), spawn "scrot")
        , ((0, xF86XK_AudioMute), spawn "scrot")
        , ((0, xF86XK_AudioLowerVolume), spawn "scrot")
        , ((0, xF86XK_AudioRaiseVolume), spawn "scrot")
        , ((0, xF86XK_iTouch), spawn "scrot")
        , ((0, xF86XK_KbdBrightnessUp), spawn "scrot")
        , ((0, xF86XK_KbdBrightnessDown), spawn "scrot")
        , ((0, xF86XK_Launch1), spawn "scrot")
        , ((0, xF86XK_Launch3), spawn "scrot")
        , ((0, xF86XK_Display), spawn "scrot")
        ]

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/cain/.xmonad/.xmobarrc"
    xmonad $ defaultConfig
        { manageHook  = manageDocks <+> myManageHooks <+> manageHook defaultConfig
        , layoutHook  = avoidStruts  $  layoutHook defaultConfig -- Allow statusbars
        , logHook     = dynamicLogWithPP xmobarPP
                            { ppOutput = hPutStrLn xmproc
                            , ppTitle  = xmobarColor "green" "" . shorten 50
                            , ppLayout = const ""
                            }
        , modMask     = mod4Mask -- Rebind mod to the Windows key
        , borderWidth = 2
        , normalBorderColor = "#abc123"
        , focusedBorderColor = "#456def"
        , workspaces = myWorkspaces
        } `additionalKeys` myAdditionalKeys

myWorkspaces = ["1:main", "2:code", "3:web", "4:media", "5:chat", "6", "7"]

myManageHooks = composeAll
    [ className =? "chromium" --> doShift "3:web"
    , className =? "Xchat" --> doShift "5:chat"
    ]
