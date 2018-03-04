
import Control.Monad (liftM)
import Data.List
import Data.Maybe
import Data.Ratio ((%))

import XMonad

import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Actions.SwapWorkspaces
import XMonad.Actions.WindowBringer

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FloatNext
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName

import XMonad.Layout.Column
import XMonad.Layout.ComboP
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.TwoPane

import XMonad.ManageHook

import XMonad.Prompt
import XMonad.Prompt.Shell

import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.Scratchpad

import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myTerminal      = "urxvt"
myBorderWidth   = 2
modm            = mod1Mask   -- left alt
windowsKey      = mod4Mask
modm2           = mod5Mask -- right alt
myWorkspaces    = map show [1..9]
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#cd8b00"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myFont  = "-*-verdana-medium-r-*-*-14-*-*-*-*-*-iso10646-1"
--myFont = "-*-dejavu sans mono-medium-r-*-*-16-*-*-*-*-*-iso10646-*"

myWorkspaceScreens :: WorkspaceId -> Maybe Int
myWorkspaceScreens ws
  | ws == "9" = Just 1
  | otherwise = Nothing

greedyView :: WorkspaceId -> WindowSet -> WindowSet
greedyView w ws
  | isCurrentFixedAndVisibleIsNext = ws
  | any wTag (W.hidden ws) = W.view w ws
  | (Just s) <- find (wTag . W.workspace) (W.visible ws)
                        = ws { W.current = (W.current ws) { W.workspace = W.workspace s }
                             , W.visible = s { W.workspace = W.workspace (W.current ws) }
                                       : filter (not . wTag . W.workspace) (W.visible ws) }
  | otherwise = ws
  where
    wTag = (w == ) . W.tag
    isCurrentFixedAndVisibleIsNext = isJust (myWorkspaceScreens $ W.tag (W.workspace $ W.current ws)) && isJust (find (wTag . W.workspace) (W.visible ws))

-- Get the screen that a workspace is fixed to.
workspaceScreen :: Int -> WindowSet -> W.Screen WorkspaceId (Layout Window) Window ScreenId ScreenDetail
workspaceScreen screen s =
    screens !! index
      where
        screens = sortOn W.screen $ W.screens s
        index = if length screens < screen then 0 else screen

-- Focus the monitor that a workspace is fixed to, without viewing the workspace.
focusScreen :: Int -> WindowSet -> WindowSet
focusScreen screen s = W.view (W.tag . W.workspace $ workspaceScreen screen s) s

-- View a workspace on a predefined monitor.
fixedView :: WorkspaceId -> WindowSet -> WindowSet
fixedView ws s =
  case myWorkspaceScreens ws of
    (Just screen) -> W.view ws . focusScreen screen $ s
    Nothing -> greedyView ws s

myKeys conf@XConfig {XMonad.modMask = modMask} = M.fromList $

    -- switch keyboard layout
    [ ((modm .|. shiftMask, xK_Return), spawn "switch-layout")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill1)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    --, ((modm,               xK_n     ), refresh)

    , ((modm .|. shiftMask, xK_s     ), sendMessage ToggleStruts)

    , ((modm,               xK_s     ), scratchpadSpawnActionTerminal "urxvt")

    -- Move focus to the next window
    , ((mod1Mask,           xK_Tab   ), windows W.focusDown)
    , ((modm2,              xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((windowsKey,         xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_w     ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_v     ), sendMessage (IncMasterN (-1)))

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io exitSuccess)

    -- Restart xmonad
    , ((modm              , xK_q     ), restart "xmonad" True)

    -- goto workspace and focus window
    , ((modm .|. shiftMask, xK_g     ), gotoMenuArgs ["-l", "10", "-i", "-b", "-fn", "'xft:Inconsolata:size=11'"])

    -- bring and focus window
    , ((modm .|. shiftMask, xK_b     ), bringMenuArgs ["-l", "10", "-i", "-b", "-fn", "'xft:Inconsolata:size=11'"])

    , ((modm              , xK_n     ), toggleWS)

    , ((modm              , xK_slash ), spawn "amixer set Master 5%- -q")
    , ((modm              , xK_equal ), spawn "amixer set Master 5%+ -q")

    , ((modm2             , xK_less  ), spawn "mpc seek -2%")
    , ((modm2             , xK_semicolon), spawn "mpc seek +2%")
    , ((modm2             , xK_q     ), spawn "mpc prev")
    , ((modm2             , xK_j     ), spawn "mpc next")
    , ((modm2             , xK_k     ), spawn "mpc toggle")
    , ((modm2             , xK_x     ), floatNext True >> spawn (myTerminal ++ " -geometry 80x35+480+90 -e ncmpcpp --host 127.0.0.1"))

    , ((modm             , xK_a     ), spawn "togglecursor")
    , ((modm2             , xK_o     ), spawn "dolphin")
    , ((modm2             , xK_e     ), spawn "chromium")
    , ((modm2             , xK_u     ), spawn $ XMonad.terminal conf)
    , ((modm2             , xK_i     ), spawn "pyimc openchat")

    , ((modm2             , xK_apostrophe), spawn "firefox")
    -- used by xinerama
    --, ((modm2             , xK_comma ), spawn "")
    --, ((modm2             , xK_period), spawn "")
    , ((modm2             , xK_p     ), shellPrompt myXPConfig)
    , ((modm2             , xK_y     ), spawn "thunderbird")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    -- mod-ctrl-[1..9], Swap current workspace to workspace N
    --
    [((m .|. mask, k), windows $ f i)
        | mask <- [modm, modm2]
        , (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(fixedView, 0), (W.shift, shiftMask), (swapWithCurrent, controlMask), (copy, shiftMask .|. controlMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm2, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_period, xK_comma] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myMouseBindings XConfig {XMonad.modMask = modMask} = M.fromList
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w)

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), \w -> focus w >> windows W.swapMaster)

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), \w -> focus w >> mouseResizeWindow w)

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

myLayout = avoidStruts $ smartBorders $ browserLayout commonLayouts
  where
    -- Percent of screen to increment by when resizing panes
    delta = 3/100
    tiled = Tall 1 delta (1/2)
    -- Layouts for misc workspaces
    commonLayouts = tiled ||| Mirror tiled ||| noBorders Full
    -- Layout for Chromium with Tabs Outliner extension on workspace 1
    browserLayout = onWorkspace "1" (combineTwoP (TwoPane delta 0.16) (noBorders Full) tiled (Title "Sidewise"))

myManageHook = (composeAll . concat)
    [ [className =? c --> doFloat | c <- byClass]
    , [(fmap $ isInfixOf t) title --> doFloat | t <- byTitle]
    , [resource =? r --> doFloat | r <- byResource]
    , [isFullscreen --> doFullFloat]
    ] <+> manageHook def
      <+> scratchpadManageHook (W.RationalRect 0.25 0.2 0.5 0.6)
      <+> floatNextHook
  where byClass = ["Gimp-2.6", "MPlayer", "Totem", "Skype", "skypeforlinux", "Font-atlas"]
        byTitle = ["VLC (XVideo output)", "Downloads", "Preferences", "Save As...", "Emulator"]
        byResource = []

myStartupHook = setWMName "LG3D"

myXPConfig :: XPConfig
myXPConfig = def
  { font              = myFont
  --, bgColor           = "black"
  --, fgColor           = "#999999"
  --, fgHLight          = "#ffffff"
  --, bgHLight          = "#4c7899"
  , promptBorderWidth = 0
  --, position          = Bottom
  , height            = 20
  , historySize       = 128
  }

main =
  xmonad $ def {
    -- simple stuff
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
    borderWidth        = myBorderWidth,
    modMask            = modm,
    workspaces         = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,

    -- key bindings
    keys               = myKeys,
    mouseBindings      = myMouseBindings,

    -- hooks, layouts
    layoutHook         = myLayout,
    manageHook         = myManageHook <+> manageDocks,
    startupHook        = myStartupHook
  }

