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

!CustomerBookTest methodsFor: 'testing' stamp: 'Pau 4/10/2023 21:48:18'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook addCustomerJohnLennon|
	
	customerBook := CustomerBook new.

	addCustomerJohnLennon := [customerBook addCustomerNamed: 'John Lennon']. 
	
	self assertIfValueOf: addCustomerJohnLennon takesLessThan: (50 * millisecond). 
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Pau 4/10/2023 21:48:34'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook removeCustomerPaulMcCartney |
	
	customerBook := CustomerBook new.
	
	customerBook addCustomerNamed: 'Paul McCartney'.
	
	removeCustomerPaulMcCartney := [customerBook removeCustomerNamed: 'Paul McCartney'.]. 
	
	self assertIfValueOf: removeCustomerPaulMcCartney takesLessThan: (100 * millisecond).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Pau 4/11/2023 15:45:21'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook addEmptyCustomer customerBookIsEmpty errorMessageTextIsCustomerCanNotBeEmptyErrorMessage |
			
	customerBook := CustomerBook new.
	
	addEmptyCustomer := [ customerBook addCustomerNamed: ''.].
	" fletamos el error mess????" 
	errorMessageTextIsCustomerCanNotBeEmptyErrorMessage := 
		[:anError | anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.]. 
		
	customerBookIsEmpty := [customerBook isEmpty ].
	
	self assertIfExeptionRaisedBy: addEmptyCustomer 
		isOfType: Error 
		andVerifyIf:  errorMessageTextIsCustomerCanNotBeEmptyErrorMessage 
		and: customerBookIsEmpty.  
	 
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Pau 4/11/2023 15:55:17'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook removeCustomerPaulMcCartney customerBookHasOnlyOneCustomer johnLennonIsCustomer |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.
	removeCustomerPaulMcCartney := [customerBook removeCustomerNamed: 'Paul McCartney'.].
	"queremos no tener este parametro"
	customerBookHasOnlyOneCustomer := [:anError | customerBook numberOfCustomers = 1].
	johnLennonIsCustomer := [customerBook includesCustomerNamed: 'John Lennon'].
	
	self assertIfExeptionRaisedBy:  removeCustomerPaulMcCartney 
		isOfType:  NotFound 
		andVerifyIf:  (customerBookHasOnlyOneCustomer)
		and: johnLennonIsCustomer.
	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Pau 4/11/2023 16:16:03'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook|
	
	customerBook := CustomerBook new.
	
	self addAndSuspendCustomer: 'Paul McCartney' from: customerBook. 
	
	self assertIfCustomerBook: customerBook 
		hasNumberOfActiveCustomers: 0 
		NumberOfSuspendedCustomers: 1 
		NumberOfTotalCustomers: 1.

	self assertIfPaulMcCartneyInCustomerBook: customerBook.
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Pau 4/11/2023 16:16:16'!
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

!CustomerBookTest methodsFor: 'testing' stamp: 'Pau 4/11/2023 16:27:52'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennonInCustomerBook suspendGeorgeHarrison customerBookHasOnlyOneCustomer |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.
	suspendGeorgeHarrison := [ customerBook suspendCustomerNamed: 'George Harrison'.].
	customerBookHasOnlyOneCustomer := [:a | customerBook numberOfCustomers = 1].
	johnLennonInCustomerBook := [customerBook includesCustomerNamed: 'John Lennon'.].
	
	self assertIfExeptionRaisedBy: suspendGeorgeHarrison
		isOfType: CantSuspend 
		andVerifyIf:  customerBookHasOnlyOneCustomer 
		and: johnLennonInCustomerBook. 
		! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Pau 4/11/2023 16:28:03'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook customerBookHasOnlyOneCustomer johnLennonInCustomerBook suspendJohnLennon |
			
	customerBook := CustomerBook new.
	self addAndSuspendCustomer: 'John Lennon' from: customerBook .
	
	suspendJohnLennon := [ customerBook suspendCustomerNamed: 'John Lennon'.].
	customerBookHasOnlyOneCustomer := [:a | customerBook numberOfCustomers = 1].
	johnLennonInCustomerBook := [customerBook includesCustomerNamed: 'John Lennon'.].
	
	self assertIfExeptionRaisedBy: suspendJohnLennon
		isOfType: CantSuspend 
		andVerifyIf:  customerBookHasOnlyOneCustomer 
		and: johnLennonInCustomerBook. 
		
! !


!CustomerBookTest methodsFor: 'xxx' stamp: 'Pau 4/11/2023 16:01:53'!
addAndSuspendCustomer: customerName from: customerBook
	customerBook addCustomerNamed: customerName.
	customerBook suspendCustomerNamed: customerName.! !

!CustomerBookTest methodsFor: 'xxx' stamp: 'Pau 4/11/2023 16:09:09'!
assertIfCustomerBook: customerBook hasNumberOfActiveCustomers: nActive NumberOfSuspendedCustomers: nSuspended NumberOfTotalCustomers: nTotal
	
	self assert: nActive equals: customerBook numberOfActiveCustomers.
	self assert: nSuspended equals: customerBook numberOfSuspendedCustomers.
	self assert: nTotal equals: customerBook numberOfCustomers.
	
	
	"self deny: (customerBook includesCustomerNamed: 'Paul McCartney')."! !

!CustomerBookTest methodsFor: 'xxx' stamp: 'Pau 4/11/2023 16:38:30'!
assertIfExeptionRaisedBy: closure isOfType: errorType andVerifyIf: condition1 and: condition2  

	(self forceExceptionIfActionDindtFail: closure) 
		on: errorType 
		do: [ :anError |  
				self assert: (condition1 value: anError).
				self assert: condition2 ]! !

!CustomerBookTest methodsFor: 'xxx' stamp: 'Pau 4/11/2023 16:15:24'!
assertIfPaulMcCartneyInCustomerBook: customerBook

	^ self assert: (customerBook includesCustomerNamed: 'Paul McCartney')! !

!CustomerBookTest methodsFor: 'xxx' stamp: 'Pau 4/11/2023 16:15:49'!
assertIfPaulMcCartneyNotInCustomerBook: customerBook

	^ self deny: (customerBook includesCustomerNamed: 'Paul McCartney')! !

!CustomerBookTest methodsFor: 'xxx' stamp: 'Pau 4/10/2023 21:47:22'!
assertIfValueOf: closure takesLessThan: amount 
	^ self assert: ((self measureExecutionTime: closure) < amount). ! !

!CustomerBookTest methodsFor: 'xxx' stamp: 'Pau 4/11/2023 15:32:18'!
forceExceptionIfActionDindtFail: action
"che esto deberia ser algo forceItToFailIf ANDA MAL "
	^[action value. [self fail.] value].! !

!CustomerBookTest methodsFor: 'xxx' stamp: 'Pau 4/10/2023 21:08:29'!
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

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

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
