----------------------------------------------------------------------
--
--  ___FILENAME___
--  ___PROJECTNAME___
--
--  Created by ___FULLUSERNAME___ on ___DATE___.
--  (c)___COPYRIGHT___ ___YEAR___
--
----------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer = require "composer"

-- load title screen
composer.gotoScene( "title", "fade" )