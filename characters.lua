
local composer = require( "composer" )

local scene = composer.newScene()

--local appodeal = require( "plugin.appodeal" )
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------


----Sounds----

local buttonSound = audio.loadSound( "multimedia_button_click_015.mp3" )
local registerSound = audio.loadSound("Blastwave_FX_CashRegister_S08IN.92.mp3")


----Encoding/Decoding----

local json = require( "json" )

--High Score--
local highScore
local filePath = system.pathForFile( "score.json", system.DocumentsDirectory )

local file = io.open( filePath, "r" )
if file then
	local contents = file:read( "*a" )
	io.close( file )
	highScore = json.decode( contents )
end
if ( highScore == nil or highScore == 0 ) then
	highScore=0
end

--Gold--

local totalGold
local filePath2 = system.pathForFile( "gold.json", system.DocumentsDirectory )

local file2 = io.open( filePath2, "r" )
if file2 then
	local contents2 = file2:read( "*a" )
	io.close( file2 )
	totalGold = json.decode( contents2 )
end
if ( totalGold == nil ) then
	totalGold=0
end

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
if ( soundOnOrOff == nil) then
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

--Game Center Character Check--
local gameNetwork = require( "gameNetwork" )
local loggedIntoGC = composer.getVariable("loggedIntoGC")

local function requestCallback(event)

	if(event.data[2].isCompleted )then
		unlockedTable[2]=1
	end
	if(event.data[3].isCompleted )then
		unlockedTable[3]=1
	end
	if(event.data[4].isCompleted )then
		unlockedTable[4]=1
	end
	if(event.data[5].isCompleted )then
		unlockedTable[5]=1
	end
	if(event.data[6].isCompleted )then
		unlockedTable[6]=1
	end
	if(event.data[7].isCompleted )then
		unlockedTable[7]=1
	end
	if(event.data[8].isCompleted )then
		unlockedTable[8]=1
	end
	if(event.data[9].isCompleted )then
		unlockedTable[9]=1
	end
	if(event.data[10].isCompleted )then
		unlockedTable[10]=1
	end
	if(event.data[11].isCompleted )then
		unlockedTable[11]=1
	end
	if(event.data[12].isCompleted )then
		unlockedTable[12]=1
	end
	if(event.data[13].isCompleted )then
		unlockedTable[13]=1
	end
	if(event.data[14].isCompleted )then
		unlockedTable[14]=1
	end
	if(event.data[15].isCompleted )then
		unlockedTable[15]=1
	end
	if(event.data[16].isCompleted )then
		unlockedTable[16]=1
	end

	saveunlockedTable()

end


if (loggedIntoGC==1) then
	gameNetwork.request( "loadAchievements", { listener=requestCallback } )
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
local charactersText
local goldText
local goldSymbol
local goldWidth
local halfWidth
local circleMask
local backButton

local blocksTable = {}
local highlight

local origGroupY
local origEventY

----LEVELS----

local backGroup
local mainGroup
local tapCanvas
local frontGroup


--------GAME FUNCTIONS--------

----Go To Main Menu----

local function goToMainMenu(event)
	local phase = event.phase

	if ( "began" == phase ) then
			-- Set touch focus on backButton
			display.currentStage:setFocus( backButton )
	elseif ( "ended" == phase or "cancelled" == phase ) then

			if(event.x>100 and event.x<200 and event.y>205 and event.y<305) then
				if (soundOnOrOff==1) then
					audio.play( buttonSound )
				end
				composer.gotoScene( "mainMenu")
			end
     	-- Release touch focus on backButton
	    display.currentStage:setFocus( nil )
	end
	return true
end

----Drag Main Group----

local function dragMainGroup(event)

	local tapCanvas=event.target
	local phase = event.phase

	if ( "began" == phase ) then
        -- Set touch focus on tapCanvas
        display.currentStage:setFocus( tapCanvas )

				-- Store initial offset position
        --mainGroup.touchOffsetY = event.y - mainGroup.y

				origGroupY = mainGroup.y
				origEventY = event.y
	elseif ( "moved" == phase ) then
        -- Move the mainGroup the amount of the drag
				if (mainGroup.y>-2250 and mainGroup.y<10) then
        	--mainGroup.y = (event.y - mainGroup.touchOffsetY)
					mainGroup.y = origGroupY+(event.y-origEventY)*1.5
				end
	elseif ( "ended" == phase or "cancelled" == phase ) then

				if (mainGroup.y<=-2250) then
					mainGroup.y=-2248
				elseif (mainGroup.y>=10) then
					mainGroup.y=9
				end

	      -- Release touch focus on tapCanvas
	      display.currentStage:setFocus( nil )
	end

end







----Set Up Character Buttons----

local function setupCharButtons()

	for i=1,#unlockedTable,1  do

		local isUnlocked = unlockedTable[i]
		local cost = costTable[i]
		local designInd = designTable[i]

		if (isUnlocked == 0) then
			local costInd

			if (cost==10) then
				costInd=16
			elseif (cost==20) then
				costInd=17
			elseif (cost==50) then
				costInd=18
			elseif (cost==100) then
				costInd=19
			elseif (cost==200) then
				costInd=20
			elseif (cost==300) then
				costInd=21
			end

			local newBlock = display.newImageRect( objectSheet, costInd, 252, 150 )
			table.insert( blocksTable, newBlock )
			newBlock.x=384
			newBlock.y=300+((i-1)*newBlock.height*1.25)
			mainGroup:insert(newBlock)


		else
			local newBlock = display.newImageRect( objectSheet, 23, 252, 150 )
			table.insert( blocksTable, newBlock )
			newBlock.x=384
			newBlock.y=300+((i-1)*newBlock.height*1.25)
			mainGroup:insert(newBlock)

			local charImage = display.newImageRect( objectSheet, designInd, 75, 75 )
			charImage.x=newBlock.x
			charImage.y=newBlock.y
			mainGroup:insert(charImage)

		end

	end

	highlight = display.newImageRect( objectSheet, 24, 252, 150 )
	highlight.x=384
	highlight.y=300+((charInUse-1)*150*1.25)
	mainGroup:insert(highlight)

end


----Select Block Function----

local function selectBlock(event)
	local thisBlock=event.target
	local storeX=thisBlock.x
	local storeY=thisBlock.y

	for i=1,#blocksTable,1 do
    if ( blocksTable[i] == thisBlock) then
			if(unlockedTable[i]==0) then
				local cost = costTable[i]
				local designInd = designTable[i]

				if(totalGold>=cost) then

					unlockedTable[i]=1
					charInUse=i
					totalGold=totalGold-cost

					saveunlockedTable()
					saveCharInUse()
					saveGold()



					thisBlock = display.newImageRect( objectSheet, 23, 252, 150 )
					mainGroup:insert(thisBlock)
					thisBlock.x=storeX
					thisBlock.y=storeY

					local charImage = display.newImageRect( objectSheet, designInd, 75, 75 )
					charImage.x=thisBlock.x
					charImage.y=thisBlock.y
					mainGroup:insert(charImage)

					mainGroup:insert(highlight)
					highlight.y=storeY
					if (soundOnOrOff==1) then
				    audio.play( registerSound )
				  end

					goldText.text=totalGold

					goldWidth=goldText.width
			  	halfWidth=(goldWidth+goldSymbol.width)/2
			  	goldSymbol.x=384-(halfWidth-.5*goldSymbol.width+5)
			  	goldText.x=384+(halfWidth-.5*goldText.width+5)

				end

			else
				charInUse=i
				saveCharInUse()

				mainGroup:insert(highlight)
				highlight.y=storeY
				highlight.x=storeX
				if (soundOnOrOff==1) then
			    audio.play( buttonSound )
			  end
			end

    	break
    end
  end
end

----enableButtons function----

local function enableButtons()
	backButton:addEventListener("touch",goToMainMenu)
	tapCanvas:addEventListener("touch",dragMainGroup)

	for i=1,#blocksTable,1  do
		local thisBlock = blocksTable[i]
		thisBlock:addEventListener("tap",selectBlock)
	end
end


local function fakeCallback()


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
	tapCanvas=display.newRect(384,512,768,1024)
	frontGroup=display.newGroup()

	sceneGroup:insert( backGroup )
	sceneGroup:insert( mainGroup )
	sceneGroup:insert( tapCanvas )
	sceneGroup:insert( frontGroup )

	tapCanvas:setFillColor(1,1,1,.005)

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

	textBlock = display.newRect(frontGroup,384,100,768,200)
	textBlock:setFillColor(1,.17777,0)
	textBlock.alpha=.8

	charactersText = display.newText( frontGroup, "CHARACTERS" , 384, 100+32, native.systemFont, 65 )

	goldText = display.newText( frontGroup, totalGold, 384, 150+28, native.systemFont, 40 )
	goldText:setFillColor(1,.7529,.0784)

	goldSymbol = display.newImageRect( objectSheet, 6, 35, 35 )
	goldSymbol.x=384
	goldSymbol.y=150+28
	frontGroup:insert(goldSymbol)

  goldWidth=goldText.width
  halfWidth=(goldWidth+goldSymbol.width)/2
  goldSymbol.x=384-(halfWidth-.5*goldSymbol.width+5)
  goldText.x=384+(halfWidth-.5*goldText.width+5)

	circleMask=graphics.newMask( "circleMask.png" )

	backButton = display.newImageRect( objectSheet, 15, 100, 100 )
	backButton.x=150
	backButton.y=255
	frontGroup:insert(backButton)
	backButton:setMask(circleMask)
	backButton.maskScaleX = .8
	backButton.maskScaleY = .8


	----Character Buttons----
	setupCharButtons()

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

		saveGold()
		saveunlockedTable()
		saveCharInUse()

		--Save Characters to Game Center

	 if(loggedIntoGC==1) then

		if (unlockedTable[1]==1) then
			gameNetwork.request( "unlockAchievement", {achievement = {identifier="com.danielMichaels.currentCrosser.char1"}, listener=fakeCallback})
		end
		if (unlockedTable[2]==1) then
			gameNetwork.request( "unlockAchievement", {achievement = {identifier="com.danielMichaels.currentCrosser.char2"}, listener=fakeCallback})
		end
		if (unlockedTable[3]==1) then
			gameNetwork.request( "unlockAchievement", {achievement = {identifier="com.danielMichaels.currentCrosser.char3"}, listener=fakeCallback})
		end
		if (unlockedTable[4]==1) then
			gameNetwork.request( "unlockAchievement", {achievement = {identifier="com.danielMichaels.currentCrosser.char4"}, listener=fakeCallback})
		end
		if (unlockedTable[5]==1) then
			gameNetwork.request( "unlockAchievement", {achievement = {identifier="com.danielMichaels.currentCrosser.char5"}, listener=fakeCallback})
		end
		if (unlockedTable[6]==1) then
			gameNetwork.request( "unlockAchievement", {achievement = {identifier="com.danielMichaels.currentCrosser.char6"}, listener=fakeCallback})
		end
		if (unlockedTable[7]==1) then
			gameNetwork.request( "unlockAchievement", {achievement = {identifier="com.danielMichaels.currentCrosser.char7"}, listener=fakeCallback})
		end
		if (unlockedTable[8]==1) then
			gameNetwork.request( "unlockAchievement", {achievement = {identifier="com.danielMichaels.currentCrosser.char8"}, listener=fakeCallback})
		end
		if (unlockedTable[9]==1) then
			gameNetwork.request( "unlockAchievement", {achievement = {identifier="com.danielMichaels.currentCrosser.char9"}, listener=fakeCallback})
		end
		if (unlockedTable[10]==1) then
			gameNetwork.request( "unlockAchievement", {achievement = {identifier="com.danielMichaels.currentCrosser.char10"}, listener=fakeCallback})
		end
		if (unlockedTable[11]==1) then
			gameNetwork.request( "unlockAchievement", {achievement = {identifier="com.danielMichaels.currentCrosser.char11"}, listener=fakeCallback})
		end
		if (unlockedTable[12]==1) then
			gameNetwork.request( "unlockAchievement", {achievement = {identifier="com.danielMichaels.currentCrosser.char12"}, listener=fakeCallback})
		end
		if (unlockedTable[13]==1) then
			gameNetwork.request( "unlockAchievement", {achievement = {identifier="com.danielMichaels.currentCrosser.char13"}, listener=fakeCallback})
		end
		if (unlockedTable[14]==1) then
			gameNetwork.request( "unlockAchievement", {achievement = {identifier="com.danielMichaels.currentCrosser.char14"}, listener=fakeCallback})
		end
		if (unlockedTable[15]==1) then
			gameNetwork.request( "unlockAchievement", {achievement = {identifier="com.danielMichaels.currentCrosser.char15"}, listener=fakeCallback})
		end
		if (unlockedTable[16]==1) then
			gameNetwork.request( "unlockAchievement", {achievement = {identifier="com.danielMichaels.currentCrosser.char16"}, listener=fakeCallback})
		end
	 end

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen


		----Remove Event Listeners----
		backButton:removeEventListener("touch",goToMainMenu)

		----Remove Sounds----
    audio.dispose( buttonSound )
		audio.dispose( registerSound )

		----Delete Scene----
    composer.removeScene( "characters" )

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
