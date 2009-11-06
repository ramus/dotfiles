import IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.SimplestFloat
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run
import XMonad.Util.Scratchpad

myTerminal = "urxvtc"
myBorderWidth = 1
myNormalBorderColor = "#262729"
myFocusedBorderColor = "#659fdb"

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ withUrgencyHook NoUrgencyHook defaultConfig
    { terminal = myTerminal
    , modMask = mod4Mask
    , layoutHook = myLayoutHook
    , manageHook = myManageHook
    , logHook = myLogHook xmproc
    -- Appearance
    , borderWidth = myBorderWidth
    , normalBorderColor = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    }
    -- Key bindings
    `additionalKeysP` myKeys

-- logHook {{{
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ xmobarPP
              { ppOutput = hPutStrLn h
              , ppTitle = xmobarColor "green" "" . shorten 50
              , ppUrgent = xmobarColor "red" ""
              , ppHiddenNoWindows = xmobarColor "gray" ""
              , ppSep = " | "
              , ppSort = fmap (.scratchpadFilterOutWorkspace) $ ppSort xmobarPP
              }
-- }}}

-- layoutHook {{{
myLayoutHook = avoidStruts $
               smartBorders $
               tiled ||| Mirror tiled ||| Grid ||| Full ||| simplestFloat
    where
        tiled = Tall nmaster delta ratio
        nmaster = 1
        ratio = 1/2
        delta = 3/100
-- }}}

-- manageHook {{{
myManageHook = scratchpadManageHookDefault <+> composeAll
    [ className =? "MPlayer"  --> doFloat
    , className =? "feh"      --> doFloat
    , className =? "Gimp"     --> doFloat
    , className =? "xmessage" --> doFloat
    , className =? "VLC media player" --> doFloat
    ]
-- }}}

-- myKeys {{{
myKeys = [ ("M4-f", spawn "firefox")
         , ("M4-<F12>", spawn "xlock")
         , ("<Print>", spawn "scrot -e 'mv $f ~/tmp/'")
         , ("C-<Print>", spawn "scrot -s -e 'mv $f ~/tmp/'")
         , ("M4-u", focusUrgent)
         , ("M4-s", scratchpadSpawnActionTerminal "urxvtc")
         -- Multimedia keys
         , ("<XF86AudioMute>", spawn "amixer -c 0 set Master toggle")
         , ("<XF86AudioLowerVolume>", spawn "amixer -q set Master 5%-")
         , ("<XF86AudioRaiseVolume>", spawn "amixer -q set Master 5%+ unmute")
         , ("<XF86AudioPlay>", spawn "mpc toggle")
         , ("<XF86AudioPrev>", spawn "mpc prev")
         , ("<XF86AudioNext>", spawn "mpc next")
         , ("<XF86AudioStop>", spawn "mpc stop")
         ]
-- }}}
