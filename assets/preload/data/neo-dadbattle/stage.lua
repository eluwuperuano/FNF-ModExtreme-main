function onCreate()
	makeAnimatedLuaSprite('stageBoppers','week1NEO/stuff_1', -100, 730);
	setLuaSpriteScrollFactor('stageBoppers', 1.1, 1.1);
	addAnimationByPrefix('stageBoppers', 'idle', 'Crowd', 24, true); 
	scaleObject('stageBoppers', 1.1, 1.1);
	addLuaSprite('stageBoppers', true);
end