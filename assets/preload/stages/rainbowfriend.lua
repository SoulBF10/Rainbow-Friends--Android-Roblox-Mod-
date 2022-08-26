function onCreate()
	-- background shit
	makeLuaSprite('stageback', 'stageback',-600, -200);
	setLuaSpriteScrollFactor('stageback', 1, 1);
	
	makeLuaSprite('blank', 'blank', -650, 600);
	setLuaSpriteScrollFactor('blank', 0.9, 0.9);
	scaleObject('blank', 1.1, 1.1);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		makeLuaSprite('blank', 'blank', -125, -100);
		setLuaSpriteScrollFactor('blank', 0.9, 0.9);
		scaleObject('blank', 1.1, 1.1);
		
		makeLuaSprite('blank', 'blank', 1225, -100);
		setLuaSpriteScrollFactor('blank', 0.9, 0.9);
		scaleObject('blank', 1.1, 1.1);
		setPropertyLuaSprite('blank', 'flipX', true); --mirror sprite horizontally

		makeLuaSprite('blank', 'blank', -500, -300);
		setLuaSpriteScrollFactor('blank', 1.3, 1.3);
		scaleObject('blank', 0.9, 0.9);
	end

	addLuaSprite('stageback', false);
	addLuaSprite('blank', false);
	addLuaSprite('blank', false);
	addLuaSprite('blank', false);
	addLuaSprite('blank', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end