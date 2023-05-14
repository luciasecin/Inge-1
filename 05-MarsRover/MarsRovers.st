!classDefinition: #TestMarsRovers category: 'MarsRovers'!
TestCase subclass: #TestMarsRovers
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 21:38:57'!
test01RobotArrancaEnLaPosInicial

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: Norte new.
	
	self assert: initialPos equals: robot currentPosition.
	self assert: robot currentPointingDirection equals: #Norte.! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 21:39:16'!
test02ElComandoVacioNoMueveAlRobot

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: Sur new.
	
	robot recibirComandos: ''.
	
	self assert: initialPos equals: robot currentPosition.
	self assert:  robot currentPointingDirection equals: #Sur.! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 21:34:25'!
test03RobotSeMueve1vez

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: Sur new.
	
	robot recibirComandos: 'f'.
	
	self assert:  0@-1 equals: robot currentPosition.
	self assert: #Sur equals: robot currentPointingDirection.! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 19:57:27'!
test04RobotSeMueve1vezHaciaAtrasApuntandoAlSur

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: #Sur.
	
	robot recibirComandos: 'b'.
	
	self assert:  0@1 equals: robot currentPosition.
	self assert: #Sur equals: robot currentPointingDirection.! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 19:59:49'!
test05RobotSeMueve1vezCambiaLaDireccion

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: #Sur.
	
	robot recibirComandos: 'l'.
	
	self assert:  initialPos equals: robot currentPosition.
	self assert: #Este equals: robot currentPointingDirection.! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 19:59:56'!
test06RobotSeMueve1vezCambiaLaDireccion

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: #Sur.
	
	robot recibirComandos: 'r'.
	
	self assert:  initialPos equals: robot currentPosition.
	self assert: #Oeste equals: robot currentPointingDirection.! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 20:33:39'!
test07RobotSeMueveInvalido

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: #Sur.
	
	self should: [robot recibirComandos: 'i'] 
		raise: Error 
		withExceptionDo: [:error | self assert: 'Comando Invalido' equals: (error messageText)]! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 20:11:40'!
test08RobotSeMueve1vez

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: #Norte.
	
	robot recibirComandos: 'f'.
	
	self assert:  0@1 equals: robot currentPosition.
	self assert: #Norte equals: robot currentPointingDirection.! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 20:39:52'!
test09RobotSeMueve1vez

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: #Norte.
	
	robot recibirComandos: 'b'.
	
	self assert:  0@-1 equals: robot currentPosition.
	self assert: #Norte equals: robot currentPointingDirection.! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 20:19:11'!
test10RobotSeMueve1vezCambiaLaDireccion

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: #Norte.
	
	robot recibirComandos: 'l'.
	
	self assert:  initialPos equals: robot currentPosition.
	self assert: #Oeste equals: robot currentPointingDirection.! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 20:21:13'!
test11RobotSeMueve1vezCambiaLaDireccion

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: #Norte.
	
	robot recibirComandos: 'r'.
	
	self assert:  initialPos equals: robot currentPosition.
	self assert: #Este equals: robot currentPointingDirection.! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 20:33:27'!
test12RobotSeMueveInvalido

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: #Norte.
	
	self should: [robot recibirComandos: 'i'] 
		raise: Error 
		withExceptionDo: [:error | self assert: 'Comando Invalido' equals: (error messageText)]! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 20:50:55'!
test13RobotSeMueve1vez

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: #Este.
	
	robot recibirComandos: 'f'.
	
	self assert:  1@0 equals: robot currentPosition.
	self assert: #Este equals: robot currentPointingDirection.! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 20:39:26'!
test14RobotSeMueve1vez

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: #Este.
	
	robot recibirComandos: 'b'.
	
	self assert:  -1@0 equals: robot currentPosition.
	self assert: #Este equals: robot currentPointingDirection.! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 20:40:49'!
test15RobotSeMueve1vezCambiaLaDireccion

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: #Este.
	
	robot recibirComandos: 'l'.
	
	self assert:  initialPos equals: robot currentPosition.
	self assert: #Norte equals: robot currentPointingDirection.! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 20:41:50'!
test16RobotSeMueve1vezCambiaLaDireccion

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: #Este.
	
	robot recibirComandos: 'r'.
	
	self assert:  initialPos equals: robot currentPosition.
	self assert: #Sur equals: robot currentPointingDirection.! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 20:50:40'!
test17RobotSeMueve1vez

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: #Oeste.
	
	robot recibirComandos: 'f'.
	
	self assert:  -1@0 equals: robot currentPosition.
	self assert: #Oeste equals: robot currentPointingDirection.! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 20:51:46'!
test18RobotSeMueve1vez

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: #Oeste.
	
	robot recibirComandos: 'b'.
	
	self assert:  1@0 equals: robot currentPosition.
	self assert: #Oeste equals: robot currentPointingDirection.! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 20:52:44'!
test19RobotSeMueve1vezCambiaLaDireccion

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: #Oeste.
	
	robot recibirComandos: 'l'.
	
	self assert:  initialPos equals: robot currentPosition.
	self assert: #Sur equals: robot currentPointingDirection.! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 20:53:28'!
test20RobotSeMueve1vezCambiaLaDireccion

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: #Oeste.
	
	robot recibirComandos: 'r'.
	
	self assert:  initialPos equals: robot currentPosition.
	self assert: #Norte equals: robot currentPointingDirection.! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 21:00:49'!
test21RobotSeMueve2veces

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: #Sur.
	
	robot recibirComandos: 'ff'.
	
	self assert:  0@-2 equals: robot currentPosition.
	self assert: #Sur equals: robot currentPointingDirection.! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 21:02:48'!
test22RobotSeMueve2veces

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: #Sur.
	
	robot recibirComandos: 'fb'.
	
	self assert:  0@0 equals: robot currentPosition.
	self assert: #Sur equals: robot currentPointingDirection.! !

!TestMarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 21:14:52'!
test23RobotSeMueve2veces

	|robot initialPos|
	initialPos := 0@0.
	robot := MarsRovers in: initialPos pointing: #Norte.
	
	robot recibirComandos: 'fl'.
	
	self assert:  0@1 equals: robot currentPosition.
	self assert: #Oeste equals: robot currentPointingDirection.! !


!classDefinition: #DirectionState category: 'MarsRovers'!
Object subclass: #DirectionState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!


!classDefinition: #Este category: 'MarsRovers'!
DirectionState subclass: #Este
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!Este methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 21:37:31'!
=algo
	^algo = #Este! !

!Este methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 21:42:03'!
recibirComandos: instruction
	! !

!Este methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 21:48:03'!
sendCommand: instruction to: rover
	rover pointingEastReceiveCommand: instruction.! !


!classDefinition: #Norte category: 'MarsRovers'!
DirectionState subclass: #Norte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!Norte methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 21:37:25'!
=algo
	^algo= #Norte! !


!classDefinition: #Oeste category: 'MarsRovers'!
DirectionState subclass: #Oeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!Oeste methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 21:37:18'!
=algo
	^algo = #Oeste! !


!classDefinition: #Sur category: 'MarsRovers'!
DirectionState subclass: #Sur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!Sur methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 21:37:11'!
=algo
	^#Sur = algo! !


!classDefinition: #MarsRovers category: 'MarsRovers'!
Object subclass: #MarsRovers
	instanceVariableNames: 'position pointingDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!MarsRovers methodsFor: 'initialize' stamp: 'pau 5/11/2023 21:39:36'!
initializeIn: aPosition pointing: aCardinalDirection 
	
	position := aPosition.
	pointingDirection := aCardinalDirection! !


!MarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/11/2023 21:37:31'!
currentPointingDirection
	^pointingDirection ! !

!MarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/11/2023 21:35:22'!
currentPosition
	^position ! !

!MarsRovers methodsFor: 'as yet unclassified' stamp: 'pau 5/13/2023 21:43:31'!
recibirComandos: aStringWithCommands
	aStringWithCommands  isEmpty ifTrue: [^self].
	aStringWithCommands do: [:instruction|
		 (#($f $b $l $r) includes: instruction) ifFalse: [^self error: 'Comando Invalido'].
		
		pointingDirection sendCommand: instruction to: self.
		"
		pointingDirection = #Sur 
			ifTrue: [instruction = $f ifTrue: [position := position - (0@1)].
					instruction = $b ifTrue: [position := position + (0@1)].
					instruction = $l ifTrue: [pointingDirection := #Este].
					instruction = $r ifTrue: [pointingDirection := #Oeste].]
			ifFalse:[
				pointingDirection = #Norte 
					ifTrue: [instruction = $f ifTrue: [position := position + (0@1)].
						    instruction = $b ifTrue: [position := position - (0@1)].
						  instruction = $l ifTrue: [pointingDirection := #Oeste].
						   instruction = $r ifTrue: [pointingDirection := #Este]]
					ifFalse:[
				
					pointingDirection = #Este
						ifTrue: [instruction = $f ifTrue: [position := position + (1@0)].
							    instruction = $b ifTrue: [position := position - (1@0)].
							instruction = $l ifTrue: [pointingDirection := #Norte].  
							instruction = $r ifTrue: [pointingDirection := #Sur]]
						ifFalse: [
					
						pointingDirection = #Oeste
							ifTrue: [instruction = $f ifTrue: [position := position - (1@0)].
								    instruction = $b ifTrue: [position := position + (1@0)].
								   instruction = $l ifTrue: [pointingDirection := #Sur].
								instruction = $r ifTrue: [pointingDirection := #Norte]]. ].].]."
	 ].
	^self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRovers class' category: 'MarsRovers'!
MarsRovers class
	instanceVariableNames: ''!

!MarsRovers class methodsFor: 'instance creation' stamp: 'pau 5/11/2023 20:46:51'!
in: aPosition pointing: aCardinalDirection 

	^self new initializeIn: aPosition pointing: aCardinalDirection ! !
