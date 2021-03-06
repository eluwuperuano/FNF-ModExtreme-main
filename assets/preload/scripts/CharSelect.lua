---- CONFIG
-- You can edit aspects about the script below

local showSongBF = true -- Whether the chart's BF should be shown as an option, disabling might be useful if you manually registered them and the chart's BF shows wrong

local allowStoryMode = false -- If this script can be used on storymode or not
local song = 'offsetSong'; --If you want to have a song play while people are in this menu. Remove this line entirely if you don't want one.
local characterList = { -- The list of characters
	{
		name = "bf",
		displayName = "Boyfriend",
	},
	{
        name = "bf-car",
        displayName = "Windy Boyfriend"
    },
    {
        name = "bf-christmas",
        displayName = "Festive Boyfriend"
    },
    {
        name = "bf-pixel",
        displayName = "Pixel Boyfriend"
    },
    {
        name = "pico-player",
        displayName = "pico"
    },
    {
        name = "bf-faker",
        displayName = "faker"
    },
    {
        name = "sonic",
        displayName = "sonic"
    },
    {
        name = "bf_neo",
        displayName = "bf neo"
    },
    {
        name = "bf-scared_neo",
        displayName = "sacer bf neo"
    },
    {
        name = "bf-car_neo",
        displayName = "bf car neo"
    },
    {
        name = "bf_b",
        displayName = "bf remix"
    },
    {
        name = "bf-car_b",
        displayName = "bf car remix"
    },
    {
        name = "bf-christmas_b",
        displayName = "bf festival remix"
    },
    {
        name = "bf-pixel_b",
        displayName = "bf pixel remix"
    },
    {
        name = "pico-player_b",
        displayName = "pico player remix"
    },
    {
        name = "bf_D",
        displayName = "bf D-side"
    },
    {
        name = "bf_D-dark",
        displayName = "bf D-side dark"
    },
    {
        name = "bf-car_D",
        displayName = "bf D-side car"
    },
    {
        name = "bf-car_D-dark",
        displayName = "bf D-side car dark"
    }
}


-- The actual script.

local changedChar = true
local isOnCharMenu = true;
local curCharacter = 1
local shownID = -10000
local befPaused = false
local displayNameY = 0;
local origBF = "";

function onCreate()
			if getPropertyFromClass('ClientPrefs', 'charSelect', true) then
	--Theres nothing special here just all the extra stuff. Add or edit whatever you want.
	makeLuaSprite('charStage', 'charselectassets/charselectstage', 0, 0);
	setObjectCamera('charStage', 'camOther');
	scaleObject('charStage', 0.55, 0.55);
	screenCenter('charStage', 'xy');
	
	makeAnimatedLuaSprite('leftarrow', 'campaign_menu_UI_assets', 400, 0);
	addAnimationByPrefix('leftarrow', 'leftpressed', 'arrow left0', 24, false);
	addAnimationByPrefix('leftarrow', 'leftunpressed', 'arrow push left0', 24, false);
	objectPlayAnimation('leftarrow', 'leftunpressed', true);
	screenCenter('leftarrow', 'y');
	setObjectCamera('leftarrow', 'camOther');
	
	makeAnimatedLuaSprite('rightarrow', 'campaign_menu_UI_assets', 800, 0);
	addAnimationByPrefix('rightarrow', 'rightpressed', 'arrow right0', 24, false);
	addAnimationByPrefix('rightarrow', 'rightunpressed', 'arrow push right0', 24, false);
	objectPlayAnimation('rightarrow', 'rightunpressed', true);
	screenCenter('rightarrow', 'y');
	setObjectCamera('rightarrow', 'camOther');
	
	makeLuaText('displayname', characterList[curCharacter].displayName, 0, 0, 100);
	setProperty('displayname.borderColor', getColorFromHex('000000'));
	setProperty('displayname.borderSize', 1.2);
	setObjectCamera('displayname', 'camOther');
	setTextSize('displayname', 25);
	screenCenter('displayname', 'x');
	displayNameY = getProperty("displayname.y")
	addLuaText('displayname');
	
	addLuaSprite('charStage', false);
	addLuaSprite('leftarrow', true); --i will fix it just wait --Luis
	addLuaSprite('rightarrow', true);
	
	playMusic(song, 1, true);
end

function onStartCountdown()
			if getPropertyFromClass('ClientPrefs', 'charSelect', true) then
	if(not allowStoryMode and isStoryMode)then close() end -- Close script if in story mode, remove this or n

	if not hasSelectedCharacter then
		origBF = getProperty("boyfriend.curCharacter")
		if(showSongBF) then table.insert(characterList,1,{
			name=origBF,
			displayName="Character from Chart"}) 
		end
		setProperty('inCutscene', true);
		setProperty('boyfriend.stunned', true);
		-- hasSelectedCharacter = true
		updateCharacter()
		setProperty('canPause', true);
		befPaused = getProperty('canPause')
		return Function_Stop;
	end
	setProperty('canPause', befPaused);
	if changedChar then
		characterPlayAnim('boyfriend', 'idle', true);

		if(characterList[curCharacter].opponent) then
			triggerEvent('Change Character', 'dad', characterList[curCharacter].opponent);
		end
	end
	setProperty('inCutscene', false);
	setObjectCamera('boyfriend', 'camGame');
	setProperty('boyfriend.stunned', false);
	setProperty('boyfriend.x', defaultBoyfriendX);
	setProperty('boyfriend.y', defaultBoyfriendY+360);
	removeLuaSprite('charStage', true);
	removeLuaSprite('leftarrow', true);
	removeLuaSprite('rightarrow', true);
	removeLuaText('displayname', true);
	setProperty('misses', 0);
	pauseSound("music")
	
	playMusic(song, 0, false); --I don't know how to stop music there's nothing in the wiki or source its all just for sounds.
	return Function_Continue;
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'wait' then
		startCountdown()
	end
end
end

function onPause()
			if getPropertyFromClass('ClientPrefs', 'charSelect', true) then
	if(isOnCharMenu) then
		triggerEvent('Change Character', 'bf', origBF);
		isOnCharMenu = false
	end
	return Function_Continue;
	end
end

function onUpdate()
			if getPropertyFromClass('ClientPrefs', 'charSelect', true) then
	if isOnCharMenu == true then
		setProperty('boyfriend.stunned', true);
		screenCenter('displayname', 'x');
		screenCenter('boyfriend', 'xy');
		if characterList[curCharacter].y then
			setProperty("boyfriend.y",getProperty("boyfriend.y") + characterList[curCharacter].y)
		end
		if characterList[curCharacter].x then
			setProperty("boyfriend.x",getProperty("boyfriend.x") + characterList[curCharacter].x)
		end
		scaleObject('boyfriend', getProperty('boyfriend.jsonScale'), getProperty('boyfriend.jsonScale'));
		if(shownID ~= curCharacter) then -- Only change the character if needed
			updateCharacter()
		end
		if keyJustPressed('left') then
			curCharacter = curCharacter - 1
			playSound('scrollMenu', 1);
		elseif keyJustPressed('right') then
			curCharacter = curCharacter + 1
			playSound('scrollMenu', 1);
		elseif keyJustPressed('accept') then
			characterPlayAnim('boyfriend', 'hey', false);
			hasSelectedCharacter = true
			runTimer('wait', 1.8, 1);
			playSound('confirmMenu', 1);
			isOnCharMenu = false
		elseif keyJustPressed('back') then
			-- playSound('confirmMenu', 1);
			triggerEvent('Change Character', 'bf', origBF);
			isOnCharMenu = false
			hasSelectedCharacter = true
			changedChar = false
			startCountdown();
		end
		
		if keyPressed('left') then
			objectPlayAnimation('leftarrow', 'leftpressed', true);
		elseif keyPressed('right') then
			objectPlayAnimation('rightarrow', 'rightpressed', true);
		end
		
		if keyReleased('left') then
			objectPlayAnimation('leftarrow', 'leftunpressed', true);
		elseif keyReleased('right') then
			objectPlayAnimation('rightarrow', 'rightunpressed', true);
		end
		
		if curCharacter > #characterList then
			curCharacter = 1
		elseif curCharacter <= 0 then
			curCharacter = #characterList
		end
	end
	end
end

function updateCharacter()
			if getPropertyFromClass('ClientPrefs', 'charSelect', true) then
	triggerEvent('Change Character', 'bf', characterList[curCharacter].name);
	setTextString('displayname', characterList[curCharacter].displayName);

	setObjectCamera('boyfriend', 'camOther');
	characterPlayAnim('boyfriend', 'idle', true);
	shownID = curCharacter


	if characterList[curCharacter].displayNameY then
		-- scaleObject('boyfriend', 0.9, 0.9);
		setProperty('displayname.y', displayNameY-characterList[curCharacter].displayNameY); -- Inverted for easier editing
	else
		setProperty('displayname.y', displayNameY);
	end
	end
end


function onStartStart()
	isOnCharMenu = false
end




-- Credits:


-- XpsxExp#4452: Making the script

-- Superpowers04#3887: Reformatting the script and making it cleaner and such
