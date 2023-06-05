!classDefinition: #LogMarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #LogMarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LogMarsRoverTest methodsFor: 'tests' stamp: 'lucy 6/5/2023 00:41:07'!
test01PositionLogWithoutMovementsIsEmpty
	
	|marsRover log|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	
	log := MarsRoverLog logPositionFor: marsRover.
	
	self assert: log show isEmpty.! !

!LogMarsRoverTest methodsFor: 'tests' stamp: 'lucy 6/5/2023 00:37:30'!
test02PositionLogAfterMovingFowardHasOneLine
	
	|marsRover log expectedLog |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	log := MarsRoverLog logPositionFor: marsRover. 
	
	marsRover process: 'f'. 
	expectedLog:= OrderedCollection new add: 2@1;yourself. 
	
	self assert: log show equals: expectedLog . ! !

!LogMarsRoverTest methodsFor: 'tests' stamp: 'lucy 6/5/2023 00:37:43'!
test03PositionLogAfterMovingFowardTwiceHasTwoLines
	
	|marsRover log expectedLog |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	log := MarsRoverLog logPositionFor: marsRover. 
	
	marsRover process: 'ff'. 
	expectedLog:= OrderedCollection new add: 2@1; add: 3@1;yourself. 
	
	self assert: log show equals: expectedLog . ! !

!LogMarsRoverTest methodsFor: 'tests' stamp: 'lucy 6/5/2023 00:37:53'!
test04PositionLogAfterMovingFowardAndRotationHasOneLine
	
	|marsRover log expectedLog |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	log := MarsRoverLog logPositionFor: marsRover. 
	
	marsRover process: 'fl'. 
	expectedLog:= OrderedCollection new add: 2@1; yourself. 
	
	self assert: log show equals: expectedLog . ! !

!LogMarsRoverTest methodsFor: 'tests' stamp: 'lucy 6/5/2023 00:41:15'!
test05HeadingLogWithoutRotationsIsEmpty

	|marsRover log|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	
	log := MarsRoverLog logHeadingFor: marsRover. 
	
	self assert: log show isEmpty.! !

!LogMarsRoverTest methodsFor: 'tests' stamp: 'lucy 6/5/2023 00:38:10'!
test06HeadingLogAfterMovingFowardAndLeftHasOneLine
	
	|marsRover log expectedLog |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	log := MarsRoverLog logHeadingFor: marsRover. 
	
	marsRover process: 'fl'. 
	expectedLog:= OrderedCollection new add: 'Apuntando al Norte'; yourself. 
	
	self assert: log show equals: expectedLog . ! !

!LogMarsRoverTest methodsFor: 'tests' stamp: 'lucy 6/5/2023 01:04:41'!
test07PositionAndHeadingLogAfterMovingFowardHasOneLine
	
	|marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	log := MarsRoverLog logPositionAndHeadingFor: marsRover. 
	
	marsRover process: 'f'. 
	
	self assert: log show first equals: 2@1.
	 ! !

!LogMarsRoverTest methodsFor: 'tests' stamp: 'lucy 6/5/2023 01:05:11'!
test08PositionAndHeadingLogAfterMovingFowardAndRotatingLeftHasOneLine
	
	|marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	log := MarsRoverLog logPositionAndHeadingFor: marsRover. 
	
	marsRover process: 'fl'. 
	
	self assert: log show first equals: 2@1.
	self assert:( log show second) equals: 'Apuntando al Norte'.
	 ! !

!LogMarsRoverTest methodsFor: 'tests' stamp: 'lucy 6/5/2023 01:06:09'!
test08PositionAndHeadingLogAfterMovingFowardAndRotatingOnItselfIsCorrect
	
	|marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	log := MarsRoverLog logPositionAndHeadingFor: marsRover. 
	
	marsRover process: 'flr'. 
	
	self assert: log show first equals: 2@1.
	self assert:( log show second) equals: 'Apuntando al Norte'.
	self assert:( log show third) equals: 'Apuntando al Este'.! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #WindowMarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #WindowMarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowMarsRoverTest methodsFor: 'tests' stamp: 'lucy 6/5/2023 01:29:15'!
test01PositionWindowIsEmptyIfRoversDodNotMove
	
	|marsRovers window|
	
	marsRovers := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	window := MarsRoverWindow windowPositionFor: marsRovers. 

	self assert: window show isEmpty.
	! !

!WindowMarsRoverTest methodsFor: 'tests' stamp: 'lucy 6/5/2023 01:28:10'!
test02WindowShowsPositionAfterMovingForward
	|marsRovers window|
	
	marsRovers := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	window := MarsRoverWindow windowPositionFor: marsRovers. 
	
	marsRovers process: 'f'. 
	
	self assert: window show equals: '2@1'. 
	
	! !

!WindowMarsRoverTest methodsFor: 'tests' stamp: 'lucy 6/5/2023 01:26:28'!
test03WindowShowsPositionAfterMovingForwardTwice
	|marsRovers window|
	
	marsRovers := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	window := MarsRoverWindow windowPositionFor: marsRovers. 
	
	marsRovers process: 'ff'. 
	
	self assert: window show equals: '3@1'. 
	
	! !

!WindowMarsRoverTest methodsFor: 'tests' stamp: 'lucy 6/5/2023 01:28:29'!
test04WindowShowsHeadingAfterRotatingLeft
	
	|marsRovers window|
	
	marsRovers := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	window := MarsRoverWindow windowHeadingFor: marsRovers. 
	
	marsRovers process: 'l'. 
	
	self assert: window show equals: ' Apuntando al Norte' 
	
	! !

!WindowMarsRoverTest methodsFor: 'tests' stamp: 'lucy 6/5/2023 01:30:54'!
test05WindowShowsHeadingAfterRotatingLeftTwice
	
	|marsRovers window|
	
	marsRovers := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	window := MarsRoverWindow windowHeadingFor: marsRovers. 
	
	marsRovers process: 'll'. 
	
	self assert: window show equals: ' Apuntando al Oeste' 
	
	! !

!WindowMarsRoverTest methodsFor: 'tests' stamp: 'lucy 6/5/2023 01:26:07'!
test06WindowShowsHeadingAndPositionAfterMovingFowardAndRotatingLeft
	
	|marsRovers window|
	
	marsRovers := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	window := MarsRoverWindow windowPositionAndHeadingFor: marsRovers. 
	
	marsRovers process: 'fl'. 
	
	self assert: window show equals: '2@1 Apuntando al Norte'. 
	
	! !

!WindowMarsRoverTest methodsFor: 'tests' stamp: 'lucy 6/5/2023 01:31:26'!
test07WindowShowsHeadingAfterMovingFowardAndRotatingLeft
	
	|marsRovers window|
	
	marsRovers := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	window := MarsRoverWindow windowHeadingFor: marsRovers. 
	
	marsRovers process: 'fl'. 
	
	self assert: window show equals: ' Apuntando al Norte'. 
	
	! !

!WindowMarsRoverTest methodsFor: 'tests' stamp: 'lucy 6/5/2023 01:31:20'!
test08WindowShowsPositionAfterMovingFowardAndRotatingLeft
	
	|marsRovers window|
	
	marsRovers := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	window := MarsRoverWindow windowPositionFor: marsRovers. 
	
	marsRovers process: 'fl'. 
	
	self assert: window show equals: '2@1'. 
	
	! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head loggers headingObserver positionObserver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'lucy 6/5/2023 00:50:26'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType initiazeFor: self. 
	loggers := OrderedCollection new. 
	headingObserver := MarsRoverObserverHeading new.
	positionObserver := MarsRoverObserverPosition new.! !


!MarsRover methodsFor: 'heading' stamp: 'lucy 6/5/2023 00:46:49'!
headEast
	
	head := MarsRoverHeadingEast initiazeFor: self.
	headingObserver beNotifiedOfHeadingChange: head.! !

!MarsRover methodsFor: 'heading' stamp: 'lucy 6/5/2023 00:48:06'!
headNorth
	
	head := MarsRoverHeadingNorth initiazeFor: self..
	headingObserver beNotifiedOfHeadingChange: head.! !

!MarsRover methodsFor: 'heading' stamp: 'lucy 6/5/2023 00:48:15'!
headSouth
	
	head := MarsRoverHeadingSouth initiazeFor: self.
	headingObserver beNotifiedOfHeadingChange: head.! !

!MarsRover methodsFor: 'heading' stamp: 'lucy 6/5/2023 00:46:31'!
headWest
	
	head := MarsRoverHeadingWest initiazeFor: self.
	headingObserver beNotifiedOfHeadingChange: head.! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'lucy 6/5/2023 00:25:21'!
moveEast
	
	position := position + (1@0).
	positionObserver beNotifiedOfPositionChange: position.! !

!MarsRover methodsFor: 'moving' stamp: 'lucy 6/5/2023 00:24:30'!
moveForward
	
	head moveForward.! !

!MarsRover methodsFor: 'moving' stamp: 'lucy 6/5/2023 00:25:13'!
moveNorth
	
	position := position + (0@1).
	positionObserver beNotifiedOfPositionChange: position.! !

!MarsRover methodsFor: 'moving' stamp: 'lucy 6/5/2023 00:25:38'!
moveSouth
	
	position := position + (0@-1).
	positionObserver beNotifiedOfPositionChange: position.! !

!MarsRover methodsFor: 'moving' stamp: 'lucy 6/5/2023 00:25:45'!
moveWest
	
	position := position + (-1@0).
	positionObserver beNotifiedOfPositionChange: position.! !


!MarsRover methodsFor: 'command processing' stamp: 'lucy 6/5/2023 00:20:27'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand.].  
! !

!MarsRover methodsFor: 'command processing' stamp: 'pau 6/3/2023 16:16:52'!
processCommand: aCommand
	
	(self isForwardCommand: aCommand) ifTrue: [^self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.
	
	 ! !


!MarsRover methodsFor: 'attach' stamp: 'lucy 6/5/2023 00:49:53'!
attachToHeadingObserver: aTracer

	headingObserver addNewTracer: aTracer.
	! !

!MarsRover methodsFor: 'attach' stamp: 'lucy 6/5/2023 00:49:58'!
attachToPositionObserver: aTracer

	positionObserver addNewTracer: aTracer.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !


!MarsRoverHeading methodsFor: 'visitor' stamp: 'lucy 6/5/2023 00:58:41'!
accept: aVisitor

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'pau 6/4/2023 22:03:11'!
initiazeFor: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'visitor' stamp: 'lucy 6/5/2023 00:59:51'!
accept: aVisitor

	aVisitor visitHeadingEast.! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'visitor' stamp: 'lucy 6/5/2023 01:00:54'!
accept: aVisitor

	aVisitor visitHeadingNorth.! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'visitor' stamp: 'lucy 6/5/2023 01:01:07'!
accept: aVisitor

	aVisitor visitHeadingSouth.! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'visitor' stamp: 'lucy 6/5/2023 01:01:16'!
accept: aVisitor

	aVisitor visitHeadingWest.! !


!classDefinition: #MarsRoverLog category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverLog
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLog methodsFor: 'initialize' stamp: 'lucy 6/5/2023 00:29:56'!
initiaze
	log := OrderedCollection new.
	
	! !


!MarsRoverLog methodsFor: 'show' stamp: 'lucy 6/5/2023 00:40:08'!
show
	^log! !


!MarsRoverLog methodsFor: 'visit' stamp: 'lucy 6/5/2023 01:02:35'!
visitHeadingEast

	log add: 'Apuntando al Este'! !

!MarsRoverLog methodsFor: 'visit' stamp: 'lucy 6/5/2023 01:02:39'!
visitHeadingNorth

	log add: 'Apuntando al Norte'! !

!MarsRoverLog methodsFor: 'visit' stamp: 'lucy 6/5/2023 01:02:46'!
visitHeadingSouth

	log add: 'Apuntando al Sur'! !

!MarsRoverLog methodsFor: 'visit' stamp: 'lucy 6/5/2023 01:02:49'!
visitHeadingWest

	log add: 'Apuntando al Oeste'! !


!MarsRoverLog methodsFor: 'being notified' stamp: 'lucy 6/5/2023 00:58:21'!
notifyHeadingChange: aHeading

	aHeading accept: self.! !

!MarsRoverLog methodsFor: 'being notified' stamp: 'lucy 6/5/2023 00:33:04'!
notifyPositionChange: aPosition

	log add: aPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLog class' category: 'MarsRover-WithHeading'!
MarsRoverLog class
	instanceVariableNames: ''!

!MarsRoverLog class methodsFor: 'instance creation' stamp: 'lucy 6/5/2023 00:31:33'!
logHeadingFor: aMarsRover 

	| log|
	log := self new initiaze.
	aMarsRover attachToHeadingObserver: log.
	^log.
	! !

!MarsRoverLog class methodsFor: 'instance creation' stamp: 'lucy 6/5/2023 00:32:18'!
logPositionAndHeadingFor: aMarsRover 

	| log|
	log := self new initiaze.
	aMarsRover attachToHeadingObserver: log.
	aMarsRover attachToPositionObserver: log.
	^log.! !

!MarsRoverLog class methodsFor: 'instance creation' stamp: 'lucy 6/5/2023 00:32:27'!
logPositionFor: aMarsRover 

	| log|
	log := self new initiaze.
	aMarsRover attachToPositionObserver: log.
	^log.! !


!classDefinition: #MarsRoverObserverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserverHeading
	instanceVariableNames: 'headingTracers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserverHeading methodsFor: 'as yet unclassified' stamp: 'lucy 6/4/2023 23:58:52'!
addNewTracer: aTracer
	headingTracers add: aTracer.! !

!MarsRoverObserverHeading methodsFor: 'as yet unclassified' stamp: 'lucy 6/5/2023 00:27:30'!
beNotifiedOfHeadingChange: aHeading.
	headingTracers do: [:aTracer | aTracer notifyHeadingChange: aHeading].! !

!MarsRoverObserverHeading methodsFor: 'as yet unclassified' stamp: 'lucy 6/4/2023 23:59:29'!
initialize
	headingTracers := OrderedCollection new.! !


!classDefinition: #MarsRoverObserverPosition category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserverPosition
	instanceVariableNames: 'positionTracers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserverPosition methodsFor: 'as yet unclassified' stamp: 'lucy 6/4/2023 23:59:06'!
addNewTracer: aTracer
	positionTracers add: aTracer.! !

!MarsRoverObserverPosition methodsFor: 'as yet unclassified' stamp: 'lucy 6/5/2023 00:27:45'!
beNotifiedOfPositionChange: aPosition.
	positionTracers do: [:aTracer | aTracer notifyPositionChange: aPosition].! !

!MarsRoverObserverPosition methodsFor: 'as yet unclassified' stamp: 'lucy 6/4/2023 23:59:38'!
initialize
	positionTracers := OrderedCollection new.! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverWindow
	instanceVariableNames: 'textPosition textHeading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'initialize' stamp: 'lucy 6/5/2023 01:17:50'!
initialize

	textPosition := ''.
	textHeading := ''.
	! !


!MarsRoverWindow methodsFor: 'show' stamp: 'lucy 6/5/2023 01:19:48'!
show
	
	^textPosition, textHeading! !


!MarsRoverWindow methodsFor: 'visit' stamp: 'lucy 6/5/2023 01:21:28'!
visitHeadingEast

	textHeading := ' Apuntando al Este'! !

!MarsRoverWindow methodsFor: 'visit' stamp: 'lucy 6/5/2023 01:21:46'!
visitHeadingNorth

	textHeading := ' Apuntando al Norte'! !

!MarsRoverWindow methodsFor: 'visit' stamp: 'lucy 6/5/2023 01:21:54'!
visitHeadingSouth

	textHeading := ' Apuntando al Sur'! !

!MarsRoverWindow methodsFor: 'visit' stamp: 'lucy 6/5/2023 01:21:37'!
visitHeadingWest

	textHeading := ' Apuntando al Oeste'! !


!MarsRoverWindow methodsFor: 'being notified' stamp: 'lucy 6/5/2023 01:20:07'!
notifyHeadingChange: aHeading

	aHeading accept: self.! !

!MarsRoverWindow methodsFor: 'being notified' stamp: 'lucy 6/5/2023 01:24:41'!
notifyPositionChange: aPosition

	textPosition := aPosition asString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWindow class' category: 'MarsRover-WithHeading'!
MarsRoverWindow class
	instanceVariableNames: ''!

!MarsRoverWindow class methodsFor: 'as yet unclassified' stamp: 'lucy 6/5/2023 01:30:05'!
windowHeadingFor: aMarsRover 

	|window|
	window := self new.
	aMarsRover attachToHeadingObserver: window.
	^window.
	! !

!MarsRoverWindow class methodsFor: 'as yet unclassified' stamp: 'lucy 6/5/2023 01:30:10'!
windowPositionAndHeadingFor: aMarsRover 

	|window|
	window := self new.
	aMarsRover attachToPositionObserver: window.
	aMarsRover attachToHeadingObserver: window.
	^window.
	! !

!MarsRoverWindow class methodsFor: 'as yet unclassified' stamp: 'lucy 6/5/2023 01:30:00'!
windowPositionFor: aMarsRover 

	|window|
	window := self new.
	aMarsRover attachToPositionObserver: window.
	^window.
	! !
