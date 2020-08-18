-----------------------------------------------------------------------------------------
--
-- page1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- forward declarations and other locals
local background, pageText, continueText, pageTween, fadeTween1, fadeTween2, sunObj, moonObj, coronaIcon

local swipeThresh = 100		-- amount of pixels finger must travel to initiate page swipe
local tweenTime = 500
local animStep = 1
local readyToContinue = false

-- function to show next animation
local function showNext()
	if readyToContinue then
		continueText.isVisible = false
		readyToContinue = false
		
		local function repositionAndFadeIn()
			pageText.x = display.contentWidth * 0.5
			pageText.y = display.contentHeight * 0.20
			pageText.isVisible = true
			
			fadeTween1 = transition.to( pageText, { time=tweenTime*0.5, alpha=1.0 } )
		end
		
		local function completeTween()
			animStep = animStep + 1
			if animStep > 3 then animStep = 1; end
			
			readyToContinue = true
			continueText.isVisible = true
		end
		
		if animStep == 1 then
			pageText.alpha = 0
			pageText.text = "High-performance, OpenGL graphics engine."
			repositionAndFadeIn()
			
			-- hide corona icon
			coronaIcon.isVisible = false
			
			sunObj.alpha = 1
			sunObj.x = -sunObj.contentWidth
			sunObj.isVisible = true
			pageTween = transition.to( sunObj, { time=tweenTime, x=display.contentWidth*0.5, transition=easing.outExpo, onComplete=completeTween } )
			
		elseif animStep == 2 then
			pageText.alpha = 0
			pageText.text = "Easy API accessed via Lua scripting."
			repositionAndFadeIn()
			
			moonObj.alpha = 1
			moonObj.x = display.contentWidth + moonObj.contentWidth
			moonObj.isVisible = true
			pageTween = transition.to( moonObj, { time=tweenTime, x=display.contentWidth*0.5, transition=easing.outExpo, onComplete=completeTween } )
		
		elseif animStep == 3 then
			pageText.alpha = 0
			pageText.text = "Solar2D: Code Less. Play More."
			repositionAndFadeIn()
			
			-- hide sun and moon
			fadeTween1 = transition.to( sunObj, { time=tweenTime*0.5, alpha=0 } )
			fadeTween2 = transition.to( moonObj, { time=tweenTime*0.5, alpha=0 } )
			
			coronaIcon.isVisible = true
			coronaIcon.alpha = 0
			coronaIcon.x = display.contentWidth * 0.5
			pageTween = transition.to( coronaIcon, { time=tweenTime*1.5, alpha=1, transition=easing.inOutExpo, onComplete=completeTween } )
		end
	end
end

-- touch event listener for background object
local function onPageSwipe( self, event )
	local phase = event.phase
	if phase == "began" then
		display.getCurrentStage():setFocus( self )
		self.isFocus = true
	
	elseif self.isFocus then
		if phase == "ended" or phase == "cancelled" then
			
			local distance = event.x - event.xStart
			if distance > swipeThresh then
				-- SWIPED to right; go back to title page scene
				composer.gotoScene( "title", "slideRight", 800 )
			else
				-- Touch and release; initiate next animation
				showNext()
			end
			
			display.getCurrentStage():setFocus( nil )
			self.isFocus = nil
		end
	end
	return true
end

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	-- create background image
	background = display.newImageRect( sceneGroup, "space.jpg", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0
	background.alpha = 0.5
	
	-- create overlay
	local overlay = display.newImageRect( sceneGroup, "pagebg1.png", display.contentWidth, display.contentHeight )
	overlay.anchorX = 0
	overlay.anchorY = 0
	overlay.x, overlay.y = 0, 0
	
	-- create sun, moon, and corona icon
	sunObj = display.newImageRect( sceneGroup, "sun.png", 300, 300 )
	sunObj.x = display.contentWidth * 0.5
	sunObj.y = display.contentHeight * 0.5
	sunObj.isVisible = false
	
	moonObj = display.newImageRect( sceneGroup, "moon.png", 300, 300 )
	moonObj.x = display.contentWidth * 0.5
	moonObj.y = display.contentHeight * 0.5
	moonObj.isVisible = false
	
	coronaIcon = display.newImageRect( sceneGroup, "coronaicon-big.png", 450, 444 )
	coronaIcon.x = display.contentWidth * 0.5
	coronaIcon.y = display.contentHeight * 0.5
	coronaIcon.alpha = 0
	
	-- create pageText
	pageText = display.newText( sceneGroup, "", 0, 0, native.systemFontBold, 18 )
	pageText.x = display.contentWidth * 0.5
	pageText.y = display.contentHeight * 0.5
	pageText.isVisible = false
	
	-- create text at bottom of screen
	continueText = display.newText( sceneGroup, "[ Tap screen to continue ]", 0, 0, native.systemFont, 18 )
	continueText.x = display.contentWidth * 0.5
	continueText.y = display.contentHeight - (display.contentHeight * 0.04 )
	continueText.isVisible = false
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		
		animStep = 1
		readyToContinue = true
		showNext()
	
		-- assign touch event to background to monitor page swiping
		background.touch = onPageSwipe
		background:addEventListener( "touch", background )
	end	

end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		
		-- hide objects
		sunObj.isVisible = false
		moonObj.isVisible = false
		coronaIcon.isVisible = false
		pageText.isVisible = false
	
		-- remove touch event listener for background
		background:removeEventListener( "touch", background )
	
		-- cancel page animations (if currently active)
		if pageTween then transition.cancel( pageTween ); pageTween = nil; end
		if fadeTween1 then transition.cancel( fadeTween1 ); fadeTween1 = nil; end
		if fadeTween2 then transition.cancel( fadeTween2 ); fadeTween2 = nil; end
		
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end		

end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
