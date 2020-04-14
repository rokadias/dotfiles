import XMonad
import XMonad.Actions.CycleWS;
import XMonad.Config.Xfce
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Layout.BoringWindows
import XMonad.Layout.NoBorders

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.EZConfig (additionalKeys)

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "terminator"

-- Width of the window border in pixels.
--
myBorderWidth   = 2

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask
altMask         = mod1Mask


myExtraWorkspaces = [(xK_0, "0"),(xK_minus, "tmp"),(xK_equal, "swap")]

myWorkspaces = ["emacs","web1","slack","compile","shell","extensions","system","keepass","web2"] ++ (map snd myExtraWorkspaces)

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys =
    -- keepass launch
    [((controlMask .|. altMask, xK_a), spawn "keepass -auto-type")
    , ((myModMask, xK_b), sendMessage ToggleStruts)
    , ((myModMask, xK_d), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    , ((myModMask .|. shiftMask, xK_q), spawn "xfce4-session-logout")
    , ((altMask, xK_Tab), nextScreen)
    , ((myModMask, xK_j), focusUp)
    , ((myModMask, xK_k), focusDown)
    , ((myModMask, xK_m), focusMaster)
    , ((myModMask, xK_n), clearBoring)
    , ((myModMask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
    ] ++ [
        ((myModMask, key), (windows $ W.greedyView ws))
        | (key, ws) <- myExtraWorkspaces
    ] ++ [
        ((myModMask .|. shiftMask, key), (windows $ W.shift ws))
        | (key, ws) <- myExtraWorkspaces
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
-- default tiling algorithm partitions the screen into two panes

myLayout = boringAuto (tiled ||| (noBorders Full) ||| halved)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     halved = Tall nmaster (1/10) (1/2)

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 11/16

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

myManageHook = composeAll
  [
    className =? "Xfce4-notifyd"     --> doIgnore,
    className =? "Gimp"              --> doFloat,
    className =? "Xfce4-appfinder"   --> doFloat,
    className =? "desktop_window"    --> doIgnore,
    className =? "kdesktop"          --> doIgnore,
    className =? "zoom"              --> (doShift "0" <+> doFloat)
  ]

-- Helpers --
-- avoidMaster:  Avoid the master window, but otherwise manage new windows normally
avoidMaster :: W.StackSet i l a s sd -> W.StackSet i l a s sd
avoidMaster = W.modify' $ \c -> case c of
    W.Stack t [] (r:rs) -> W.Stack t [r] rs
    otherwise           -> c

-- ManageHook --
pbManageHook :: ManageHook
pbManageHook = composeAll $ concat
    [ [ manageDocks ]
    , [ manageHook defaultConfig ]
    , [ isDialog --> doCenterFloat ]
    , [ isFullscreen --> doFullFloat ]
    , [ fmap not isDialog --> doF avoidMaster ]
    ]

myConfig = ewmh xfceConfig {
   -- simple stuff
     terminal     = myTerminal,
     modMask      = myModMask,
     borderWidth  = myBorderWidth,

   -- hooks, layouts
     manageHook      = myManageHook <+> manageDocks <+> manageHook xfceConfig,
     logHook         = ewmhDesktopsLogHook,
     layoutHook      = avoidStruts $ myLayout,
     handleEventHook = ewmhDesktopsEventHook,
     startupHook     = ewmhDesktopsStartup,

   -- workspaces
     workspaces      = myWorkspaces
   }
   `additionalKeys` myKeys

main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- Command to launch the bar.
myBar = "xfce4-panel -r"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
