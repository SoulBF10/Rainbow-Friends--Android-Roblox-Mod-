function onBeatHit()

	turnvalueP1 = -40
	if curBeat % 2 == 0 then
	turnvalueP1 = 40
	end

	setProperty('iconP2.angle',-turnvalueP1)
	setProperty('iconP1.angle',turnvalueP1)

	doTweenAngle('iconTween1','iconP1',0,crochet/1000,'circOut')
	doTweenAngle('iconTween2','iconP2',0,crochet/1000,'circOut')

end

function onCreatePost()
	setObjectOrder('healthBarBG', getObjectOrder('iconP1') - 1)
end

function onUpdatePost()
	setProperty('iconP1.y', getProperty('healthBarBG.y') - 60)
end