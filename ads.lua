
local composer = require( "composer" )

local scene = composer.newScene()

local appodeal

local store = require( "store" )  -- iOS
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------


----Sounds----
local buttonSound = audio.loadSound( "multimedia_button_click_015.mp3" )


----Encoding/Decoding----

local json = require( "json" )

--Gold--

local totalGold
local filePath2 = system.pathForFile( "gold.json", system.DocumentsDirectory )

local function seeGold()

	local file2 = io.open( filePath2, "r" )
	if file2 then
		local contents2 = file2:read( "*a" )
		io.close( file2 )
		totalGold = json.decode( contents2 )
	end
	if ( totalGold == nil ) then
		totalGold=0
	end

end

seeGold()

local function saveGold()
	local file2 = io.open( filePath2, "w" )

	if file2 then
			file2:write( json.encode( totalGold ) )
			io.close( file2 )
	end
end

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

--Ads Removed--
local adsRemoved
local filePath4 = system.pathForFile( "adsRemoved.json", system.DocumentsDirectory )

local file4 = io.open( filePath4, "r" )
if file4 then
  local contents4 = file4:read( "*a" )
  io.close( file4 )
  adsRemoved = json.decode( contents4 )
end
if ( adsRemoved == nil or adsRemoved == 0 ) then
  adsRemoved=0
end

local function saveAdsRemoved()
	local file4 = io.open( filePath4, "w" )

	if file4 then
			file4:write( json.encode( 1 ) )
			io.close( file4 )
	end
end

if (adsRemoved==0) then
	appodeal = require( "plugin.appodeal" )
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
        {   -- 7) PLAY Button  (+4 pixel frame)
            x = 320,
            y = 320,
            width = 128,
            height = 128
        },
        {   -- 8) Sound OFF Button  (+4 pixel frame)
            x = 576,
            y = 320,
            width = 128,
            height = 128
        },
        {   -- 9) Sound ON Button  (+4 pixel frame)
            x = 832,
            y = 320,
            width = 128,
            height = 128
        },
        {   -- 10) Characters Button  (+4 pixel frame)
            x = 1088,
            y = 320,
            width = 128,
            height = 128
        },
        {   -- 11) How to Play Button  (+4 pixel frame)
            x = 1344,
            y = 320,
            width = 128,
            height = 128
        },
        {   -- 12) Gold Button  (+4 pixel frame)
            x = 320,
            y = 576,
            width = 128,
            height = 128
        },
        {   -- 13) Rate Button  (+4 pixel frame)
            x = 576,
            y = 576,
            width = 128,
            height = 128
        },
        {   -- 14) Ads Button  (+4 pixel frame)
            x = 832,
            y = 576,
            width = 128,
            height = 128
        },
        {   -- 15) Back Button  (+4 pixel frame)
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
local adsText
local circleMask
local backButton

local blocksTable = {}
local block3
local block4
local adBlock

local block3TextA
local block3TextB
local block4TextA
local block4TextB
local iapText
local restoreText

local soundTextA
local soundTextB

local iapTimer



----LEVELS----

local backGroup
local mainGroup


--------GAME FUNCTIONS--------

----Go To Main Menu----

local function goToMainMenu()
	if (soundOnOrOff==1) then
		audio.play( buttonSound )
	end
	composer.gotoScene("mainMenu")
end

----Check IAP State----

local function checkIAPstate()

	local state=composer.getVariable("iapState")

	if(state==0) then
		iapText.text="Waiting on Store...Do Not Exit"
		iapText.alpha=1
	elseif(state==1) then
		iapText.text="Error Occurred"
		iapText.alpha=1
	elseif(state==2) then
		if(adsRemoved==0) then
			appodeal.hide("banner")
		end
		adsRemoved=1
		saveAdsRemoved()
		iapText.text="Ads Removed Successfully. Thank You!"
		iapText.alpha=1
	elseif(state==3) then
		iapText.text="+300 Gold Nuggets Successful. Thank You!"
		iapText.alpha=1
	elseif(state==4) then
		iapText.text="+1000 Gold Nuggets Successful. Thank You!"
		iapText.alpha=1
	elseif(state==5) then
		iapText.text="Purchase Cancelled"
		iapText.alpha=1
	elseif(state==6) then
		iapText.text="Purchase Failed"
		iapText.alpha=1
	elseif(state==7) then
		iapText.text="Store Is Not Active"
		iapText.alpha=1
	elseif(state==8) then
		iapText.text="Product Already Purchased!"
		iapText.alpha=1
	elseif(state==9) then
		iapText.text="Enable Purchases In Settings"
		iapText.alpha=1
	elseif(state==10) then
		iapText.text="Unlock Characters Successful. Thank You!"
		iapText.alpha=1
	end

end

----Remove Ads Purchase----

local function removeAdsPurchase()

	if (soundOnOrOff==1) then
		audio.play( buttonSound )
	end
	if(adsRemoved==0 and store.canMakePurchases==true and store.isActive==true) then
		composer.setVariable("iapState",0)
		iapTimer = timer.performWithDelay(50,checkIAPstate,-1)
		store.purchase( "com.currentCrosser.r1" )
	elseif(adsRemoved==1) then
		--Product Already Purchased
		composer.setVariable("iapState",8)
		iapText.text="Product Already Purchased!"
		iapText.alpha=1
	elseif(store.canMakePurchases==false and store.isActive==true) then
		--Enable Purchases In Settings
		composer.setVariable("iapState",9)
		iapText.text="Enable Purchases In Settings"
		iapText.alpha=1
	else
		--Store Is Not Active
		composer.setVariable("iapState",7)
		iapText.text="Store Is Not Active"
		iapText.alpha=1
	end

end

----Restore Remove Ads Purchase----

local function restoreIAP()

	if (soundOnOrOff==1) then
		audio.play( buttonSound )
	end
	if(store.isActive==true) then
		composer.setVariable("iapState",0)
		iapTimer = timer.performWithDelay(50,checkIAPstate,-1)
		restoreText.alpha=1
		store.restore()
	else
		--Store Is Not Active
		composer.setVariable("iapState",7)
		iapText.text="Store Is Not Active"
		iapText.alpha=1
	end

end

----Set Up Blocks Function----

local function setUpBlocks()

	block3 = display.newImageRect( objectSheet, 23, 550, 150 )
	table.insert( blocksTable, block3 )
	block3.x=384
	block3.y=310+(187.5)
	mainGroup:insert(block3)
	block3TextA = display.newText( mainGroup, "REMOVE ADS" , block3.x , block3.y-25, native.systemFont, 45 )
	block3TextB = display.newText( mainGroup, "$1.99" , block3.x , block3.y+25, native.systemFont, 50 )



	block4 = display.newImageRect( objectSheet, 23, 550, 150 )
	table.insert( blocksTable, block4 )
	block4.x=384
	block4.y=310+(187.5*2)
	mainGroup:insert(block4)
	block4TextA = display.newText( mainGroup, "RESTORE" , 384 , block4.y-20, native.systemFont, 40 )
	block4TextB = display.newText( mainGroup, "PURCHASES" , 384 , block4.y+20, native.systemFont, 40 )


	iapText = display.newText( mainGroup, "Waiting On Store...Do Not Exit" , block3.x , block3.y-135, native.systemFont, 30 )
	iapText.alpha=0

	restoreText = display.newText( mainGroup, "Restore Multiple Times For Multiple Purchases" , block4.x , block4.y+135, native.systemFont, 25 )
	restoreText.alpha=0

	soundTextA = display.newText( mainGroup, "Sound effects obtained from" , 384 , 970, native.systemFont, 25 )
	soundTextB = display.newText( mainGroup, "www.zapsplat.com and Blastwave FX" , 384 , 1000, native.systemFont, 25 )

end


----enableButtons function----

local function enableButtons()
	backButton:addEventListener("tap",goToMainMenu)
	block3:addEventListener("tap",removeAdsPurchase)
	block4:addEventListener("tap",restoreIAP)
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
			local orangeTile= display.newImageRect(objectSheet,1,192,192)
			orangeTile.x=(48+144*a)
			orangeTile.y=(96+144*i)
			backGroup:insert(orangeTile)
		end
	end

	----Heading----

	textBlock = display.newRect(mainGroup,384,100,768,200)
	textBlock:setFillColor(1,.17777,0)
	textBlock.alpha=.8

	adsText = display.newText( mainGroup, "ADS" , 384, 150, native.systemFont, 70 )

	circleMask=graphics.newMask( "circleMask.png" )

	backButton = display.newImageRect( objectSheet, 15, 100, 100 )
	backButton.x=150
	backButton.y=255
	mainGroup:insert(backButton)
	backButton:setMask(circleMask)
	backButton.maskScaleX = .8
	backButton.maskScaleY = .8


	----Blocks----
	setUpBlocks()


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

		----Save Data----

		--saveGold()

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen


		----Remove Sounds----
    audio.dispose( buttonSound )

		----Remove Event Listeners----
		backButton:removeEventListener("tap",goToMainMenu)
		block3:removeEventListener("tap",removeAdsPurchase)
		block4:removeEventListener("tap",restoreIAP)

		----Delete Scene----
    composer.removeScene( "ads" )

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
