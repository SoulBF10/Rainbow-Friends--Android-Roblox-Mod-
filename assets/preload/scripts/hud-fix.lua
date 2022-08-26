--options

local songPositionBar = true --whether or not the song position/time bar will be active
local psychRating = false --whether or not the extra psych engine rating will appear, turn this off for accuracy i guess

function onBeatHit()
    iconP2ScaleX = 0.7
    iconP2ScaleY = 1.5
	if curBeat % 2 == 0 then
    iconP2ScaleX = 1.5
    iconP2ScaleY = 0.7
    end
end

function onUpdatePost(elapsed)
	iconP2ScaleX = lerp(iconP2ScaleX, 1, elapsed * 15)
    iconP2ScaleY = lerp(iconP2ScaleY, 1, elapsed * 15)

	BeatHitTimer()
end

function BeatHitTimer()
	setProperty('timeBar.scale.x', iconP2ScaleX)
    setProperty('timeBar.scale.y', iconP2ScaleY)
end

function lerp(a, b, ratio)
	return a + ratio * (b - a)
end

function onCreatePost()
    setProperty('camHUD.alpha', 0)

    setProperty('scoreTxt.visible', false)
    setProperty('timeBarBG.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeTxt.visible', false)

    makeLuaText('newScoreTxt', '', 0, screenWidth / 2 - 210, getProperty('healthBarBG.y') + 25)
    setTextSize('newScoreTxt', 22.5)
	setTextFont('newScoreTxt','PermanentMarker.ttf')
    setTextBorder('newScoreTxt', 3, '000000')
    addLuaText('newScoreTxt')
    setObjectCamera('newScoreTxt', 'hud')

    if psychRating then
        makeLuaText('ratingTxt', '', 0, getProperty('healthBarBG.x') - getProperty('healthBarBG.width') / 2, getProperty('accuracyTxt.y') - 26)
        setTextSize('ratingTxt', 20)
        setTextBorder('ratingTxt', 3, '000000')
        addLuaText('ratingTxt')
        setObjectCamera('ratingTxt', 'hud')
    end

    if songPositionBar then
        makeLuaSprite('songPosBG', 'healthBar', screenWidth / 2 - 300, 20)
        setProperty('songPosBG.scale.x', 1)
        setProperty('songPosBG.scale.y', 1)
        setObjectOrder('songPosBG', getObjectOrder('songPosBG'))
        addLuaSprite('songPosBG', true)
        setObjectCamera('songPosBG', 'hud')

        makeLuaSprite('songPosBar1', null, screenWidth / 2 - 296, 24)
        makeGraphic('songPosBar1', getProperty('songPosBG.width') - 8, getProperty('songPosBG.height') - 8, '969696')
        setObjectOrder('songPosBar1', getObjectOrder('songPosBG') - 1)
        addLuaSprite('songPosBar1', true)
        setObjectCamera('songPosBar1', 'hud')

        makeLuaSprite('songPosBar2', null, screenWidth / 2 - 296, 24)
        makeGraphic('songPosBar2', getProperty('songPosBG.width') - 8, getProperty('songPosBG.height') - 8, '00FF00')
        setObjectOrder('songPosBar2', getObjectOrder('songPosBG') - 1)
        addLuaSprite('songPosBar2', true)
        setObjectCamera('songPosBar2', 'hud')
        setProperty('songPosBar2.alpha', 0)

        makeLuaText('songName', songName, 601, screenWidth / 2 - 300, getProperty('songPosBG.y') - 15)
        setTextFont('songName','PermanentMarker.ttf')
        setTextAlignment('songName', 'center')
        setTextSize('songName', 28)
        setTextBorder('songName', 2, '000000')
        addLuaText('songName')
        setObjectCamera('songName', 'hud')
    end

    --downscroll positions
    if downscroll then
        setProperty('newScoreTxt.y', getProperty('healthBarBG.y') - 18)
        setProperty('missTxt.y', getProperty('newScoreTxt.y') + 26)
        setProperty('accuracyTxt.y', getProperty('missTxt.y') + 26)
        setProperty('ratingTxt.y', getProperty('accuracyTxt.y') + 26)

        if songPositionBar then
            setProperty('songPosBG.y', screenHeight * 0.9 + 45)
            setProperty('songPosBar1.y', screenHeight * 0.9 + 49.5)
            setProperty('songPosBar2.y', screenHeight * 0.9 + 49.5)
            setProperty('songName.y', screenHeight * 0.9 + 45)
        end
    end
end

function onUpdate()
    if hits < 1 and misses < 1 then
        setTextString('newScoreTxt', 'Score: 0' .. ' - ' .. 'Misses: 0' .. ' - ' .. 'Accuracy: 0%')

        if psychRating then
            setTextString('ratingTxt', 'Rating: ?')
        end
    else
        setProperty('newScoreTxt.x', screenWidth / 2 - 220)
        setTextString('newScoreTxt', 'Score:' .. score .. ' - ' .. 'Misses:' .. misses .. ' - '.. 'Accuracy:' .. round(rating * 100, 2) .. '%')
        if psychRating then
            setTextString('ratingTxt', 'Rating: ' .. ratingName .. ' - ' .. ratingFC)
        end
    end
end

function onSongStart()
    if songPositionBar then
        daSongLength = getProperty('songLength') / 1000

        --i have zero clue if using lua tweens for this is the right idea but for now this is what i'm doing
        doTweenX('timeStart', 'songPosBar2.scale', 0.001, 0.001, 'linear')
    end
end

function round(x, n) --https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end

function onTweenCompleted(tag)
    if songPositionBar then
        if tag == 'timeStart' then
            setProperty('songPosBar2.origin.x', 0)
            doTweenX('timeFill', 'songPosBar2.scale', 1, daSongLength, 'linear')
            setProperty('songPosBar2.alpha', 1)
        end
    end
end

function onStartCountdown()
    doTweenAlpha('hudFadeIn', 'camHUD', 1, 0.5, 'linear'); 
end