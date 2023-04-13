!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'Pau 4/12/2023 18:13:48'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook addCustomerJohnLennon|
	
	customerBook := CustomerBook new.

	addCustomerJohnLennon := [customerBook addCustomerNamed: 'John Lennon']. 
	
	self assertIfValueOf: addCustomerJohnLennon takesLessThan: (50 * millisecond). 
	

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'lucy 4/13/2023 11:46:14'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	
	| customerBook removeCustomerPaulMcCartney |
	
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'Paul McCartney'.
	
	removeCustomerPaulMcCartney := [customerBook removeCustomerNamed: 'Paul McCartney'.]. 
	
	self assertIfValueOf: removeCustomerPaulMcCartney takesLessThan: (100 * millisecond).
	

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'lucy 4/13/2023 12:01:09'!
test03CanNotAddACustomerWithEmptyName 
	
	| customerBook addEmptyCustomer customerBookIsEmpty errorMessageIsCustomerCanNotBeEmpty |
			
	customerBook := CustomerBook new.
	addEmptyCustomer := [ customerBook addCustomerNamed: ''].
	errorMessageIsCustomerCanNotBeEmpty := [ :anError | anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage]. 
	customerBookIsEmpty := [customerBook isEmpty ].
	
	self assertIfExeptionRaisedBy: addEmptyCustomer
		isOfType: Error
		andVerify: [errorMessageIsCustomerCanNotBeEmpty.
				  customerBookIsEmpty].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'lucy 4/13/2023 12:07:14'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook removePaulMcCartney |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.
	removePaulMcCartney := [customerBook removeCustomerNamed: 'Paul McCartney'].
	
	self assertIfExeptionRaisedBy: removePaulMcCartney 
		isOfType: NotFound
		andVerify: (self assertIfJohnLennonIsOnlyCustomer: customerBook)
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Pau 4/12/2023 18:25:57'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook|
	
	customerBook := CustomerBook new.
	
	self addAndSuspendCustomer: 'Paul McCartney' from: customerBook. 
	
	self assertIfCustomerBook: customerBook 
		hasNumberOfActiveCustomers: 0 
		NumberOfSuspendedCustomers: 1 
		NumberOfTotalCustomers: 1.

	self assertIfPaulMcCartneyInCustomerBook: customerBook.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Pau 4/12/2023 18:26:27'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self addAndSuspendCustomer: 'Paul McCartney' from: customerBook. 
	customerBook removeCustomerNamed: 'Paul McCartney'.
	
	self assertIfCustomerBook: customerBook 
		hasNumberOfActiveCustomers:  0
		NumberOfSuspendedCustomers:  0
		NumberOfTotalCustomers: 0.
		
	self assertIfPaulMcCartneyNotInCustomerBook: customerBook.


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'lucy 4/13/2023 12:09:24'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook suspendGeorgeHarrison |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.
	suspendGeorgeHarrison := [ customerBook suspendCustomerNamed: 'George Harrison'].
	
	self assertIfExeptionRaisedBy: suspendGeorgeHarrison
		isOfType: CantSuspend 
		andVerify: (self assertIfJohnLennonIsOnlyCustomer: customerBook)! !

!CustomerBookTest methodsFor: 'testing' stamp: 'lucy 4/13/2023 12:10:06'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook suspendJohnLennon |
			
	customerBook := CustomerBook new.
	self addAndSuspendCustomer: 'John Lennon' from: customerBook .
	
	suspendJohnLennon := [ customerBook suspendCustomerNamed: 'John Lennon'.].
	
	self assertIfExeptionRaisedBy: suspendJohnLennon
		isOfType: CantSuspend 
		andVerify: (self assertIfJohnLennonIsOnlyCustomer: customerBook)
! !


!CustomerBookTest methodsFor: 'testingAid' stamp: 'Pau 4/12/2023 18:06:33'!
addAndSuspendCustomer: customerName from: customerBook
	customerBook addCustomerNamed: customerName.
	customerBook suspendCustomerNamed: customerName.! !

!CustomerBookTest methodsFor: 'testingAid' stamp: 'pau 4/13/2023 15:57:16'!
assertIfCustomerBook: customerBook hasNumberOfActiveCustomers: nActive NumberOfSuspendedCustomers: nSuspended NumberOfTotalCustomers: nTotal
	
	self assert: nActive equals: customerBook numberOfActiveCustomers.
	self assert: nSuspended equals: customerBook numberOfSuspendedCustomers.
	self assert: nTotal equals: customerBook numberOfCustomers.
	! !

!CustomerBookTest methodsFor: 'testingAid' stamp: 'Pau 4/12/2023 18:03:04'!
assertIfExeptionRaisedBy: action isOfType: errorType andVerify: asserts  
	
	(self forceExceptionIfActionDindtFail: action) 
		on: errorType
		do: asserts.! !

!CustomerBookTest methodsFor: 'testingAid' stamp: 'lucy 4/13/2023 12:06:47'!
assertIfJohnLennonIsOnlyCustomer: customerBook

	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: 'John Lennon')! !

!CustomerBookTest methodsFor: 'testingAid' stamp: 'Pau 4/12/2023 18:07:09'!
assertIfPaulMcCartneyInCustomerBook: customerBook

	^ self assert: (customerBook includesCustomerNamed: 'Paul McCartney')! !

!CustomerBookTest methodsFor: 'testingAid' stamp: 'Pau 4/12/2023 18:07:26'!
assertIfPaulMcCartneyNotInCustomerBook: customerBook

	^ self deny: (customerBook includesCustomerNamed: 'Paul McCartney')! !

!CustomerBookTest methodsFor: 'testingAid' stamp: 'Pau 4/12/2023 17:44:21'!
assertIfValueOf: closure takesLessThan: amount 
	^ self assert: ((self measureExecutionTime: closure) < amount). ! !

!CustomerBookTest methodsFor: 'testingAid' stamp: 'pau 4/13/2023 15:57:48'!
forceExceptionIfActionDindtFail: action
	^[action value. [self fail.] value].! !

!CustomerBookTest methodsFor: 'testingAid' stamp: 'pau 4/13/2023 15:58:03'!
measureExecutionTime: closure
	| millisecondsBeforeRunning millisecondsAfterRunning|
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	closure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^ millisecondsAfterRunning - millisecondsBeforeRunning.! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'Pau 4/13/2023 08:54:25'!
isEmpty
	
	^self numberOfCustomers  = 0.
! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'lucy 4/13/2023 11:33:00'!
addCustomerNamed: aName

	self signalIfCustomerNameIsEmpty: aName.
	self signalIfCustomerNameAlreadyExists: aName.
	
	active add: aName 
! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'Pau 4/12/2023 18:24:47'!
numberOfCustomers
	
	^ (self numberOfActiveCustomers)  + (self numberOfSuspendedCustomers )! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'pau 4/13/2023 15:36:43'!
removeCustomerNamed: aName 
	
	(self couldRemoveCustomerFromActiveAndSuspendedCollections: aName) ifTrue: [^aName]. 
	
	^ NotFound signal.



! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'lucy 4/13/2023 11:39:40'!
suspendCustomerNamed: aName 
	
	active remove: aName ifAbsent: [^CantSuspend signal].
	suspended add: aName
! !


!CustomerBook methodsFor: 'private' stamp: 'pau 4/13/2023 15:36:27'!
couldRemoveCustomerFromActiveAndSuspendedCollections: aName

	^ (self removeCustomerNamed: aName ifStatusInCustomerBookIs: active) 
	or: 
	[self removeCustomerNamed: aName ifStatusInCustomerBookIs: suspended]! !

!CustomerBook methodsFor: 'private' stamp: 'pau 4/13/2023 15:44:39'!
removeCustomerNamed: aName ifStatusInCustomerBookIs: aStatusCollection
	
	1 to: aStatusCollection size do: 
	[ :index | aName = (aStatusCollection at: index) 
				ifTrue: [ aStatusCollection removeAt: index. ^ true]].
	^false.
! !

!CustomerBook methodsFor: 'private' stamp: 'lucy 4/13/2023 11:32:07'!
signalIfCustomerNameAlreadyExists: aName

	^ (self includesCustomerNamed: aName) ifTrue: 
		[ self signalCustomerAlreadyExists ]! !

!CustomerBook methodsFor: 'private' stamp: 'Pau 4/13/2023 09:41:03'!
signalIfCustomerNameIsEmpty: aName

	^ (aName isEmpty) ifTrue: 
		[ self signalCustomerNameCannotBeEmpty ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
