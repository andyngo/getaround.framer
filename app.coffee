# This imports all the layers for "getaroundneue" into design
design = Framer.Importer.load "imported/getaroundneue"

# layer names
searchBar = design.searchBar
locationActive = design.locationActive
locationInactive = design.locationInactive
locationIndicator = design.locationIndicator
favListButton = design.favListButton
badges = design.badges
map = design.Map
stops = design.stops
etaScreen = design.eta
bottomDismiss = design.bottomDismiss
main = design.main
favListButtonActive = design.favListButtonActive

# variables
ballCurve = "spring(260, 30, 0, 0.1)"
badgesDrop = "spring(260, 30, 0, 0.1)"
busSpring = "spring(300,25,1)"
w = Framer.Device.screen.width
h = Framer.Device.screen.height

# defining default states and animations

#bottomContainer

#etaScreen
etaScreen.x = 1080
etaScreen.states.add
	show: x: 0
etaScreen.states.animationOptions =
	curve: "spring(260, 30, 0, 0.1)"

#bottomStar
design.bottomStar.states.add
	grayscale: grayscale: 100
	
initStarX = design.topStar.x
design.topStar.states.add
	hide: opacity: 0, scale: 0
design.topStar.states.animationOptions =
	curve: "spring(600,20,10)"

usmX = design.usm.x
design.usm.states.add
	left: x: usmX - design.topStar.width - 5
design.usm.states.animationOptions =
	curve: "spring(600,20,10)"

design.bottomStar.on Events.TouchStart, ->
	design.bottomStar.animate
		properties:
			opacity: 0.85
			scale: 1.4
		curve: "spring(800,20,10)"
	design.bottomStar.states.next()
	design.topStar.states.next()
	design.usm.states.next()

design.bottomStar.on Events.TouchEnd, ->
	design.bottomStar.animate
		properties:
			opacity: 1
			scale: 1
		curve: "spring(800,20,10)"
# 	design.bottomStar.states.next()

#map
map.states.add
	blur: blur: 10

#location Indicator
locationIndicator.opacity = 0
animLIStart = locationIndicator.animate
	properties: scale: 1.2
	
locationIndicator.states.add
	show: opacity:1
animLIReverse = animLIStart.reverse()
animLIStart.on Events.AnimationEnd, -> animLIReverse.start()
animLIReverse.on Events.AnimationEnd, -> animLIStart.start()
	
locationIndicator.states.animationOptions = {
	curve: ballCurve
}

#location Active
locationActive.opacity = 0
locationActive.scale = 0
locationActive.states.add
	show: opacity: 1, scale: 1
locationActive.states.animationOptions =
	curve: "spring(200,7,0)"

#busListClip
scrollList = new ScrollComponent
	x: 100+90
	y: 950
	width: 900
	height: 915
	clip: true
	scrollHorizontal: false
	mouseWheelEnabled: true
	
scrollList.superLayer = etaScreen

design.busList.props =
	x: 0
	y: 0
	superLayer: scrollList.content

scrollList.on Events.ScrollStart, ->
	etaScreen.draggable.horizontal = false
scrollList.on Events.ScrollEnd, ->
	etaScreen.draggable.horizontal = true

#favListButtonActive
favListButtonActive.props =
	scale: 1
	grayscale: 100
favListButtonActive.states.add
	active: grayscale: 0, scale: 1.1
favListButtonActive.states.animationOptions =
	curve: "spring(300,20,0)"

# click events
etaScreen.draggable.props =
	vertical: false
	speedX: .5
	speedY: 0
	overdrag: false
	bounce: false

etaScreen.on Events.DragEnd, ->
	if etaScreen.x > 324
		etaScreen.animate
			properties:
				x:1080
			curve: "spring(500,50,0)"
	else
		etaScreen.x < 324
		etaScreen.animate
			properties:
				x:0
			curve: "spring(500,50,0)"
		
design.stopsFavA.on Events.TouchStart, ->
	favAAnim = design.stopsFavA.animate
		properties:
			opacity: 0.85
			scale: 1.05
		curve: "spring(800,20,10)"
		
design.stopsFavA.on Events.TouchEnd, ->
	etaScreen.animate
		properties:
			x: 0
			z: 500
		curve: "spring(500,50,0)"
	favAAnim = design.stopsFavA.animate
		properties:
			opacity: 1
			scale: 1
		curve: "spring(800,20,10)"
		
design.stopsA.on Events.TouchStart, ->
	favAAnim = design.stopsA.animate
		properties:
			opacity: 0.85
			scale: 1.05
		curve: "spring(800,20,10)"
		
design.stopsA.on Events.TouchEnd, ->
	etaScreen.animate
		properties:
			x: 0
			z: 500
		curve: "spring(500,50,0)"
	favAAnim = design.stopsA.animate
		properties:
			opacity: 1
			scale: 1
		curve: "spring(800,20,10)"

bottomDismiss.draggable.propagateEvents = false
bottomDismiss.draggable.enabled = false
bottomDismiss.on Events.TouchStart, ->
	bottomDismiss.animate
		properties:
			opacity: 0.85
			scale: 1.05
		curve: "spring(800,20,10)"

bottomDismiss.on Events.TouchEnd, ->
	etaScreen.animate
		properties:
			x: 1080
		curve: "spring(500,50,0)"	
	bottomDismiss.animate
		properties:
			opacity: 1
			scale: 1
		curve: "spring(800,20,10)"

#bus stop badges
design.badgeA.opacity = 0
design.badgeA.scale = 0
design.badgeA.states.add
	show: {opacity:1, scale:1}
design.badgeA.states.animationOptions = {
	curve: ballCurve
	delay: .15
}

design.badgeB.opacity = 0
design.badgeB.scale = 0
design.badgeB.states.add
	show: {opacity:1, scale:1}
design.badgeB.states.animationOptions = {
	curve: ballCurve
	delay: .3
}

stopSpring = "spring(150,15,0)"

initAY = design.stopsA.y	
design.stopsA.props =
	opacity: 0
	scale: 1.2
	rotationZ: 20
	rotationY: 50
	y: initAY + (h/2)
design.stopsA.states.add
	show: opacity: 1, y: initAY, rotationZ: 0, rotationY: 0, scale: 1
design.stopsA.states.animationOptions =
	curve: stopSpring
	delay: .2
	
initBY = design.stopsB.y	
design.stopsB.props =
	opacity: 0
	scale: 1.2
	rotationZ: 20
	rotationY: 50
	y: initBY + (h/2)
design.stopsB.states.add
	show: opacity: 1, y: initBY, rotationZ: 0, rotationY: 0, scale: 1
design.stopsB.states.animationOptions =
	curve: stopSpring
	delay: .1
	
initCY = design.stopsC.y	
design.stopsC.props =
	opacity: 0
	scale: 1.2
	rotationZ: 20
	rotationY: 50
	y: initCY + (h/2)
design.stopsC.states.add
	show: opacity: 1, y: initCY, rotationZ: 0, rotationY: 0, scale: 1
design.stopsC.states.animationOptions =
	curve: stopSpring

#stopsFav
initX = design.stopsFavA.x
design.stopsFav.opacity = 1
design.stopsFavA.props =
	opacity: 0
	scale: 1.2
# 	rotationZ: 20
	rotationY: 50
	x: (w/2)
	originX: 0
	perspective: 50
design.stopsFavA.states.add
	show: opacity: 1, x: initX, rotationZ: 0, rotationY: 0, scale: 1
design.stopsFavA.states.animationOptions =
	curve: stopSpring
	delay: .2

design.stopsFavB.props =
	opacity: 0
	scale: 1.2
# 	rotationZ: 20
	rotationY: 50
	x: (w/2)
	originX: 0
	perspective: 50
design.stopsFavB.states.add
	show: opacity: 1, x: initX, rotationZ: 0, rotationY: 0, scale: 1
design.stopsFavB.states.animationOptions =
	curve: stopSpring
	delay: .15
	
design.stopsFavC.props =
	opacity: 0
	scale: 1.2
# 	rotationZ: 20
	rotationY: 50
	x: (w/2)
	originX: 0
	perspective: 50
design.stopsFavC.states.add
	show: opacity: 1, x: initX, rotationZ: 0, rotationY: 0, scale: 1
design.stopsFavC.states.animationOptions =
	curve: stopSpring
	delay: .1
	
design.stopsFavD.props =
	opacity: 0
	scale: 1.2
# 	rotationZ: 20
	rotationY: 50
	x: (w/2)
	originX: 0
	perspective: 50
design.stopsFavD.states.add
	show: opacity: 1, x: initX, rotationZ: 0, rotationY: 0, scale: 1
design.stopsFavD.states.animationOptions =
	curve: stopSpring
	delay: .05
	
design.stopsFavE.props =
	opacity: 0
	scale: 1.2
# 	rotationZ: 20
	rotationY: 50
	x: (w/2)
	originX: 0
	perspective: 50
design.stopsFavE.states.add
	show: opacity: 1, x: initX, rotationZ: 0, rotationY: 0, scale: 1
design.stopsFavE.states.animationOptions =
	curve: stopSpring
	delay: 0

locationInactive.on Events.Click, ->
	locationIndicator.states.next()
	locationActive.states.next()
	design.badgeA.states.next()
	design.badgeB.states.next()
	design.stopsA.states.next()
	design.stopsB.states.next()
	design.stopsC.states.next()
	
	if favListButtonActive.states.current == "active"
		favListButtonActive.states.next()
		design.stopsFavA.states.next()
		design.stopsFavB.states.next()
		design.stopsFavC.states.next()
		design.stopsFavD.states.next()
		design.stopsFavE.states.next()

favListButtonActive.on Events.Click, ->
	favListButtonActive.states.next()
	design.stopsFavA.states.next()
	design.stopsFavB.states.next()
	design.stopsFavC.states.next()
	design.stopsFavD.states.next()
	design.stopsFavE.states.next()
	
	if locationActive.states.current == "show"
		locationIndicator.states.next()
		locationActive.states.next()
		design.badgeA.states.next()
		design.badgeB.states.next()
		design.stopsA.states.next()
		design.stopsB.states.next()
		design.stopsC.states.next()