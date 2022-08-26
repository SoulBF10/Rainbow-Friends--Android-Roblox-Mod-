--actual script
function onCreatePost()
	--the icons
	makeLuaSprite('composer-icon', 'null', -155, 195)
	setObjectCamera('composer-icon', 'hud')
	setProperty('composer-icon.scale.y', 0.85)
	setProperty('composer-icon.scale.x', 0.85)
	addLuaSprite('composer-icon', true)
	setObjectOrder('composer-icon', getObjectOrder('iconP1') + 2)

	--the box
	makeLuaSprite('JukeBox', 'empty', -355, 100)
	makeGraphic('JukeBox', 300, 300, 'ffffff')
	setProperty('JukeBox.alpha', 0.75)
	setProperty('JukeBox.scale.y', 0.65)
	setProperty('JukeBox.scale.x', 1.35)
	setObjectCamera('JukeBox', 'hud')
	addLuaSprite('JukeBox', true)
	setObjectOrder('JukeBox', getObjectOrder('iconP1') + 1)

	--text for the song name
	makeLuaText('JukeBoxSubText', 'Song By: Null', 300, -355, 155)
	setTextFont('JukeBoxSubText', 'PermanentMarker.ttf')
	setTextColor('JukeBoxSubText', '000000')
	setTextBorder('JukeBoxSubText', 1, '000000')
	setTextAlignment('JukeBoxSubText', 'center')
	setObjectCamera('JukeBoxSubText', 'hud')
	setTextSize('JukeBoxSubText', 30)
	addLuaText('JukeBoxSubText')

end

--motion functions
function onSongStart()
	-- Inst and Vocals start playing, songPosition = 0
	doTweenX('MoveInOne', 'JukeBox', 0, 0.2, 'quadIn')
	doTweenX('MoveInTwo', 'JukeBoxSubText', 0, 0.2, 'quadIn')
	doTweenX('MoveInThree', 'JukeBoxSubText2', 0, 0.2, 'quadIn')
	doTweenX('MoveInFour', 'composer-icon', 90, 0.2, 'quadIn')
	doTweenX('MoveInFive', 'composer-icon-alt', 100, 0.2, 'quadIn')
	
	runTimer('JukeBoxWait', 3, 1)
end

function onTimerCompleted(tag, loops, loopsLeft)
	-- A loop from a timer you called has been completed, value "tag" is it's tag
	-- loops = how many loops it will have done when it ends completely
	-- loopsLeft = how many are remaining
	if tag == 'JukeBoxWait' then
		doTweenX('MoveOutOne', 'JukeBox', -450, 0.2, 'quadOut')
		doTweenX('MoveOutTwo', 'JukeBoxSubText', -450, 0.2, 'quadOut')
		doTweenX('MoveOutThree', 'JukeBoxSubText2', -450, 0.2, 'quadOut')
		doTweenX('MoveOutFour', 'composer-icon', -450, 0.2, 'quadOut')
		doTweenX('MoveOutFive', 'composer-icon-alt', -450, 0.2, 'quadOut')
	end
end

function onUpdatePost()

	setProperty('composer-icon.scale.x', getProperty('iconP1.scale.x'))
	setProperty('composer-icon.scale.y', getProperty('iconP1.scale.y'))
	setProperty('composer-icon.angle', getProperty('iconP1.angle'))

	setProperty('composer-icon-alt.scale.x', getProperty('iconP1.scale.x'))
	setProperty('composer-icon-alt.scale.y', getProperty('iconP1.scale.y'))
end