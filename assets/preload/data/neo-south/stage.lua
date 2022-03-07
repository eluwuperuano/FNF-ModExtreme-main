function onCreate()
	makeAnimatedLuaSprite('stageBoppers','week2NEO/stuff_3', -100, 700);
	setLuaSpriteScrollFactor('stageBoppers', 1.1, 1.1);
	addAnimationByPrefix('stageBoppers', 'idle', 'Crowd', 24, true); 
	scaleObject('stageBoppers', 1.1, 1.1);
	addLuaSprite('stageBoppers', true);
end