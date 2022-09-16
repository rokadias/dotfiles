{-# LANGUAGE ImplicitParams, NoMonomorphismRestriction, QuasiQuotes #-}

import Control.Monad
import Data.Function (on)
import Data.List ( findIndex, sortBy )
import System.IO
import Text.Regex.Posix ((=~))

import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.PhysicalScreens
import XMonad.Config.Xfce
import XMonad.Core

import qualified XMonad.StackSet as W

import XMonad.Layout.NoBorders

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Run

myAppendFile :: FilePath -> String -> IO ()
myAppendFile f s = do
  withFile f AppendMode $ \h -> do
    hPutStrLn h s

logToTmpFile :: String -> IO ()
logToTmpFile = myAppendFile "/tmp/xmonad.log"

lifted :: (Monad m) => m ScreenId -> m (IO ())
lifted = liftM (logToTmpFile . show)

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "terminator"

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask
altMask         = mod1Mask


myExtraWorkspaces = [(xK_0, "video"),(xK_minus, "network"),(xK_equal, "music")]

myWorkspaces = ["emacs","web1","slack","compile","shell","games","system","keepass","web2"] ++ (map snd myExtraWorkspaces)

performPrimaryNeighborView index = (getPrimaryNeighbour horizontalScreenOrderer 1) >>= screenWorkspace >>= flip whenJust (windows . W.view)

greedySwitchMaybe :: Maybe ScreenId -> X (Maybe WorkspaceId)
greedySwitchMaybe screenId =
  do w <- gets windowset
     let result =
           case screenId of
             Just sid -> W.lookupWorkspace sid w
             Nothing -> Nothing
     return result


grabWorkspace :: ScreenComparator -> PhysicalScreen -> X()
grabWorkspace screenComparer index = (getScreen screenComparer index) >>= greedySwitchMaybe >>= flip whenJust (windows . W.greedyView)

getPrimaryNeighbour :: ScreenComparator -> Int -> X ScreenId
getPrimaryNeighbour (ScreenComparator cmpScreen) d =
  do w <- gets windowset
     let ss = map W.screen $ sortBy (cmpScreen `on` getScreenIdAndRectangle) $ W.current w : W.visible w
         curPos = maybe 0 id $ findIndex (== W.screen (W.current w)) ss
         initialPos = (curPos + d) `mod` length ss
         pos = case (length ss) > 2 of
           True -> initialPos `mod` ((length ss) - 1)
           False -> initialPos
     return $ ss !! pos

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys =
    -- keepass launch
    [((controlMask .|. altMask, xK_a), spawn "keepass -auto-type")
    , ((myModMask, xK_b), sendMessage ToggleStruts)
    , ((myModMask, xK_d), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    , ((myModMask .|. shiftMask, xK_q), spawn "xfce4-session-logout")
    , ((altMask, xK_Tab), performPrimaryNeighborView 1)
    , ((myModMask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
    , ((myModMask, xK_grave), spawn "dunstctl history-pop")
    , ((myModMask, xK_bracketright), spawn "dunstctl close")
    , ((myModMask .|. shiftMask, xK_bracketright), spawn "dunstctl close-all")
    ] ++ [
        ((myModMask .|. m, xK_f), f horizontalScreenOrderer 2)
        | (f, m) <- [(viewScreen, 0), (grabWorkspace, shiftMask)]
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

myLayout =  (Full) ||| tiled
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 11/16

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

-- Helpers --
-- avoidMaster:  Avoid the master window, but otherwise manage new windows normally
avoidMaster :: W.StackSet i l a s sd -> W.StackSet i l a s sd
avoidMaster = W.modify' $ \c -> case c of
    W.Stack t [] (r:rs) -> W.Stack t [r] rs
    otherwise           -> c

myManageHook = composeAll
  [
    className =? "Xfce4-notifyd"     --> doIgnore,
    className =? "Gimp"              --> doFloat,
    className =? "Xfce4-appfinder"   --> doFloat,
    className =? "desktop_window"    --> doIgnore,
    className =? "kdesktop"          --> doIgnore,
    className =? "emacs"             --> doShift "emacs",
    className =? "google-chrome"     --> doShift "web1",
    className =? "slack"             --> doShift "slack",
    className =? "discord"           --> doShift "slack",
    className =? "Steam"             --> (doShift "games" <+> doFloat),
    className =? "Moonlight"         --> (doShift "games" <+> unfloat),
    className =? "keepassx2"         --> doShift "keepass",
    className =? "conky"             --> doShift "keepass",
    className =? "zoom"              --> (doShift "video" <+> doFloat),
    className ~? "^join\\?action=join" --> (doShift "video" <+> doFloat),
    className =? "pritunl"           --> (doShift "network" <+> doFloat),
    className =? "brave"             --> doShift "music",
    isFullscreen                     --> doFullFloat,
    isDialog                         --> doCenterFloat,
    fmap not isDialog                --> doF avoidMaster
  ]
  where unfloat = ask >>= doF . W.sink

myConfig = ewmh xfceConfig {
   -- simple stuff
     terminal     = myTerminal,
     modMask      = myModMask,
     borderWidth  = myBorderWidth,

   -- hooks, layouts
     manageHook      = myManageHook <+> manageDocks <+> manageHook xfceConfig,
     layoutHook      = avoidStruts $ myLayout,

   -- workspaces
     workspaces      = myWorkspaces
   }
   `additionalKeys` myKeys

main = xmonad =<< xmobar myConfig
