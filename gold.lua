
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

--Which Characters are Unlocked--

local unlockedTable = {}

local filePath4 = system.pathForFile( "unlockedTable.json", system.DocumentsDirectory )
local file4 = io.open( filePath4, "r" )

if file4 then
    local contents4 = file4:read( "*a" )
    io.close( file4 )
    unlockedTable = json.decode( contents4 )
end

if ( unlockedTable == nil or #unlockedTable == 0) then
    unlockedTable = { 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
end

local function saveunlockedTable()

    local file4 = io.open( filePath4, "w" )

    if file4 then
        file4:write( json.encode( unlockedTable ) )
        io.close( file4 )
    end
end

--Cost of Each Character--
local costTable = { 0, 10,10,10,10,10,10, 20, 50,50, 100,100,100,100, 200, 300 }


--Design Index of Each Character--
local designTable = { 4, 25,26,27,28,29,30, 31, 32,33, 34,35,36,37, 38, 39 }


--Character in Use--

local charInUse
local filePath7 = system.pathForFile( "charInUse.json", system.DocumentsDirectory )

local file7 = io.open( filePath7, "r" )
if file7 then
	local contents7 = file7:read( "*a" )
	io.close( file7 )
	charInUse = json.decode( contents7 )
end
if ( charInUse == nil) then
	charInUse=1
end

local function saveCharInUse()
  local file7 = io.open( filePath7, "w" )

  if file7 then
      file7:write( json.encode( charInUse ) )
      io.close( file7 )
  end
end


--+300 Gold Nuggets Purchased--
local gnIAP300
local filePath8 = system.pathForFile( "gnIAP300.json", system.DocumentsDirectory )

local function seeGnIAP300()

  local file8 = io.open( filePath8, "r" )
  if file8 then
	  local contents8 = file8:read( "*a" )
	  io.close( file8 )
	  gnIAP300 = json.decode( contents8 )
  end
  if ( gnIAP300 == nil ) then
	  gnIAP300=0
  end

end

--+1000 Gold Nuggets Purchased--
local gnIAP1000
local filePath9 = system.pathForFile( "gnIAP1000.json", system.DocumentsDirectory )

local function seeGnIAP1000()

  local file9 = io.open( filePath9, "r" )
  if file9 then
	  local contents9 = file9:read( "*a" )
	  io.close( file9 )
	  gnIAP1000 = json.decode( contents9 )
  end
  if ( gnIAP1000 == nil ) then
	  gnIAP1000=0
  end

end

--Ads Removed--
local adsRemoved
local filePath10 = system.pathForFile( "adsRemoved.json", system.DocumentsDirectory )

local file10 = io.open( filePath10, "r" )
if file10 then
  local contents10 = file10:read( "*a" )
  io.close( file10 )
  adsRemoved = json.decode( contents10 )
end
if ( adsRemoved == nil or adsRemoved == 0 ) then
  adsRemoved=0
end

local function saveAdsRemoved()
	local file10 = io.open( filePath10, "w" )

	if file10 then
			file10:write( json.encode( 1 ) )
			io.close( file10 )
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
local goldTitleText
local goldText
local goldSymbol
local goldWidth
local halfWidth
local circleMask
local backButton

local blocksTable = {}
local block1
local block2
local block3
local block4
local block5
local adBlock

local block1TextA
local block1TextB
local block2TextA
local block2TextB
local block3TextA
local block3TextB
local block4TextA
local block4TextB
local block5TextA
local block5TextB
local iapText
local restoreText

local iapTimer

local block1Gold
local block2Gold

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
		iapText.text="Waiting On Store...Do Not Exit"
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
		seeGold()
		goldText.text=totalGold
		iapText.text="+300 Gold Nuggets Successful. Thank You!"
		iapText.alpha=1
	elseif(state==4) then
		seeGold()
		goldText.text=totalGold
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

	block1 = display.newImageRect( objectSheet, 23, 252, 150 )
	table.insert( blocksTable, block1 )
	block1.x=238
	block1.y=260+(187.5)+65
	mainGroup:insert(block1)
	block1Gold = display.newImageRect( objectSheet, 6, 40, 40 )
	mainGroup:insert(block1Gold)

	block1TextA = display.newText( mainGroup, "+300" , block1.x , block1.y-37, native.systemFont, 50 )
	--block1TextA:setFillColor(1,.7529,.0784)
	block1TextB = display.newText( mainGroup, "$0.99" , block1.x , block1.y+37, native.systemFont, 50 )

	goldW=block1TextA.width
  halfW=(goldW+block1Gold.width)/2
  block1Gold.x=238+(halfW-.5*block1Gold.width+5)
  block1TextA.x=238-(halfW-.5*block1TextA.width+5)
	block1Gold.y=block1TextA.y




	block2 = display.newImageRect( objectSheet, 23, 252, 150 )
	table.insert( blocksTable, block2 )
	block2.x=530
	block2.y=260+(187.5)+65
	mainGroup:insert(block2)
	block2Gold = display.newImageRect( objectSheet, 6, 40, 40 )
	mainGroup:insert(block2Gold)

	block2TextA = display.newText( mainGroup, "+1000" , block2.x , block2.y-37, native.systemFont, 50 )
	--block2TextA:setFillColor(1,.7529,.0784)
	block2TextB = display.newText( mainGroup, "$1.99" , block2.x , block2.y+37, native.systemFont, 50 )

	goldW=block2TextA.width
  halfW=(goldW+block2Gold.width)/2
  block2Gold.x=530+(halfW-.5*block2Gold.width+5)
  block2TextA.x=530-(halfW-.5*block2TextA.width+5)
	block2Gold.y=block2TextA.y


	block4 = display.newImageRect( objectSheet, 23, 550, 150 )
	table.insert( blocksTable, block4 )
	block4.x=384
	block4.y=310+(187.5*2)
	mainGroup:insert(block4)
	block4TextA = display.newText( mainGroup, "RESTORE" , 384 , block4.y-20, native.systemFont, 40 )
	block4TextB = display.newText( mainGroup, "PURCHASES" , 384 , block4.y+20, native.systemFont, 40 )


	iapText = display.newText( mainGroup, "Waiting On Store...Do Not Exit" , 384 , block2.y-135, native.systemFont, 26 )
	iapText.alpha=0

	restoreText = display.newText( mainGroup, "Restore Multiple Times For Multiple Purchases" , 384 , block4.y+135, native.systemFont, 25 )
	restoreText.alpha=0

	----Rejection Changes----
	--Invisible Blocks
	block1.alpha=0
	block1Gold.alpha=0
	block1TextA.alpha=0
	block1TextB.alpha=0

	block2.alpha=0
	block2Gold.alpha=0
	block2TextA.alpha=0
	block2TextB.alpha=0

	--Unlock Characters Button
	block5 = display.newImageRect( objectSheet, 23, 550, 150 )
	table.insert( blocksTable, block5 )
	block5.x=384
	block5.y=260+(187.5)+65
	mainGroup:insert(block5)
	block5TextA = display.newText( mainGroup, "UNLOCK ALL CHARACTERS" , 384 , block5.y-20, native.systemFont, 40 )
	block5TextB = display.newText( mainGroup, "$1.99" , 384 , block5.y+35, native.systemFont, 50 )

	--block4.alpha=0
	--block4TextA.alpha=0
	--block4TextB.alpha=0

	--IAP Statement--
	--local iapStatementText = display.newText( mainGroup, "Gold Purchases Coming Soon!" , 384 , block2.y-135, native.systemFont, 26 )


end

----+300 Gold Nuggets IAP----

local function purchase300GN()

	if (soundOnOrOff==1) then
		audio.play( buttonSound )
	end
	seeGnIAP300()
	if(store.canMakePurchases==true and store.isActive==true and gnIAP300==0) then
		composer.setVariable("iapState",0)
		iapTimer = timer.performWithDelay(50,checkIAPstate,-1)
		store.purchase( "com.currentCrosser.g1" )
	elseif(gnIAP300==1) then
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

----+1000 Gold Nuggets IAP----

local function purchase1000GN()

	if (soundOnOrOff==1) then
		audio.play( buttonSound )
	end
	seeGnIAP1000()
	if(store.canMakePurchases==true and store.isActive==true and gnIAP1000==0) then
		composer.setVariable("iapState",0)
		iapTimer = timer.performWithDelay(50,checkIAPstate,-1)
		store.purchase( "com.currentCrosser.g2" )
	elseif(gnIAP1000==1)then
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

----Purchase Characters function----

local function purchaseCharacters()

	if (soundOnOrOff==1) then
		audio.play( buttonSound )
	end
	if(store.canMakePurchases==true and store.isActive==true) then
		composer.setVariable("iapState",0)
		iapTimer = timer.performWithDelay(50,checkIAPstate,-1)
		store.purchase( "com.currentCrosser.u1" )
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


----enableButtons function----

local function enableButtons()
	backButton:addEventListener("tap",goToMainMenu)
	block1:addEventListener("tap",purchase300GN)
	block2:addEventListener("tap",purchase1000GN)
	block4:addEventListener("tap",restoreIAP)
	block5:addEventListener("tap",purchaseCharacters)
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

	goldTitleText = display.newText( mainGroup, "GOLD" , 384, 100+32, native.systemFont, 65 )

	goldText = display.newText( mainGroup, totalGold, 384, 150+28, native.systemFont, 40 )
	goldText:setFillColor(1,.7529,.0784)

	goldSymbol = display.newImageRect( objectSheet, 6, 35, 35 )
	goldSymbol.x=364
	goldSymbol.y=150+28
	mainGroup:insert(goldSymbol)

  goldWidth=goldText.width
  halfWidth=(goldWidth+goldSymbol.width)/2
  goldSymbol.x=384-(halfWidth-.5*goldSymbol.width+5)
  goldText.x=384+(halfWidth-.5*goldText.width+5)

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
		--saveunlockedTable()
		saveCharInUse()

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen


		----Remove Sounds----
    audio.dispose( buttonSound )

		----Remove Event Listeners----
		backButton:removeEventListener("tap",goToMainMenu)
		block1:removeEventListener("tap",purchase300GN)
		block2:removeEventListener("tap",purchase1000GN)
		block4:removeEventListener("tap",restoreIAP)
		block5:removeEventListener("tap",purchaseCharacters)

		----Delete Scene----
    composer.removeScene( "gold" )

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
