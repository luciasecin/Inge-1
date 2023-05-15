!classDefinition: #TestMarsRover category: 'MarsRovers'!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 17:46:26'!
test01RobotStartsAtInitialPosition

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRover in: initialPos pointing: self northDirection.
	
	self assert: initialPos equals: robot currentPosition.
	self assert: robot currentPointingDirection isNorth.! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:37:22'!
test02EmptyCommandDoesNotMoveRobot

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRover in: initialPos pointing: self southDirection.
	
	robot receiveCommands: ''.
	
	self assert: initialPos equals: robot currentPosition.
	self assert: robot currentPointingDirection isSouth.! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:37:22'!
test03RobotPointingSouthMovesForwards

	self assertRobotPointing:  self southDirection 
	afterMoving: [:robot | robot receiveCommands: 'f' ] 
	isIn:  0@-1 
	pointingTo: [:aDirection| aDirection isSouth ].! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:39:55'!
test04RobotPointingSouthMovesBackwards

	self assertRobotPointing:  self southDirection 
		afterMoving: [:robot| robot receiveCommands: 'b'] 
		isIn: 0@1
		pointingTo: [:aDirection| aDirection isSouth]! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:41:28'!
test05RobotPointingSouthRotatesLeftToEast

	self assertRobotPointing: self southDirection 
		afterMoving: [:robot| robot receiveCommands: 'l'.] 
		isIn: 0@0 
		pointingTo: [:aDirection| aDirection isEast]! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:42:00'!
test06RobotPointingSouthRotatesRightToWest

	self assertRobotPointing: self southDirection 
		afterMoving: [:robot| robot receiveCommands: 'r'.] 
		isIn: 0@0 
		pointingTo: [:aDirection| aDirection  isWest.]! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:37:22'!
test07RobotPointingSouthRaisesInvalidCommandError

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRover in: initialPos pointing: self southDirection.
	
	self should: [robot receiveCommands: 'i'] 
		raise: Error 
		withExceptionDo: [:error | self assert: 'Comando Invalido' equals: (error messageText)]! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:42:41'!
test08RobotPointingNorthMovesForwards

	self assertRobotPointing: self northDirection
		afterMoving: [:robot| robot receiveCommands: 'f'.] 
		isIn: 0@1 
		pointingTo: [:aDirection| aDirection isNorth.]
	! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:43:15'!
test09RobotPointingNorthMovesBackwards

	self assertRobotPointing: self northDirection
		afterMoving: [:robot| robot receiveCommands: 'b'.] 
		isIn: 0@-1
		pointingTo: [:aDirection| aDirection isNorth.]
		! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:43:40'!
test10RobotPointingNorthRotatesLeftToWest

	self assertRobotPointing: self northDirection
		afterMoving: [:robot| robot receiveCommands: 'l'.] 
		isIn: 0@0
		pointingTo: [:aDirection| aDirection isWest.]! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:44:23'!
test11RobotPointingNorthRotatesRightToEast

	self assertRobotPointing: self northDirection
		afterMoving: [:robot| robot receiveCommands: 'r'.] 
		isIn: 0@0
		pointingTo: [:aDirection| aDirection isEast.]! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 17:46:26'!
test12RobotPointingNorthRaisesInvalidCommandError

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRover in: initialPos pointing: self northDirection.
	
	self should: [robot receiveCommands: 'i'] 
		raise: Error 
		withExceptionDo: [:error | self assert: 'Comando Invalido' equals: (error messageText)]! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:55:21'!
test13RobotPointingEastMovesForwards

	self assertRobotPointing: self eastDirection
		afterMoving: [:robot| robot receiveCommands: 'f'.] 
		isIn:  1@0
		pointingTo: [:aDirection| aDirection isEast.]! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:55:21'!
test14RobotPointingEastMovesBackwards

	self assertRobotPointing: self eastDirection
		afterMoving: [:robot| robot receiveCommands: 'b'.] 
		isIn:  -1@0
		pointingTo: [:aDirection| aDirection isEast.]! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:55:21'!
test15RobotPointingEastRotatesLeftToNorth

	
	self assertRobotPointing: self eastDirection
		afterMoving: [:robot| robot receiveCommands: 'l'.] 
		isIn:  0@0
		pointingTo: [:aDirection| aDirection isNorth.]! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:55:21'!
test16RobotPointingEastRotatesRigthToSouth

	self assertRobotPointing: self eastDirection
		afterMoving: [:robot| robot receiveCommands: 'r'.] 
		isIn:  0@0
		pointingTo: [:aDirection| aDirection isSouth .]! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:47:25'!
test17RobotPointingWestMovesForards

	self assertRobotPointing: self westDirection
		afterMoving: [:robot| robot receiveCommands: 'f'.] 
		isIn:  -1@0
		pointingTo: [:aDirection| aDirection isWest .]
	! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:48:06'!
test18RobotPointingWestMovesBackwards

	self assertRobotPointing: self westDirection
	afterMoving: [:robot| robot receiveCommands: 'b'.] 
	isIn:  1@0
	pointingTo: [:aDirection| aDirection isWest .]! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:48:45'!
test19RobotPointingWestRotatesLeftToSouth

	self assertRobotPointing: self westDirection
		afterMoving: [:robot| robot receiveCommands: 'l'.] 
		isIn:  0@0
		pointingTo: [:aDirection| aDirection isSouth.]! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:49:07'!
test20RobotPointingWestRotatesRightToNorth

	self assertRobotPointing: self westDirection
	afterMoving: [:robot| robot receiveCommands: 'r'.] 
	isIn:  0@0
	pointingTo: [:aDirection| aDirection isNorth.]! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:53:46'!
test21RobotPointingSouthMovesForwardsTwice

	self assertRobotPointing:  self southDirection
	afterMoving: [:robot|robot receiveCommands: 'ff'.] 
	isIn:  0@-2
	pointingTo: [:aDirection| aDirection isSouth.]! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:54:12'!
test22RobotPointingSouthMovesForwardsThenBackwards

	self assertRobotPointing:  self southDirection
	afterMoving: [:robot|robot receiveCommands: 'fb'] 
	isIn:  0@0
	pointingTo: [:aDirection| aDirection isSouth.]! !

!TestMarsRover methodsFor: 'tests' stamp: 'pau 5/14/2023 18:54:47'!
test23RobotPointingSouthMovesForwardsThenLeftToWest

	self assertRobotPointing:  self northDirection
	afterMoving: [:robot|robot receiveCommands: 'fl'] 
	isIn:  0@1
	pointingTo: [:aDirection| aDirection isWest.]
	! !


!TestMarsRover methodsFor: 'directions' stamp: 'pau 5/14/2023 18:55:21'!
eastDirection

	^ East new! !

!TestMarsRover methodsFor: 'directions' stamp: 'pau 5/14/2023 17:46:26'!
northDirection

	^ North new! !

!TestMarsRover methodsFor: 'directions' stamp: 'pau 5/14/2023 18:37:22'!
southDirection

	^ South new! !

!TestMarsRover methodsFor: 'directions' stamp: 'pau 5/14/2023 18:46:56'!
westDirection

	^ West new! !


!TestMarsRover methodsFor: 'asserts' stamp: 'pau 5/14/2023 18:36:31'!
assertRobotPointing: anInitialDirection afterMoving: aBlockWithMovements isIn: aFinalPosition pointingTo: aFinalDirection

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRover in: initialPos pointing: anInitialDirection.
	
	aBlockWithMovements value: robot.
	
	self assert: aFinalPosition equals: robot currentPosition.
	self assert: ( aFinalDirection value: (robot currentPointingDirection)).! !


!classDefinition: #Direction category: 'MarsRovers'!
Object subclass: #Direction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!Direction methodsFor: 'moving' stamp: 'lucy 5/14/2023 00:05:00'!
coordinatesBackwards

	^ (self coordinatesForwards) negated! !

!Direction methodsFor: 'moving' stamp: 'lucy 5/14/2023 00:06:12'!
coordinatesForwards

	self subclassResponsibility ! !

!Direction methodsFor: 'moving' stamp: 'lucy 5/14/2023 00:06:36'!
directionLeft

	self subclassResponsibility ! !

!Direction methodsFor: 'moving' stamp: 'lucy 5/14/2023 00:06:41'!
directionRight

	self subclassResponsibility ! !


!Direction methodsFor: 'comparing' stamp: 'lucy 5/14/2023 00:17:57'!
isEast

	self subclassResponsibility ! !

!Direction methodsFor: 'comparing' stamp: 'lucy 5/14/2023 00:18:05'!
isNorth

	self subclassResponsibility ! !

!Direction methodsFor: 'comparing' stamp: 'lucy 5/14/2023 00:18:17'!
isSouth

	self subclassResponsibility ! !

!Direction methodsFor: 'comparing' stamp: 'lucy 5/14/2023 00:18:12'!
isWest

	self subclassResponsibility ! !


!classDefinition: #East category: 'MarsRovers'!
Direction subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!East methodsFor: 'moving' stamp: 'lucy 5/13/2023 23:36:48'!
coordinatesForwards

	^(1@0)! !

!East methodsFor: 'moving' stamp: 'lucy 5/14/2023 00:37:58'!
directionLeft

	^North new! !

!East methodsFor: 'moving' stamp: 'lucy 5/14/2023 00:38:04'!
directionRight

	^South new! !


!East methodsFor: 'comparing' stamp: 'lucy 5/14/2023 00:13:52'!
isEast

	^true! !

!East methodsFor: 'comparing' stamp: 'lucy 5/14/2023 00:14:10'!
isNorth

	^false! !

!East methodsFor: 'comparing' stamp: 'lucy 5/14/2023 00:14:18'!
isSouth

	^false! !

!East methodsFor: 'comparing' stamp: 'lucy 5/14/2023 00:14:25'!
isWest

	^false! !


!classDefinition: #North category: 'MarsRovers'!
Direction subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!North methodsFor: 'moving' stamp: 'lucy 5/13/2023 23:44:41'!
coordinatesForwards

	^(0@1)! !

!North methodsFor: 'moving' stamp: 'lucy 5/14/2023 00:37:51'!
directionLeft

	^West new! !

!North methodsFor: 'moving' stamp: 'lucy 5/14/2023 00:37:45'!
directionRight

	^East new! !


!North methodsFor: 'comparing' stamp: 'lucy 5/14/2023 00:14:52'!
isEast

	^false! !

!North methodsFor: 'comparing' stamp: 'lucy 5/14/2023 00:14:41'!
isNorth

	^true! !

!North methodsFor: 'comparing' stamp: 'lucy 5/14/2023 00:14:58'!
isSouth

	^false! !

!North methodsFor: 'comparing' stamp: 'lucy 5/14/2023 00:15:02'!
isWest

	^false! !


!classDefinition: #South category: 'MarsRovers'!
Direction subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!South methodsFor: 'moving' stamp: 'lucy 5/13/2023 23:56:16'!
coordinatesForwards

	^(0@-1)! !

!South methodsFor: 'moving' stamp: 'lucy 5/14/2023 00:37:32'!
directionLeft

	^East new! !

!South methodsFor: 'moving' stamp: 'lucy 5/14/2023 00:37:38'!
directionRight

	^West new! !


!South methodsFor: 'comparing' stamp: 'lucy 5/14/2023 00:15:37'!
isEast

	^false! !

!South methodsFor: 'comparing' stamp: 'lucy 5/14/2023 00:15:30'!
isNorth

	^false! !

!South methodsFor: 'comparing' stamp: 'lucy 5/14/2023 00:15:24'!
isSouth

	^true! !

!South methodsFor: 'comparing' stamp: 'lucy 5/14/2023 00:15:33'!
isWest

	^false! !


!classDefinition: #West category: 'MarsRovers'!
Direction subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!West methodsFor: 'moving' stamp: 'lucy 5/13/2023 23:56:16'!
coordinatesForwards

	^(-1@0)! !

!West methodsFor: 'moving' stamp: 'lucy 5/14/2023 00:37:12'!
directionLeft

	^South new! !

!West methodsFor: 'moving' stamp: 'lucy 5/14/2023 00:37:21'!
directionRight

	^North new! !


!West methodsFor: 'comparing' stamp: 'lucy 5/14/2023 00:16:57'!
isEast

	^false! !

!West methodsFor: 'comparing' stamp: 'lucy 5/14/2023 00:17:07'!
isNorth

	^false! !

!West methodsFor: 'comparing' stamp: 'lucy 5/14/2023 00:16:14'!
isSouth

	^false! !

!West methodsFor: 'comparing' stamp: 'lucy 5/14/2023 00:16:22'!
isWest

	^true! !


!classDefinition: #MarsRover category: 'MarsRovers'!
Object subclass: #MarsRover
	instanceVariableNames: 'position pointingDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!MarsRover methodsFor: 'initialize' stamp: 'pau 5/11/2023 21:39:36'!
initializeIn: aPosition pointing: aCardinalDirection 
	
	position := aPosition.
	pointingDirection := aCardinalDirection! !


!MarsRover methodsFor: 'commands' stamp: 'lucy 5/14/2023 00:00:21'!
executeCommand: instruction

	instruction = $f ifTrue: [position := position + pointingDirection coordinatesForwards].
	instruction = $b ifTrue: [position := position + pointingDirection coordinatesBackwards].
	instruction = $l ifTrue: [pointingDirection := pointingDirection directionLeft]. 
	instruction = $r ifTrue: [pointingDirection := pointingDirection directionRight].! !

!MarsRover methodsFor: 'commands' stamp: 'lucy 5/13/2023 23:58:59'!
receiveCommands: aStringWithCommands
	
	aStringWithCommands  isEmpty ifTrue: [^self].
	
	aStringWithCommands do: [:instruction|
		
		(#($f $b $l $r) includes: instruction) ifFalse: [^self error: 'Comando Invalido'].
		self executeCommand: instruction.
	].
	
	^self.! !


!MarsRover methodsFor: 'accessing' stamp: 'pau 5/11/2023 21:37:31'!
currentPointingDirection
	^pointingDirection ! !

!MarsRover methodsFor: 'accessing' stamp: 'pau 5/11/2023 21:35:22'!
currentPosition
	^position ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRovers'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'pau 5/11/2023 20:46:51'!
in: aPosition pointing: aCardinalDirection 

	^self new initializeIn: aPosition pointing: aCardinalDirection ! !
