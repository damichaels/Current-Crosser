
local composer = require( "composer" )

local scene = composer.newScene()

--local appodeal = require( "plugin.appodeal" )
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------


----Sounds----

local buttonSound = audio.loadSound( "multimedia_button_click_015.mp3" )


----Encoding/Decoding----

local json = require( "json" )

--Sound--

local soundOnOrOff  --0=mute 1=sound on
local filePath3 = system.pathForFile( "soundOnOrOff.json", system.DocumentsDirectory )

local file3 = io.open( filePath3, "r" )
if file3 then
	local contents3 = file3:read( "*a" )
	io.close( file3 )
	soundOnOrOff = json.decode( contents3 )
end
if ( soundOnOrOff == nil or soundOnOrOff == 1 ) then
	soundOnOrOff=1
end



--Configure image sheet
local sheetOptions =
{
    frames =
    {
        {   -- 1) Orange Checkers
            x = 288,
            y = 32,
            width = 192,
            height = 192
        },
        {   -- 2) Gray Checkers
            x = 544,
            y = 32,
            width = 192,
            height = 192
        },
        {   -- 3) Current Arrows
            x = 784,
            y = 16,
            width = 224,
            height = 224
        },
        {   -- 4) Aqua (main) Ball
            x = 1348,
            y = 68,
            width = 120,
            height = 120
        },
        {   -- 5) Red Obstacle
            x = 1573,
            y = 74,
            width = 182,
            height = 108
        },
        {   -- 6) Gold Nugget
            x = 64,
            y = 320,
            width = 128,
            height = 128
        },
        {   -- 7) PLAY Button  (+4 piskel frame)
            x = 320,
            y = 320,
            width = 128,
            height = 128
        },
        {   -- 8) Sound OFF Button  (+4 piskel frame)
            x = 576,
            y = 320,
            width = 128,
            height = 128
        },
        {   -- 9) Sound ON Button  (+4 piskel frame)
            x = 832,
            y = 320,
            width = 128,
            height = 128
        },
        {   -- 10) Characters Button  (+4 piskel frame)
            x = 1088,
            y = 320,
            width = 128,
            height = 128
        },
        {   -- 11) How to Play Button  (+4 piskel frame)
            x = 1344,
            y = 320,
            width = 128,
            height = 128
        },
        {   -- 12) Gold Button  (+4 piskel frame)
            x = 320,
            y = 576,
            width = 128,
            height = 128
        },
        {   -- 13) Rate Button  (+4 piskel frame)
            x = 576,
            y = 576,
            width = 128,
            height = 128
        },
        {   -- 14) Ads Button  (+4 piskel frame)
            x = 832,
            y = 576,
            width = 128,
            height = 128
        },
        {   -- 15) Back Button  (+4 piskel frame)
            x = 1088,
            y = 576,
            width = 128,
            height = 128
        },
				{   -- 16) Price Button 10
            x = 293,
            y = 842,
						width = 182,
            height = 108
        },
				{   -- 17) Price Button 20
            x = 293,
            y = 1098,
						width = 182,
            height = 108
        },
				{   -- 18) Price Button 50
            x = 805,
            y = 1098,
						width = 182,
            height = 108
        },
				{   -- 19) Price Button 100
            x = 1573,
            y = 1098,
						width = 182,
            height = 108
        },
				{   -- 20) Price Button 200
            x = 1061,
            y = 1354,
						width = 182,
            height = 108
        },
				{   -- 21) Price Button 300
            x = 1573,
            y = 1354,
						width = 182,
            height = 108
        },
				{   -- 22) Price Button 500
            x = 293,
            y = 1610,
						width = 182,
            height = 108
        },
				{   -- 23) Blank Character Button
            x = 293,
            y = 1866,
						width = 182,
            height = 108
        },
				{   -- 24) Character Button Highlight
            x = 541,
            y = 1858,
						width = 198,
            height = 124
        },
				{   -- 25) Pink Ball
            x = 580,
            y = 836,
            width = 120,
            height = 120
        },
				{   -- 26) Green Ball
            x = 836,
            y = 836,
            width = 120,
            height = 120
        },
				{   -- 27) Orange Ball
            x = 1092,
            y = 836,
            width = 120,
            height = 120
        },
				{   -- 28) Red Ball
            x = 1348,
            y = 836,
            width = 120,
            height = 120
        },
				{   -- 29) Purple Ball
            x = 1604,
            y = 836,
            width = 120,
            height = 120
        },
				{   -- 30) Blue Ball
            x = 68,
            y = 1092,
            width = 120,
            height = 120
        },
				{   -- 31) Black Ball
            x = 580,
            y = 1092,
            width = 120,
            height = 120
        },
				{   -- 32) Target Ball
            x = 1092,
            y = 1092,
            width = 120,
            height = 120
        },
				{   -- 33) Color Wheel Ball
            x = 1348,
            y = 1092,
            width = 120,
            height = 120
        },
				{   -- 34) Smiley Face Ball
            x = 68,
            y = 1348,
            width = 120,
            height = 120
        },
				{   -- 35) Merica Ball
            x = 324,
            y = 1348,
            width = 120,
            height = 120
        },
				{   -- 36) Watermelon Ball
            x = 580,
            y = 1348,
            width = 120,
            height = 120
        },
				{   -- 37) Gold Pan Ball
            x = 836,
            y = 1348,
            width = 120,
            height = 120
        },
				{   -- 38) Doughnut Ball
            x = 1348,
            y = 1348,
            width = 120,
            height = 120
        },
				{   -- 39) Innertube Ball
            x = 68,
            y = 1604,
            width = 120,
            height = 120
        },
				{   -- 40) +10 Rewarded Video Button  (+4 piskel frame)
						x = 1344,
						y = 576,
						width = 128,
						height = 128
        },

    },
}

local objectSheet = graphics.newImageSheet("gameObjects4.png", sheetOptions)


local textBlock
local howToPlayText
local circleMask
local backButton
local forwardButton

local currentSlide
local pic1a
local pic1b
local pic2
local pic3
local text1
local text1b
local text2
local text2b
local text3
local text3b
local text4
local text4b
local text5
local text5b
local text6
local text6b
local number1
local number2
local number3


----LEVELS----

local backGroup
local mainGroup


--------GAME FUNCTIONS--------

----Go To Main Menu----

local function goToMainMenu()
	composer.gotoScene( "mainMenu" )
end

----Go Back----

local function goBack()
	if (soundOnOrOff==1) then
		audio.play( buttonSound )
	end

	if (currentSlide==1) then
		goToMainMenu()
	elseif (currentSlide==2) then
		pic2.alpha=0
		text3.alpha=0
		text3b.alpha=0
		text4.alpha=0
		text4b.alpha=0
		number2.alpha=.5

		pic1a.alpha=1
		pic1b.alpha=1
		text1.alpha=1
		text1b.alpha=1
		text2.alpha=1
		text2b.alpha=1
		number1.alpha=1

		currentSlide=1
	elseif (currentSlide==3) then
		pic3.alpha=0
		text5.alpha=0
		text5b.alpha=0
		text6.alpha=0
		text6b.alpha=0
		number3.alpha=.5

		pic2.alpha=1
		text3.alpha=1
		text3b.alpha=1
		text4.alpha=1
		text4b.alpha=1
		number2.alpha=1

		currentSlide=2
	end

end


----Go Forward----

local function goForward()
	if (soundOnOrOff==1) then
		audio.play( buttonSound )
	end

	if (currentSlide==1) then
		pic1a.alpha=0
		pic1b.alpha=0
		text1.alpha=0
		text1b.alpha=0
		text2.alpha=0
		text2b.alpha=0
		number1.alpha=.5

		pic2.alpha=1
		text3.alpha=1
		text3b.alpha=1
		text4.alpha=1
		text4b.alpha=1
		number2.alpha=1

		currentSlide=2
	elseif (currentSlide==2) then
		pic2.alpha=0
		text3.alpha=0
		text3b.alpha=0
		text4.alpha=0
		text4b.alpha=0
		number2.alpha=.5

		pic3.alpha=1
		text5.alpha=1
		text5b.alpha=1
		text6.alpha=1
		text6b.alpha=1
		number3.alpha=1

		currentSlide=3
	elseif (currentSlide==3) then
		goToMainMenu()
	end

end

----enableButtons function----

local function enableButtons()
	backButton:addEventListener("tap",goBack)
	forwardButton:addEventListener("tap",goForward)
end













-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen


	-- Set up display groups
	backGroup=display.newGroup()
	mainGroup=display.newGroup()

	sceneGroup:insert( backGroup )
	sceneGroup:insert( mainGroup )


	----Orange Tile Background----
	for i=0,6 do
		for a=0,5 do
			local orangeTile= display.newImageRect(objectSheet,2,192,192)
			orangeTile.x=(48+144*a)
			orangeTile.y=(96+144*i)
			backGroup:insert(orangeTile)
		end
	end

	----Heading----

	textBlock = display.newRect(mainGroup,384,100,768,200)
	textBlock:setFillColor(1,.17777,0)
	textBlock.alpha=.8

	howToPlayText = display.newText( mainGroup, "HOW TO PLAY" , 384, 150, native.systemFont, 70 )

	circleMask=graphics.newMask( "circleMask.png" )

	backButton = display.newImageRect( objectSheet, 15, 100, 100 )
	backButton.x=150
	backButton.y=255
	mainGroup:insert(backButton)
	backButton:setMask(circleMask)
	backButton.maskScaleX = .8
	backButton.maskScaleY = .8

	forwardButton = display.newImageRect( objectSheet, 15, 100, 100 )
	forwardButton.x=618
	forwardButton.y=255
	forwardButton.rotation = 180
	mainGroup:insert(forwardButton)
	forwardButton:setMask(circleMask)
	forwardButton.maskScaleX = .8
	forwardButton.maskScaleY = .8


	----Pictures----

	currentSlide=1


	pic1a=display.newImage( "game0ptPic.png" )
	pic1a.x=259
	pic1a.y=640
	pic1a.width=235
	pic1a.height=pic1a.width*1.4186
	mainGroup:insert(pic1a)
	pic1a.alpha=1

	pic1b=display.newImage( "game1ptPic.png" )
	pic1b.x=509
	pic1b.y=640
	pic1b.width=235
	pic1b.height=pic1b.width*1.4186
	mainGroup:insert(pic1b)
	pic1b.alpha=1

	pic2=display.newImage( "game5ptPic.png" )
	pic2.x=384
	pic2.y=640
	pic2.width=235
	pic2.height=pic2.width*1.4186
	mainGroup:insert(pic2)
	pic2.alpha=0

	pic3=display.newImage( "charactersPic.png" )
	pic3.x=384
	pic3.y=640
	pic3.width=235
	pic3.height=pic3.width*1.4186
	mainGroup:insert(pic3)
	pic3.alpha=0

	----Texts----

	text1 = display.newText( mainGroup, "Tap the screen to change lanes in" , 384, 359, native.systemFont, 30 )
	text1b = display.newText( mainGroup, "the direction of the Orange Bar." , 384, 389, native.systemFont, 30 )
	text1.alpha=1
	text1b.alpha=1

	text2 = display.newText( mainGroup, "Increase your score by crossing all" , 384, 911, native.systemFont, 30 )
	text2b = display.newText( mainGroup, "four currents to the other side!" , 384, 941, native.systemFont, 30 )
	text2.alpha=1
	text2b.alpha=1

	text3 = display.newText( mainGroup, "Avoid Red Obstacles and" , 384, 359, native.systemFont, 30 )
	text3b = display.newText( mainGroup, "the ends of the screen." , 384, 389, native.systemFont, 30 )
	text3.alpha=0
	text3b.alpha=0

	text4 = display.newText( mainGroup, "The speed of the Currents" , 384, 911, native.systemFont, 30 )
	text4b = display.newText( mainGroup, "increases every 5 crossings!" , 384, 941, native.systemFont, 30 )
	text4.alpha=0
	text4b.alpha=0

	text5 = display.newText( mainGroup, "Collect Gold Nuggets" , 384, 359, native.systemFont, 30 )
	text5b = display.newText( mainGroup, "floating down the Currents." , 384, 389, native.systemFont, 30 )
	text5.alpha=0
	text5b.alpha=0

	text6 = display.newText( mainGroup, "Exchange Gold Nuggets" , 384, 911, native.systemFont, 30 )
	text6b = display.newText( mainGroup, "for new Characters!" , 384, 941, native.systemFont, 30 )
	text6.alpha=0
	text6b.alpha=0

	----Numbers----

	number1=display.newText( mainGroup, "1" , 284, 255, native.systemFont, 75 )
	number1.alpha=1

	number2=display.newText( mainGroup, "2" , 384, 255, native.systemFont, 75 )
	number2.alpha=.5

	number3=display.newText( mainGroup, "3" , 484, 255, native.systemFont, 75 )
	number3.alpha=.5


end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

		----Add Event Listeners----
    enableButtons()

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

		----Remove Sounds----
    audio.dispose( buttonSound )

		----Remove Event Listeners----
		backButton:removeEventListener("tap",goBack)
		forwardButton:removeEventListener("tap", goForward)

		----Delete Scene----
    composer.removeScene( "howToPlay" )

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
