!classDefinition: #DrivingAssistantTests category: 'ISW1-2023-1C-2doParcial'!
TestCase subclass: #DrivingAssistantTests
	instanceVariableNames: 'velocity proximity beep brakes throttle speedToKeep'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-2doParcial'!

!DrivingAssistantTests methodsFor: 'tests' stamp: 'pau 7/6/2023 21:43:18'!
test01WhenCarIsTurnedOnWithTheDrivingAssistantOnManualModeTheInitialStateIsCorrect

	| drivingAssistant |
	
	drivingAssistant := self manualDrivingAssistant. 
	
	self assert: (drivingAssistant actualVelocity) equals: (0*kilometer /hour). 
	self assert: drivingAssistant beepIsOff.   
	self assert: (drivingAssistant throttleIsConnected). 
	self deny: (drivingAssistant brakesAreApplied). 
	
	
	
	
	! !

!DrivingAssistantTests methodsFor: 'tests' stamp: 'pau 7/6/2023 21:42:48'!
test02WhenCarIsTurnedOnWhitTheDrivingAssistantOnAutomaticModeTheInitialStateIsCorrect

	| drivingAssistant |
	
	drivingAssistant := self drivingAssistantOnAutomaticMode . 
	
	self assert: (drivingAssistant actualVelocity) equals: (0*kilometer /hour). 
	self assert: (drivingAssistant objetiveVelocity) equals: (20*kilometer/hour). 
	self assert:  (drivingAssistant beepIsOff).  
	self assert: (drivingAssistant throttleIsConnected). 
	self deny: (drivingAssistant brakesAreApplied). 
	
	
	
	
	
	! !

!DrivingAssistantTests methodsFor: 'tests' stamp: 'pau 7/6/2023 21:44:27'!
test03WhenCarIsTurnedOnWhitTheDrivingAssistantOnSemiAutomaticModeTheInitialStateIsCorrect

	| drivingAssistant semiautomaticMode |
	
	
	semiautomaticMode := self semiAutomaticModeWithObjectiveVelocityOf20kmxHour. 
	
	drivingAssistant := DrivingAssistant onMode: semiautomaticMode withSensorSystem: self withDrivingSystem: self . 
	
	self assert: (drivingAssistant actualVelocity) equals: (0*kilometer /hour). 
	self assert: (drivingAssistant objetiveVelocity) equals: (20*kilometer/hour). 
	self assert: (drivingAssistant beepIsOff).  
	self assert: (drivingAssistant throttleIsConnected). 
	self deny: (drivingAssistant brakesAreApplied). 
	
	
	
	
	
	! !

!DrivingAssistantTests methodsFor: 'tests' stamp: 'pau 7/6/2023 21:46:08'!
test04OnManualModeDrivingAssistantIsOnSafeModeWithObjectAtMoreThan2DMF

	| drivingAssistant |
	self setSensorSystemWith: ( ReadStream on: {50*kilometer /hour.}) andWith: (ReadStream on: {100000000*meter}). 
	
	
	drivingAssistant := self manualDrivingAssistant . 
	
	drivingAssistant tick. 
	
	self assert: (drivingAssistant actualVelocity) equals: (50*kilometer /hour). 
	
	self assert:  (drivingAssistant beepIsOff).  
	self assert: (drivingAssistant throttleIsConnected). 
	self deny: (drivingAssistant brakesAreApplied). 
	
	self assertDrivingSystemBeepIsOff.  
	self assertDrivingSystemThrottleIsOn. 
	self assertDrivingSystemBrakesAreOff. 
	
	
	
	
	! !

!DrivingAssistantTests methodsFor: 'tests' stamp: 'pau 7/6/2023 21:46:48'!
test05OnManualModeDrivingAssistantIsOnWarningModeWithObjectAtLessThan2DMF

	| drivingAssistant |
	self setSensorSystemWith: (ReadStream on: {50*kilometer /hour .})  andWith: (ReadStream on: {20*meter}). 
	
	drivingAssistant := self manualDrivingAssistant . 
	
	drivingAssistant tick. 
	
	self assert: (drivingAssistant actualVelocity) equals: (50*kilometer /hour). 
	
	self assert: (drivingAssistant beepIsOnWarning).  
	self assert: (drivingAssistant throttleIsConnected). 
	self deny: (drivingAssistant brakesAreApplied). 
	
	self assertDrinvingSystemIsOnWarning.  
	self assertDrivingSystemThrottleIsOn. 
	self assertDrivingSystemBrakesAreOff. 
	
	
	
	
	! !

!DrivingAssistantTests methodsFor: 'tests' stamp: 'pau 7/6/2023 21:47:08'!
test06OnManualModeDrivingAssistantIsOnDangerModeWithObjectAtLessThanDMF

	| drivingAssistant |
	
	velocity := ReadStream on: {50*kilometer /hour .}. 
	proximity :=  ReadStream on: {10*meter}. 
	
	drivingAssistant := self manualDrivingAssistant . 
	
	drivingAssistant tick. 
	
	self assert: (drivingAssistant actualVelocity) equals: (50*kilometer /hour). 
	
	self assert: (drivingAssistant beepIsOnDanger).  
	self assert: (drivingAssistant throttleIsConnected). 
	self deny: (drivingAssistant brakesAreApplied). 
	
	self assertDrivingSystemBeepIsOnDanger.  
	self assertDrivingSystemThrottleIsOn. 
	self assertDrivingSystemBrakesAreOff. 
	
	
	! !

!DrivingAssistantTests methodsFor: 'tests' stamp: 'pau 7/6/2023 21:46:08'!
test07OnAutomaticModeDrivingAssistantIsOnSafeModeWithObjectAtMoreThan2DMF

	| drivingAssistant |
	
	velocity := ReadStream on: {50*kilometer /hour .}. 
	proximity :=  ReadStream on: {100000*meter}. 
	
	
	drivingAssistant := self drivingAssistantOnAutomaticMode. 
	 
	drivingAssistant tick. 
	
	self assert: (drivingAssistant actualVelocity) equals: (50*kilometer /hour). 
	
	self assert: (drivingAssistant objetiveVelocity ) equals: (20*kilometer/hour).
	 
	self assert: (drivingAssistant beepIsOff).  
	self assert: (drivingAssistant throttleIsConnected). 
	self deny: (drivingAssistant brakesAreApplied). 
	
	self assert: (speedToKeep = (20*kilometer/hour)). 
	self assertDrivingSystemBeepIsOff.  
	self assertDrivingSystemThrottleIsOn. 
	self assertDrivingSystemBrakesAreOff. 
	
	
	
	
	! !

!DrivingAssistantTests methodsFor: 'tests' stamp: 'pau 7/6/2023 21:46:08'!
test08OnAutomaticModeDrivingAssistantIsOnWarningModeWithObjectAtLessThan2DMF

	| drivingAssistant |
	
	velocity := ReadStream on: {50*kilometer /hour .}. 
	proximity :=  ReadStream on: {15*meter}. 
	
	drivingAssistant := self drivingAssistantOnAutomaticMode. 
	 
	drivingAssistant tick. 
	
	self assert: (drivingAssistant actualVelocity) equals: (50*kilometer /hour). 
	self assert: (drivingAssistant beepIsOff).    
	self deny: (drivingAssistant throttleIsConnected). 
	self deny: (drivingAssistant brakesAreApplied). 
	
	self assert: speedToKeep equals: (45*kilometer/hour). 
	self assertDrivingSystemBeepIsOff.  
	self assert: (throttle = #off). 
	self assertDrivingSystemBrakesAreOff. 
	
	
	
	
	
	! !

!DrivingAssistantTests methodsFor: 'tests' stamp: 'pau 7/6/2023 21:45:26'!
test09OnAutomaticModeDrivingAssistantOnAutomaticIsOnDangerModeWithObjectAtLessThatDMF

	| drivingAssistant |
	
	velocity := ReadStream on: {50*kilometer /hour .}. 
	proximity :=  ReadStream on: {10*meter}. 
	
	
	drivingAssistant := self drivingAssistantOnAutomaticMode. 
	 
	drivingAssistant tick. 
	
	self assert: (drivingAssistant actualVelocity) equals: (50*kilometer /hour). 
	
	self assert: (drivingAssistant beepIsOff).  
	self deny: (drivingAssistant throttleIsConnected). 
	self assert: (drivingAssistant brakesAreApplied). 
	
	self assert: speedToKeep equals: (40*kilometer/hour). 
	self assertDrivingSystemBeepIsOff.  
	self assert: (throttle = #off). 
	self assert: (brakes = #on). 
	
	
	
	
	! !

!DrivingAssistantTests methodsFor: 'tests' stamp: 'pau 7/6/2023 21:46:08'!
test10OnSemiAutomaticModeDrivingAssistantIsOnSafeModeWithObjectAtMoreThat2DMF

	| drivingAssistant |
	
	velocity := ReadStream on: {50*kilometer /hour .}. 
	proximity :=  ReadStream on: {10000*meter}. 
	
	drivingAssistant := DrivingAssistant onMode: (self semiAutomaticModeWithObjectiveVelocityOf20kmxHour) withSensorSystem: self withDrivingSystem: self. 
	 
	drivingAssistant tick. 
	
	self assert: (drivingAssistant actualVelocity) equals: (50*kilometer /hour). 
	self assert: (drivingAssistant objetiveVelocity ) equals: (20*kilometer/hour). 
	
	self assert: (drivingAssistant beepIsOff).  
	self assert: (drivingAssistant throttleIsConnected). 
	self deny: (drivingAssistant brakesAreApplied). 
	 
	self assert: speedToKeep equals:  (20*kilometer/hour) . 
	self assertDrivingSystemBeepIsOff.  
	self assertDrivingSystemThrottleIsOn. 
	self assertDrivingSystemBrakesAreOff. 
	
	
	
	
	
	! !

!DrivingAssistantTests methodsFor: 'tests' stamp: 'pau 7/6/2023 21:46:48'!
test11OnSemiAutomaticModeDrivingAssistantIsOnWarningModeWithObjectAtLessThan2DMF

	| drivingAssistant |
	
	velocity := ReadStream on: {50*kilometer /hour .}. 
	proximity :=  ReadStream on: {15*meter}. 
	
	drivingAssistant := DrivingAssistant onMode: (self semiAutomaticModeWithObjectiveVelocityOf20kmxHour) withSensorSystem: self withDrivingSystem: self. 
	 
	drivingAssistant tick. 
	
	self assert: (drivingAssistant actualVelocity) equals: (50*kilometer /hour). 
	
	self assert: (drivingAssistant beepIsOnWarning).  
	self deny: (drivingAssistant throttleIsConnected). 
	self deny: (drivingAssistant brakesAreApplied). 
	
	
	self assert: speedToKeep equals: (45*kilometer/hour). 
	self assertDrinvingSystemIsOnWarning.  
	self assert: (throttle = #off). 
	self assertDrivingSystemBrakesAreOff. 
	
	
	
	
	! !

!DrivingAssistantTests methodsFor: 'tests' stamp: 'pau 7/6/2023 21:47:08'!
test12OnSemiAutomaticModeDrivingAssistantIsOnDangerModeWhenObjectIsAtLessThanDMF

	| drivingAssistant |
	
	velocity := ReadStream on: {50*kilometer /hour.}. 
	proximity :=  ReadStream on: {10*meter}. 
	
	drivingAssistant := DrivingAssistant onMode: (self semiAutomaticModeWithObjectiveVelocityOf20kmxHour) withSensorSystem: self withDrivingSystem: self. 
	 
	drivingAssistant tick. 
	
	self assert: (drivingAssistant actualVelocity) equals: (50*kilometer /hour). 
	
	self assert: (drivingAssistant beepIsOnDanger).  
	self deny: (drivingAssistant throttleIsConnected). 
	self assert: (drivingAssistant brakesAreApplied). 
	
	
	self assert: speedToKeep equals: (40*kilometer/hour). 
	self assertDrivingSystemBeepIsOnDanger.  
	self assert: (throttle = #off). 
	self assert: (brakes = #on). 
	
	
	
	
	! !

!DrivingAssistantTests methodsFor: 'tests' stamp: 'pau 7/6/2023 21:47:08'!
test13DrivingAssistantOnManualModeIsOnSafeZoneAndMovesToDangerZoneWhenObjectClose

	| drivingAssistant |
	
	velocity := ReadStream on: {50*kilometer /hour . 70*kilometer/hour}. 
	proximity :=  ReadStream on: {100000000*meter. 10*meter}. 
	
	drivingAssistant := self manualDrivingAssistant . 
	
	drivingAssistant tick. 
	drivingAssistant tick. 
	
	self assert: (drivingAssistant actualVelocity) equals: (70*kilometer /hour). 
	
	self assert:  (drivingAssistant beepIsOnDanger ).  
	self assert: (drivingAssistant throttleIsConnected). 
	self deny: (drivingAssistant brakesAreApplied). 
	
	self assertDrivingSystemBeepIsOnDanger.  
	self assertDrivingSystemThrottleIsOn. 
	self assertDrivingSystemBrakesAreOff. ! !

!DrivingAssistantTests methodsFor: 'tests' stamp: 'pau 7/6/2023 21:46:08'!
test14DrivingAssistantOnAutomaticModeIsOnDangerZoneAndMovesToSafeZoneWithObjectiveVelocity

	| drivingAssistant |
	
	velocity := ReadStream on: {50*kilometer /hour . 70*kilometer/hour}. 
	proximity :=  ReadStream on: {10*meter. 10000*meter}. 
	
	drivingAssistant := self drivingAssistantOnAutomaticMode. 
	
	drivingAssistant tick. 
	drivingAssistant tick. 
	
	self assert: (drivingAssistant actualVelocity) equals: (70*kilometer /hour). 
	
	self assert:  (drivingAssistant beepIsOff ).  
	self assert: (drivingAssistant throttleIsConnected). 
	self deny: (drivingAssistant brakesAreApplied). 
	
	self assert: (speedToKeep ) equals: (20* kilometer /hour ). 
	self assertDrivingSystemBeepIsOff.  
	self assertDrivingSystemThrottleIsOn. 
	self assertDrivingSystemBrakesAreOff. ! !

!DrivingAssistantTests methodsFor: 'tests' stamp: 'pau 7/6/2023 21:46:08'!
test15DrivingAssistantOnSemiAutomaticModeIsOnDangerZoneAndMovesToSafeZoneWithObjectiveVelocity

	| drivingAssistant |
	
	velocity := ReadStream on: {50*kilometer /hour . 70*kilometer/hour}. 
	proximity :=  ReadStream on: {10*meter. 10000*meter}. 
	
	drivingAssistant := DrivingAssistant onMode: (SemiAutomatic withObjetiveVelocityOf: (100*kilometer /hour )) 
									withSensorSystem:  self withDrivingSystem: self. 
	
	drivingAssistant tick. 
	drivingAssistant tick. 
	
	self assert: (drivingAssistant actualVelocity) equals: (70*kilometer /hour). 
	
	self assert:  (drivingAssistant beepIsOff ).  
	self assert: (drivingAssistant throttleIsConnected). 
	self deny: (drivingAssistant brakesAreApplied). 
	
	self assert: (speedToKeep ) equals: (100* kilometer /hour ). 
	self assertDrivingSystemBeepIsOff.  
	self assertDrivingSystemThrottleIsOn. 
	self assertDrivingSystemBrakesAreOff. ! !


!DrivingAssistantTests methodsFor: 'sensorSystem' stamp: 'pau 7/6/2023 17:48:33'!
readProximitySensor
	^ proximity next
	! !

!DrivingAssistantTests methodsFor: 'sensorSystem' stamp: 'pau 7/6/2023 17:48:25'!
readVelocitySensor
	^ velocity next
	! !

!DrivingAssistantTests methodsFor: 'sensorSystem' stamp: 'pau 7/6/2023 21:12:54'!
setSensorSystemWith: velocityStream andWith: proximityStream
	velocity := velocityStream. 
	proximity :=  proximityStream. 
	! !


!DrivingAssistantTests methodsFor: 'drivingSystem' stamp: 'pau 7/6/2023 19:44:37'!
applyBrakes
	brakes := 	#on! !

!DrivingAssistantTests methodsFor: 'drivingSystem' stamp: 'pau 7/6/2023 19:49:07'!
connectThrottle
	throttle := #on! !

!DrivingAssistantTests methodsFor: 'drivingSystem' stamp: 'pau 7/6/2023 19:44:53'!
dangerProximityBeep
	
	beep := #danger! !

!DrivingAssistantTests methodsFor: 'drivingSystem' stamp: 'pau 7/6/2023 19:45:06'!
disconnectThrottle
	throttle := #off! !

!DrivingAssistantTests methodsFor: 'drivingSystem' stamp: 'pau 7/6/2023 19:45:22'!
keepSpeedAt: aVelocity
	speedToKeep := aVelocity .! !

!DrivingAssistantTests methodsFor: 'drivingSystem' stamp: 'pau 7/6/2023 19:45:31'!
releaseBrakes
	brakes := #off! !

!DrivingAssistantTests methodsFor: 'drivingSystem' stamp: 'pau 7/6/2023 21:44:27'!
semiAutomaticModeWithObjectiveVelocityOf20kmxHour

	^ SemiAutomatic withObjetiveVelocityOf: (20*kilometer/hour)! !

!DrivingAssistantTests methodsFor: 'drivingSystem' stamp: 'pau 7/6/2023 19:45:41'!
turnOffProximityBeep
	beep := #off! !

!DrivingAssistantTests methodsFor: 'drivingSystem' stamp: 'pau 7/6/2023 19:45:53'!
warningProximityBeep
	beep := #warning! !


!DrivingAssistantTests methodsFor: 'driving assistants' stamp: 'pau 7/6/2023 21:41:22'!
automaticModeWithObjectiveSpeedOf20kmxHour

	^ Automatic withObjetiveVelocityOf: (20*kilometer/hour)! !

!DrivingAssistantTests methodsFor: 'driving assistants' stamp: 'pau 7/6/2023 21:41:22'!
drivingAssistantOnAutomaticMode

	^ DrivingAssistant onMode: self automaticModeWithObjectiveSpeedOf20kmxHour withSensorSystem: self withDrivingSystem: self! !

!DrivingAssistantTests methodsFor: 'driving assistants' stamp: 'pau 7/6/2023 21:43:18'!
manualDrivingAssistant

	^ DrivingAssistant onMode: (Manual new) withSensorSystem: self withDrivingSystem: self! !


!DrivingAssistantTests methodsFor: 'setUp' stamp: 'pau 7/6/2023 19:50:38'!
setUp
	self connectThrottle. 
	self releaseBrakes. 
	self turnOffProximityBeep. 
	! !


!DrivingAssistantTests methodsFor: 'asserts' stamp: 'pau 7/6/2023 21:46:48'!
assertDrinvingSystemIsOnWarning

	^ self assert:  (beep = #warning)! !

!DrivingAssistantTests methodsFor: 'asserts' stamp: 'pau 7/6/2023 21:45:26'!
assertDrivingSystemBeepIsOff

	^ self assert:  (beep = #off)! !

!DrivingAssistantTests methodsFor: 'asserts' stamp: 'pau 7/6/2023 21:47:08'!
assertDrivingSystemBeepIsOnDanger

	^ self assert:  (beep = #danger)! !

!DrivingAssistantTests methodsFor: 'asserts' stamp: 'pau 7/6/2023 21:46:08'!
assertDrivingSystemBrakesAreOff

	^ self assert: (brakes = #off)! !

!DrivingAssistantTests methodsFor: 'asserts' stamp: 'pau 7/6/2023 21:45:48'!
assertDrivingSystemThrottleIsOn

	^ self assert: (throttle = #on)! !


!classDefinition: #DrivingSystemModeTests category: 'ISW1-2023-1C-2doParcial'!
TestCase subclass: #DrivingSystemModeTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-2doParcial'!

!DrivingSystemModeTests methodsFor: 'as yet unclassified' stamp: 'pau 7/6/2023 20:34:12'!
test01ObjetiveVelocityOfAManualModeRaiseError
	
	self should: [(Manual new) objectiveVelocity ] 
	raise:  Error 
	withExceptionDo: [:anError| self assert: (anError messageText ) equals: Manual errorManualModeDontHaveObjetiveVelocity ]


	
	! !

!DrivingSystemModeTests methodsFor: 'as yet unclassified' stamp: 'pau 7/6/2023 20:37:39'!
test02CannotCreateAutomaticModeWithNegativeVelocity
	
	self should: [Automatic withObjetiveVelocityOf: (-200*kilometer /hour)] 
	raise:  Error 
	withExceptionDo: [:anError| self assert: (anError messageText ) equals: Automatic errorCannotCreateWithNegativeVelocity ]


	
	! !

!DrivingSystemModeTests methodsFor: 'as yet unclassified' stamp: 'pau 7/6/2023 20:42:02'!
test03CannotCreateAutomaticModeWithZeroVelocity
	
	self should: [Automatic withObjetiveVelocityOf: (0*kilometer /hour)] 
	raise:  Error 
	withExceptionDo: [:anError| self assert: (anError messageText ) equals: Automatic errorCannotCreateWithNegativeVelocity ]


	
	! !

!DrivingSystemModeTests methodsFor: 'as yet unclassified' stamp: 'pau 7/6/2023 20:42:09'!
test04CannotCreateSemiAutomaticModeWithNegativeVelocity
	
	self should: [SemiAutomatic withObjetiveVelocityOf: (-200*kilometer /hour)] 
	raise:  Error 
	withExceptionDo: [:anError| self assert: (anError messageText ) equals: SemiAutomatic errorCannotCreateWithNegativeVelocity ]


	
	! !

!DrivingSystemModeTests methodsFor: 'as yet unclassified' stamp: 'pau 7/6/2023 20:42:20'!
test05CannotCreateSemiAutomaticModeWithZeroVelocity
	
	self should: [SemiAutomatic withObjetiveVelocityOf: (0*kilometer /hour)] 
	raise:  Error 
	withExceptionDo: [:anError| self assert: (anError messageText ) equals: SemiAutomatic errorCannotCreateWithNegativeVelocity ]


	
	! !


!classDefinition: #DrivingAssistant category: 'ISW1-2023-1C-2doParcial'!
Object subclass: #DrivingAssistant
	instanceVariableNames: 'mode sensorsystem drivingsystem actualVelocity proximityFromCar beep objetiveVelocity throttleIsConnected brakesOn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-2doParcial'!

!DrivingAssistant methodsFor: 'initialization' stamp: 'pau 7/6/2023 19:17:23'!
initializeOnMode: aMode withSensorSystem: aSensorSystem withDrivingSystem: aDrivingSystem   

	mode := aMode.
	sensorsystem := aSensorSystem . 
	drivingsystem := aDrivingSystem . 
	actualVelocity := 0*kilometer /hour . 
	throttleIsConnected := true. 
	beep := #off. 
	brakesOn := false. 
	
	(aMode isKindOf: Manual)  ifFalse: [objetiveVelocity := aMode objectiveVelocity ]! !


!DrivingAssistant methodsFor: 'testing' stamp: 'pau 7/6/2023 18:41:16'!
actualVelocity
	
	^actualVelocity ! !

!DrivingAssistant methodsFor: 'testing' stamp: 'pau 7/6/2023 18:19:27'!
beepIsOff
	^ (beep = #off)! !

!DrivingAssistant methodsFor: 'testing' stamp: 'pau 7/6/2023 18:23:05'!
beepIsOnDanger
	^ (beep = #danger)! !

!DrivingAssistant methodsFor: 'testing' stamp: 'pau 7/6/2023 18:19:36'!
beepIsOnWarning
	^ (beep = #warning)! !

!DrivingAssistant methodsFor: 'testing' stamp: 'pau 7/6/2023 19:02:13'!
brakesAreApplied
	^brakesOn! !

!DrivingAssistant methodsFor: 'testing' stamp: 'pau 7/6/2023 18:55:19'!
objetiveVelocity
	^ objetiveVelocity ! !

!DrivingAssistant methodsFor: 'testing' stamp: 'pau 7/6/2023 19:00:13'!
throttleIsConnected
	^throttleIsConnected ! !


!DrivingAssistant methodsFor: 'tick' stamp: 'pau 7/6/2023 18:38:52'!
calculateDMF

	^(actualVelocity )^2 / (180000*kilometer / (hour^2)). 

	! !

!DrivingAssistant methodsFor: 'tick' stamp: 'pau 7/6/2023 20:50:12'!
isInDangerZone: dmf

	^ proximityFromCar < dmf! !

!DrivingAssistant methodsFor: 'tick' stamp: 'pau 7/6/2023 20:47:59'!
isInSafeZone: dmf
	^(proximityFromCar > (dmf *2))
	
	! !

!DrivingAssistant methodsFor: 'tick' stamp: 'pau 7/6/2023 20:47:19'!
isInWarningZone: dmf
	^(proximityFromCar > dmf and: [proximityFromCar <= (2*dmf)])
	
	! !

!DrivingAssistant methodsFor: 'tick' stamp: 'pau 7/6/2023 18:47:02'!
readSensorSystem

	actualVelocity := sensorsystem readVelocitySensor. 
	proximityFromCar := sensorsystem readProximitySensor! !

!DrivingAssistant methodsFor: 'tick' stamp: 'pau 7/6/2023 20:50:25'!
tick
	
	| dmf |
	self readSensorSystem. 
	
	dmf := self calculateDMF . 
	(self isInSafeZone: dmf) ifTrue: [ mode onSafeZoneReactOn: self. ]. 
	(self isInWarningZone: dmf) ifTrue: [  mode onWarningZoneReactOn: self. ].
	((self isInDangerZone: dmf)) ifTrue: [mode onDangerZoneReactOn: self. ]. 
	
	! !


!DrivingAssistant methodsFor: 'reactToTick-private' stamp: 'pau 7/6/2023 20:06:03'!
onDangerZoneReactOnAutomaticMode
	
	| newVelocity |
	newVelocity := actualVelocity - (10*kilometer/hour). 
	throttleIsConnected := false. 
	brakesOn:= true. 
	drivingsystem keepSpeedAt: newVelocity. 
	drivingsystem disconnectThrottle. 
	drivingsystem applyBrakes. ! !

!DrivingAssistant methodsFor: 'reactToTick-private' stamp: 'pau 7/6/2023 19:28:53'!
onDangerZoneReactOnManualMode
	beep := #danger.  
	drivingsystem dangerProximityBeep. ! !

!DrivingAssistant methodsFor: 'reactToTick-private' stamp: 'pau 7/6/2023 20:30:09'!
onDangerZoneReactOnSemiAutomaticMode
	self onDangerZoneReactOnManualMode. 
	self onDangerZoneReactOnAutomaticMode. ! !

!DrivingAssistant methodsFor: 'reactToTick-private' stamp: 'pau 7/6/2023 20:16:53'!
onSafeZoneReactOnAutomaticMode
	
	throttleIsConnected := true. 
	brakesOn := false. 
	beep := #off. 
	drivingsystem keepSpeedAt: objetiveVelocity. 
	drivingsystem releaseBrakes. 
	drivingsystem connectThrottle. 
	drivingsystem turnOffProximityBeep. 
	
	! !

!DrivingAssistant methodsFor: 'reactToTick-private' stamp: 'pau 7/6/2023 19:22:15'!
onSafeZoneReactOnManualMode
	beep := #off. 
	drivingsystem turnOffProximityBeep.! !

!DrivingAssistant methodsFor: 'reactToTick-private' stamp: 'pau 7/6/2023 19:34:55'!
onSafeZoneReactOnSemiAutomaticMode
	self onSafeZoneReactOnManualMode . 
	self onSafeZoneReactOnAutomaticMode . ! !

!DrivingAssistant methodsFor: 'reactToTick-private' stamp: 'pau 7/6/2023 20:06:25'!
onWarningZoneReactOnAutomaticMode
	
	| newVelocity |
	newVelocity := actualVelocity - (5*kilometer/hour ). 
	throttleIsConnected := false. 
	brakesOn:= false. 
	drivingsystem keepSpeedAt:newVelocity . 
	drivingsystem disconnectThrottle. 
	drivingsystem releaseBrakes. ! !

!DrivingAssistant methodsFor: 'reactToTick-private' stamp: 'pau 7/6/2023 19:25:22'!
onWarningZoneReactOnManualMode
	beep := #warning.
	drivingsystem warningProximityBeep.! !

!DrivingAssistant methodsFor: 'reactToTick-private' stamp: 'pau 7/6/2023 20:01:40'!
onWarningZoneReactOnWarningZone
	self onWarningZoneReactOnManualMode . 
	self onWarningZoneReactOnAutomaticMode. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DrivingAssistant class' category: 'ISW1-2023-1C-2doParcial'!
DrivingAssistant class
	instanceVariableNames: ''!

!DrivingAssistant class methodsFor: 'instance creation' stamp: 'pau 7/6/2023 18:43:07'!
onMode: aMode withSensorSystem: aSensorSystem withDrivingSystem: aDrivingSystem   
	
	
	^self new initializeOnMode: aMode withSensorSystem: aSensorSystem withDrivingSystem: aDrivingSystem ! !


!classDefinition: #DrivingSystemMode category: 'ISW1-2023-1C-2doParcial'!
Object subclass: #DrivingSystemMode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-2doParcial'!

!DrivingSystemMode methodsFor: 'objective velocity' stamp: 'pau 7/6/2023 20:19:56'!
objectiveVelocity
	^self subclassResponsibility. ! !


!DrivingSystemMode methodsFor: 'react to zone' stamp: 'pau 7/6/2023 20:41:11'!
onDangerZoneReactOn: aDrivingAssistant
	self subclassResponsibility ! !

!DrivingSystemMode methodsFor: 'react to zone' stamp: 'pau 7/6/2023 20:41:18'!
onSafeZoneReactOn: aDrivingAssistant
	self subclassResponsibility ! !

!DrivingSystemMode methodsFor: 'react to zone' stamp: 'pau 7/6/2023 20:41:23'!
onWarningZoneReactOn: aDrivingAssistant
	self subclassResponsibility ! !


!classDefinition: #Automatic category: 'ISW1-2023-1C-2doParcial'!
DrivingSystemMode subclass: #Automatic
	instanceVariableNames: 'objectiveVelocity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-2doParcial'!

!Automatic methodsFor: 'initialization' stamp: 'pau 7/6/2023 17:37:56'!
initializeWithObjetiveVelocityOf: aVelocity 
	objectiveVelocity := aVelocity.! !


!Automatic methodsFor: 'object velocity' stamp: 'pau 7/6/2023 17:40:16'!
objectiveVelocity
	^objectiveVelocity ! !


!Automatic methodsFor: 'on zone react -double dispatch' stamp: 'pau 7/6/2023 19:31:15'!
onDangerZoneReactOn: aDrivingAssistant
	
	aDrivingAssistant onDangerZoneReactOnAutomaticMode. ! !

!Automatic methodsFor: 'on zone react -double dispatch' stamp: 'pau 7/6/2023 19:21:34'!
onSafeZoneReactOn: aDrivingAssistant
	
	aDrivingAssistant onSafeZoneReactOnAutomaticMode. ! !

!Automatic methodsFor: 'on zone react -double dispatch' stamp: 'pau 7/6/2023 19:24:15'!
onWarningZoneReactOn: aDrivingAssistant
	
	aDrivingAssistant onWarningZoneReactOnAutomaticMode. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Automatic class' category: 'ISW1-2023-1C-2doParcial'!
Automatic class
	instanceVariableNames: ''!

!Automatic class methodsFor: 'instance creation' stamp: 'pau 7/6/2023 20:39:28'!
withObjetiveVelocityOf: aVelocity 

	self assertVelocityIsOverZero: aVelocity. 
	^self new initializeWithObjetiveVelocityOf: aVelocity ! !


!Automatic class methodsFor: 'error descriptions' stamp: 'pau 7/6/2023 20:36:41'!
errorCannotCreateWithNegativeVelocity
	^'Cannot create mode with negative velocity'! !


!Automatic class methodsFor: 'asserts' stamp: 'pau 7/6/2023 20:39:28'!
assertVelocityIsOverZero: aVelocity

	^ (aVelocity <= 0) ifTrue: [self error: self errorCannotCreateWithNegativeVelocity ]! !


!classDefinition: #Manual category: 'ISW1-2023-1C-2doParcial'!
DrivingSystemMode subclass: #Manual
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-2doParcial'!

!Manual methodsFor: 'object velocity' stamp: 'pau 7/6/2023 20:25:10'!
objectiveVelocity
	self error: (self class errorManualModeDontHaveObjetiveVelocity). ! !


!Manual methodsFor: 'on zone react -double dispatch' stamp: 'pau 7/6/2023 19:27:59'!
onDangerZoneReactOn: aDrivingAssistant
	
	aDrivingAssistant onDangerZoneReactOnManualMode. ! !

!Manual methodsFor: 'on zone react -double dispatch' stamp: 'pau 7/6/2023 19:21:39'!
onSafeZoneReactOn: aDrivingAssistant
	
	aDrivingAssistant onSafeZoneReactOnManualMode. ! !

!Manual methodsFor: 'on zone react -double dispatch' stamp: 'pau 7/6/2023 19:26:41'!
onWarningZoneReactOn: aDrivingAssistant
	
	aDrivingAssistant onWarningZoneReactOnManualMode. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Manual class' category: 'ISW1-2023-1C-2doParcial'!
Manual class
	instanceVariableNames: ''!

!Manual class methodsFor: 'error descriptions' stamp: 'pau 7/6/2023 20:23:57'!
errorManualModeDontHaveObjetiveVelocity
	^'manual mode dont have objective velocity'! !


!classDefinition: #SemiAutomatic category: 'ISW1-2023-1C-2doParcial'!
DrivingSystemMode subclass: #SemiAutomatic
	instanceVariableNames: 'objectiveVelocity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-2doParcial'!

!SemiAutomatic methodsFor: 'initialization' stamp: 'pau 7/6/2023 17:41:54'!
initializeWithObjetiveVelocityOf: aVelocity 
	objectiveVelocity := aVelocity.! !


!SemiAutomatic methodsFor: 'object velocity' stamp: 'pau 7/6/2023 17:41:44'!
objectiveVelocity
	^objectiveVelocity ! !


!SemiAutomatic methodsFor: 'on zone react -double dispatch' stamp: 'pau 7/6/2023 20:29:40'!
onDangerZoneReactOn: aDrivingAssistant 
	aDrivingAssistant onDangerZoneReactOnSemiAutomaticMode! !

!SemiAutomatic methodsFor: 'on zone react -double dispatch' stamp: 'pau 7/6/2023 19:21:44'!
onSafeZoneReactOn: aDrivingAssistant
	
	aDrivingAssistant onSafeZoneReactOnSemiAutomaticMode. ! !

!SemiAutomatic methodsFor: 'on zone react -double dispatch' stamp: 'pau 7/6/2023 20:01:13'!
onWarningZoneReactOn: aDrivingAssistant 
	aDrivingAssistant onWarningZoneReactOnWarningZone! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SemiAutomatic class' category: 'ISW1-2023-1C-2doParcial'!
SemiAutomatic class
	instanceVariableNames: ''!

!SemiAutomatic class methodsFor: 'error descriptios' stamp: 'pau 7/6/2023 20:38:31'!
errorCannotCreateWithNegativeVelocity
	^'cannot create mode with negative velocity'! !


!SemiAutomatic class methodsFor: 'instance creation' stamp: 'pau 7/6/2023 20:40:19'!
withObjetiveVelocityOf: aVelocity 

	self assertVelocityIsOverZero: aVelocity. 
	
	^self new initializeWithObjetiveVelocityOf: aVelocity ! !


!SemiAutomatic class methodsFor: 'asserts' stamp: 'pau 7/6/2023 20:40:19'!
assertVelocityIsOverZero: aVelocity

	^ (aVelocity <= 0) ifTrue: [self error: self errorCannotCreateWithNegativeVelocity ]! !
