
local composer = require( "composer" )

local scene = composer.newScene()

local appodeal
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

----Sounds----
audio.setMaxVolume( .8 )
local buttonSound = audio.loadSound( "multimedia_button_click_015.mp3" )
local playSound = audio.loadSound( "cartoon_spring_bounce_twang_002.mp3" )
local openingSound = audio.loadSound( "comedy_marimba_ascend_003.mp3" )


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

local function saveScore()
  local file = io.open( filePath, "w" )

  if file then
      file:write( json.encode( highScore ) )
      io.close( file )
  end
end

  --Gold--
local collectedGold=0
local totalGold
local filePath2 = system.pathForFile( "gold.json", system.DocumentsDirectory )

local file2 = io.open( filePath2, "r" )
if file2 then
  local contents2 = file2:read( "*a" )
  io.close( file2 )
  totalGold = json.decode( contents2 )
end
if ( totalGold == nil or totalGold == 0 ) then
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
if ( soundOnOrOff == nil or soundOnOrOff == 1 ) then
  soundOnOrOff=1
end

local function saveSoundOnOrOff()
  local file3 = io.open( filePath3, "w" )

  if file3 then
      file3:write( json.encode( soundOnOrOff ) )
      io.close( file3 )
  end
end

--New Player--
local newPlayer
local filePath4 = system.pathForFile( "newPlayer.json", system.DocumentsDirectory )

local file4 = io.open( filePath4, "r" )
if file4 then
  local contents4 = file4:read( "*a" )
  io.close( file4 )
  newPlayer = json.decode( contents4 )
end
if ( newPlayer == nil or newPlayer == 0 ) then
  newPlayer=0
end

local function saveNewPlayer()
  local file4 = io.open( filePath4, "w" )

  if file4 then
    file4:write( json.encode( newPlayer ) )
    io.close( file4 )
  end
end

--Which Characters are Unlocked--

local unlockedTable = {}

local filePath5 = system.pathForFile( "unlockedTable.json", system.DocumentsDirectory )
local file5 = io.open( filePath5, "r" )

if file5 then
    local contents5 = file5:read( "*a" )
    io.close( file5 )
    unlockedTable = json.decode( contents5 )
end

if ( unlockedTable == nil or #unlockedTable == 0) then
    unlockedTable = { 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
end

--Cost of Each Character--

local costTable = { 0, 10,10,10,10,10,10, 20, 50,50, 100,100,100,100, 200, 300 }

--Ads Removed--

local adsRemoved
local filePath6 = system.pathForFile( "adsRemoved.json", system.DocumentsDirectory )

local file6 = io.open( filePath6, "r" )
if file6 then
  local contents6 = file6:read( "*a" )
  io.close( file6 )
  adsRemoved = json.decode( contents6 )
end
if ( adsRemoved == nil or adsRemoved == 0 ) then
  adsRemoved=0
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

local orangeRail1
local orangeRail2
local orangeRail3
local orangeRail4
local orangeRail5
local orangeRail6
local orangeRail7
local grayRail1
local grayRail2
local grayRail3
local grayRail4
local grayRail5
local grayRail6
local grayRail7
local orangeSiding1
local graySiding1
local railShadow1
local railShadow2

local downCurrents1
local downCurrents2
local downCurrents3
local upCurrents1
local upCurrents2
local upCurrents3

----LEVELS----

local whiteWall
local scoreGroup
local arrowGroup
local railGroup
local mainGroup
local uiGroup

----Intermediate Texts----

local hsBlock
--local hsBlock2
local highScoreText
local goldText
local goldSymbol
local currentCrosserText1
local currentCrosserText2

local playButton
local circleMask
local soundOffButton
local soundOnButton
local charactersButton
local howToPlayButton
local rateButton
local goldButton
local adsButton

local goldWidth
local halfWidth




--------GAME FUNCTIONS--------

----Reset Down Current----
local function resetDownCurrent()
    downCurrents3.y=-1160
    transition.to(downCurrents3,{y=1024, time=8000, iterations=-1})
end

----Reset Up Current
local function resetUpCurrent()
    upCurrents3.y=1092
    transition.to(upCurrents3,{y=-1092, time=8000, iterations=-1})
end


----Reset Current 3
local function resetCurrent3()

  downCurrents3.y=-1160
  transition.to(downCurrents3,{y=1024, time=8000})
  upCurrents3.y=1092
  transition.to(upCurrents3,{y=-1092, time=8000})

end
----Reset Current 1
local function resetCurrent1()
  downCurrents1.y=-1160
  transition.to(downCurrents1,{y=1024, time=8000,iterations=-1})
  upCurrents1.y=1092
  transition.to(upCurrents1,{y=-1092, time=8000,iterations=-1})

  --arrowTimer2=timer.performWithDelay(4000,resetCurrent3)
end


----Switch Sound Function----

local function switchSound()
  if(soundOnOrOff==0) then
    soundOffButton:removeEventListener("tap",switchSound)
    soundOffButton.alpha=0
    soundOnOrOff=1
    saveSoundOnOrOff()
    soundOnButton.alpha=1
    soundOnButton:addEventListener("tap",switchSound)
  else
    soundOnButton:removeEventListener("tap",switchSound)
    soundOnButton.alpha=0
    soundOnOrOff=0
    saveSoundOnOrOff()
    soundOffButton.alpha=1
    soundOffButton:addEventListener("tap",switchSound)
  end
end

----Go To Game----

local function goToGame()
  if (soundOnOrOff==1) then
    audio.play( playSound )
  end
  if(composer.getVariable( "adConnection")==1 and adsRemoved==0) then
    appodeal.hide( "banner" )
  end
  composer.gotoScene( "game" )
end

----Go To Characters Scene----

local function goToCharactersScene()
  if (soundOnOrOff==1) then
    audio.play( buttonSound )
  end
  composer.gotoScene( "characters" )
end

----Go To How To Play Scene----

local function goToHowToPlayScene()
  if (soundOnOrOff==1) then
    audio.play( buttonSound )
  end
  composer.gotoScene( "howToPlay" )
end

----Go To Gold Scene----

local function goToGoldScene()
  if (soundOnOrOff==1) then
    audio.play( buttonSound )
  end
  composer.gotoScene( "gold" )
end

----Go To Ads Scene----

local function goToAdsScene()
  if (soundOnOrOff==1) then
    audio.play( buttonSound )
  end
  composer.gotoScene( "ads" )
end

----Rate Game----

local function rateGame()
  if (soundOnOrOff==1) then
    audio.play( buttonSound )
  end
  local options =
  {
    iOSAppId = "1254117448"
  }
  native.showPopup( "rateApp", options )
end

----enableButtons function----

local function enableButtons()
  playButton:addEventListener( "tap", goToGame )
  charactersButton:addEventListener( "tap", goToCharactersScene )
  howToPlayButton:addEventListener( "tap", goToHowToPlayScene )
  goldButton:addEventListener( "tap", goToGoldScene )
  adsButton:addEventListener("tap", goToAdsScene)
  rateButton:addEventListener("tap", rateGame)
  if(soundOnOrOff==0) then
    soundOffButton:addEventListener("tap",switchSound)
  else
    soundOnButton:addEventListener("tap",switchSound)
  end
end

----Characters Button Animation----
local function scaleDown()
  transition.to(charactersButton,{width=100,height=100,time=500})
end

local function scaleUp()
  transition.to(charactersButton,{width=115,height=115,time=500,onComplete=scaleDown})
end

local function shouldAnimate()

  local key = 0

  for i=1,#unlockedTable,1  do

    local isUnlocked = unlockedTable[i]
    local cost = costTable[i]


    if(isUnlocked==0 and key==0) then
      if(totalGold>=cost) then
        charactersButton.maskScaleX = .92
        charactersButton.maskScaleY = .92
        timer.performWithDelay(1000,scaleUp,-1)
      end
      key=1
    end
  end

end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen


	-- Set up display groups
	whiteWall=display.newRect(384,512,768,1024)
	scoreGroup=display.newGroup()
	arrowGroup=display.newGroup()
	arrowGroup.x=0
	arrowGroup.y=0
	railGroup=display.newGroup()
	railGroup.x=0
	railGroup.y=0
	mainGroup=display.newGroup()
	uiGroup=display.newGroup()

	sceneGroup:insert( whiteWall )
	sceneGroup:insert( scoreGroup )
	sceneGroup:insert( arrowGroup )
	sceneGroup:insert( railGroup )
	sceneGroup:insert( mainGroup )
	sceneGroup:insert( uiGroup )

	----Intermediate Texts----

	hsBlock=display.newRect(uiGroup,384,215,768,432)
	hsBlock:setFillColor(.0666,.6583,.6083)
	hsBlock.alpha=.8

	--hsBlock2=display.newRect(uiGroup,384,639,768,104)
	--hsBlock2:setFillColor(.0666,.6583,.6083)
	--hsBlock2.alpha=1

	highScoreText = display.newText( uiGroup, "High Score: "..highScore, 384, 387, native.systemFont, 40 )
	highScoreText:setFillColor(1,1,1)
	highScoreText.alpha=1

	goldText = display.newText( uiGroup, totalGold, 384, 330, native.systemFont, 40 )
	goldText:setFillColor(1,.7529,.0784)
	goldText.alpha=1

	goldSymbol = display.newImageRect( objectSheet, 6, 40, 40 )
	goldSymbol.x=364
	goldSymbol.y=330
	goldSymbol.alpha=1
	uiGroup:insert(goldSymbol)

  goldWidth=goldText.width
  halfWidth=(goldWidth+goldSymbol.width)/2
  goldSymbol.x=384-(halfWidth-.5*goldSymbol.width+5)
  goldText.x=384+(halfWidth-.5*goldText.width+5)

	currentCrosserText1 = display.newText( uiGroup, "CURRENT", 384, 175, native.systemFont, 100 )
	currentCrosserText1:setFillColor(1,1,1)
	currentCrosserText1.alpha=1
	currentCrosserText2 = display.newText( uiGroup, "CROSSER", 384, 260, native.systemFont, 100 )
	currentCrosserText2:setFillColor(1,1,1)
	currentCrosserText2.alpha=1

	circleMask=graphics.newMask( "circleMask.png" )

	playButton = display.newImageRect( objectSheet, 7, 250, 250 )
	playButton.x=384
	playButton.y=727
	playButton.alpha=1
	uiGroup:insert(playButton)
	playButton:setMask(circleMask)
	playButton.maskScaleX = 2
	playButton.maskScaleY = 2

	soundOffButton = display.newImageRect( objectSheet, 8, 100, 100 )
	soundOffButton.x=170
	soundOffButton.y=513
	soundOffButton.alpha=1
	uiGroup:insert(soundOffButton)
	soundOffButton:setMask(circleMask)
	soundOffButton.maskScaleX = .8
	soundOffButton.maskScaleY = .8

	soundOnButton = display.newImageRect( objectSheet, 9, 100, 100 )
	soundOnButton.x=170
	soundOnButton.y=513
	soundOnButton.alpha=1
	uiGroup:insert(soundOnButton)
	soundOnButton:setMask(circleMask)
	soundOnButton.maskScaleX = .8
	soundOnButton.maskScaleY = .8

  if (soundOnOrOff==0) then
    soundOnButton.alpha=0
    soundOffButton.alpha=1
  else
    soundOnButton.alpha=1
    soundOffButton.alpha=0
  end

	charactersButton = display.newImageRect( objectSheet, 10, 100, 100 )
	charactersButton.x=170
	charactersButton.y=727
	charactersButton.alpha=1
	uiGroup:insert(charactersButton)
	charactersButton:setMask(circleMask)
	charactersButton.maskScaleX = .8
	charactersButton.maskScaleY = .8

	howToPlayButton = display.newImageRect( objectSheet, 11, 100, 100 )
	howToPlayButton.x=170
	howToPlayButton.y=941
	howToPlayButton.alpha=1
	uiGroup:insert(howToPlayButton)
	howToPlayButton:setMask(circleMask)
	howToPlayButton.maskScaleX = .8
	howToPlayButton.maskScaleY = .8

	rateButton = display.newImageRect( objectSheet, 13, 100, 100 )
	rateButton.x=598
	rateButton.y=513
	rateButton.alpha=1
	uiGroup:insert(rateButton)
	rateButton:setMask(circleMask)
	rateButton.maskScaleX = .8
	rateButton.maskScaleY = .8

	goldButton = display.newImageRect( objectSheet, 12, 100, 100 )
	goldButton.x=598
	goldButton.y=727
	goldButton.alpha=1
	uiGroup:insert(goldButton)
	goldButton:setMask(circleMask)
	goldButton.maskScaleX = .8
	goldButton.maskScaleY = .8

	adsButton = display.newImageRect( objectSheet, 14, 100, 100 )
	adsButton.x=598
	adsButton.y=941
	adsButton.alpha=1
	uiGroup:insert(adsButton)
	adsButton:setMask(circleMask)
	adsButton.maskScaleX = .8
	adsButton.maskScaleY = .8

	----RAILS----

	orangeRail1 = display.newImageRect(objectSheet, 1,192,192)
	orangeRail1.x = 48
	orangeRail1.y = 96
	railGroup:insert(orangeRail1)

	orangeRail2 = display.newImageRect(objectSheet, 1,192,192)
	orangeRail2.x = 48
	orangeRail2.y = 240
	railGroup:insert(orangeRail2)

	orangeRail3 = display.newImageRect(objectSheet, 1,192,192)
	orangeRail3.x = 48
	orangeRail3.y = 384
	railGroup:insert(orangeRail3)

	orangeRail4 = display.newImageRect(objectSheet, 1,192,192)
	orangeRail4.x = 48
	orangeRail4.y = 528
	railGroup:insert(orangeRail4)

	orangeRail5 = display.newImageRect(objectSheet, 1,192,192)
	orangeRail5.x = 48
	orangeRail5.y = 672
	railGroup:insert(orangeRail5)

	orangeRail6 = display.newImageRect(objectSheet, 1,192,192)
	orangeRail6.x = 48
	orangeRail6.y = 816
	railGroup:insert(orangeRail6)

	orangeRail7 = display.newImageRect(objectSheet, 1,192,192)
	orangeRail7.x = 48
	orangeRail7.y = 960
	railGroup:insert(orangeRail7)


	grayRail1 = display.newImageRect(objectSheet, 2,192,192)
	grayRail1.x = 720
	grayRail1.y = 96
	railGroup:insert(grayRail1)

	grayRail2 = display.newImageRect(objectSheet, 2,192,192)
	grayRail2.x = 720
	grayRail2.y = 240
	railGroup:insert(grayRail2)

	grayRail3 = display.newImageRect(objectSheet, 2,192,192)
	grayRail3.x = 720
	grayRail3.y = 384
	railGroup:insert(grayRail3)

	grayRail4 = display.newImageRect(objectSheet, 2,192,192)
	grayRail4.x = 720
	grayRail4.y = 528
	railGroup:insert(grayRail4)

	grayRail5 = display.newImageRect(objectSheet, 2,192,192)
	grayRail5.x = 720
	grayRail5.y = 672
	railGroup:insert(grayRail5)

	grayRail6 = display.newImageRect(objectSheet, 2,192,192)
	grayRail6.x = 720
	grayRail6.y = 816
	railGroup:insert(grayRail6)

	grayRail7 = display.newImageRect(objectSheet, 2,192,192)
	grayRail7.x = 720
	grayRail7.y = 960
	railGroup:insert(grayRail7)


	local orangeSiding1=display.newRect(155,512,24,1024)
	orangeSiding1:setFillColor(1,.17777,0,1)
	railGroup:insert(orangeSiding1)

	local graySiding1=display.newRect(613,512,24,1024)
	graySiding1:setFillColor(.3555,.3555,.3555,.92)
	railGroup:insert(graySiding1)


	local railShadow1=display.newRect(170,512,6,1024)
	railShadow1:setFillColor(.5666,.5666,.5666,1)
	railGroup:insert(railShadow1)

	local railShadow2=display.newRect(598,512,6,1024)
	railShadow2:setFillColor(.5666,.5666,.5666,1)
	railGroup:insert(railShadow2)

	railGroup:rotate(180)
	railGroup.x=768
	railGroup.y=1024

	----CURRENT ARROWS----

	downCurrents1 = display.newGroup()
	for i=1,16 do
	  for a=0,1 do
	    local arrow=display.newImageRect(objectSheet, 3,84,84)
	    arrow:translate(a*216,i*84)
	    downCurrents1:insert(arrow)
	  end
	end
	arrowGroup:insert(downCurrents1)
	downCurrents1.x=222
	downCurrents1.y=-68-84

	downCurrents2 = display.newGroup()
	for i=1,13 do
	  for a=0,1 do
	    local arrow=display.newImageRect(objectSheet, 3,84,84)
	    arrow:translate(a*216,i*84)
	    downCurrents2:insert(arrow)
	  end
	end
	arrowGroup:insert(downCurrents2)
	downCurrents2.x=222
	downCurrents2.y=-1160

	downCurrents3 = display.newGroup()
	for i=1,13 do
	  for a=0,1 do
	    local arrow=display.newImageRect(objectSheet, 3,84,84)
	    arrow:translate(a*216,i*84)
	    downCurrents3:insert(arrow)
	  end
	end
	arrowGroup:insert(downCurrents3)
	downCurrents3.x=222
	downCurrents3.y=-1160


	upCurrents1 = display.newGroup()
	for i=0,15 do
	  for a=0,1 do
	    local arrow=display.newImageRect(objectSheet, 3,84,84)
	    arrow:translate(a*-216,i*-84)
	    upCurrents1:insert(arrow)
	  end
	end
	arrowGroup:insert(upCurrents1)
	upCurrents1.x=330
	upCurrents1:rotate(180)

	upCurrents2 = display.newGroup()
	for i=0,12 do
	  for a=0,1 do
	    local arrow=display.newImageRect(objectSheet, 3,84,84)
	    arrow:translate(a*-216,i*-84)
	    upCurrents2:insert(arrow)
	  end
	end
	arrowGroup:insert(upCurrents2)
	upCurrents2.x=330
	upCurrents2:rotate(180)
	upCurrents2.y=1092

	upCurrents3 = display.newGroup()
	for i=0,12 do
	  for a=0,1 do
	    local arrow=display.newImageRect(objectSheet, 3,84,84)
	    arrow:translate(a*-216,i*-84)
	    upCurrents3:insert(arrow)
	  end
	end
	arrowGroup:insert(upCurrents3)
	upCurrents3.x=330
	upCurrents3:rotate(180)
	upCurrents3.y=1092


end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

    --transition.to(downCurrents1,{y=1024, time=4000,onComplete = function() display.remove(downCurrents1) end})
		----transition.to(downCurrents2,{y=1024, time=8000, iterations=-1})
		----transition.to(downCurrents3,{y=1024, time=8000, delay=4000,onComplete=resetDownCurrent})
    --transition.to(downCurrents2,{y=1024, time=8000})
    --transition.to(downCurrents3,{y=1024, time=8000, delay=4000})

    --transition.to(downCurrents1,{y=1024, time=4000,onComplete=resetCurrent1})
    --transition.to(downCurrents2,{y=1024, time=8000,iterations=-1})
    transition.to(downCurrents1,{y=16-84, time=307,iterations=-1})


		--transition.to(upCurrents1,{y=-1092, time=4000,onComplete = function() display.remove(upCurrents1) end})
		----transition.to(upCurrents2,{y=-1092, time=8000, iterations=-1})
		----transition.to(upCurrents3,{y=-1092, time=8000, delay=4000,onComplete=resetUpCurrent})
    --transition.to(upCurrents2,{y=-1092, time=8000})
    --transition.to(upCurrents3,{y=-1092, time=8000, delay=4000})

    --transition.to(upCurrents1,{y=-1092, time=4000})
    --transition.to(upCurrents2,{y=-1092, time=8000,iterations=-1})
    transition.to(upCurrents1,{y=-84, time=307,iterations=-1})

    --arrowTimer1=timer.performWithDelay(8000,resetCurrent2,-1)

    shouldAnimate()

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

    ----Add Event Listeners----
    enableButtons()


    ----Play Opening Sound----
    if(composer.getVariable( "hasBeenOpened")==nil) then
      composer.setVariable( "hasBeenOpened", 1 )
      if(soundOnOrOff==1) then
        audio.play( openingSound )
      end
    end

    ----Check for New Player----
    if(newPlayer==0) then
      newPlayer=1
      saveNewPlayer()
      goToHowToPlayScene()
    end

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

		----Remove Event Listeners----

		playButton:removeEventListener( "tap", goToGame )
    charactersButton:removeEventListener("tap", goToCharactersScene)
    howToPlayButton:removeEventListener("tap", goToHowToPlayScene)
    goldButton:removeEventListener("tap", goToGoldScene)
    adsButton:removeEventListener("tap", goToAdsScene)
    rateButton:removeEventListener("tap", rateGame)
		if(soundOnOrOff==0) then
			soundOffButton:removeEventListener("tap",switchSound)
		else
			soundOnButton:removeEventListener("tap",switchSound)
		end

		----Remove Transitions----
		transition.cancel( downCurrents2 )
		transition.cancel( downCurrents3 )
		transition.cancel( upCurrents2 )
		transition.cancel( upCurrents3)

    ----Remove Sounds----
    audio.dispose( buttonSound )
    audio.dispose( playSound )
    audio.dispose( openingSound )

    ----Delete Scene----
    composer.removeScene( "mainMenu" )

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
