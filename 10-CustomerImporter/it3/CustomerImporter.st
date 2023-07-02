!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'pau 7/1/2023 21:15:02'!
test01ImportValidTextFileWith2Customers

	CustomerImporter valueFrom: self validImportData using: system.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'pau 7/1/2023 21:12:34'!
test02ImportEmptyCSVRaiseErrorAndDontImportAnything

	self shouldNotImportCustomersFrom:  self emptyImportData  
		andRaise:  CustomerImporter errorCannotReadAnEmptyFile.
	
	
	
	
	! !

!ImportTest methodsFor: 'tests' stamp: 'pau 6/28/2023 16:52:35'!
test03ImportCSVwithWrongFormatRaiseErrorAndDontImportAnything

	self shouldNotImportCustomersFrom:  self invalidImportData
		andRaise: CustomerImporter errorWrongType.
	
	
	
	! !

!ImportTest methodsFor: 'tests' stamp: 'pau 6/28/2023 16:59:09'!
test04ImportCSVwithEmptyLineRaiseErrorAndDontImportAnything

	self shouldImportPepeWithNoAddressesFrom: self invalidImportDataWithEmptyLine.
		
	
	
	
	! !

!ImportTest methodsFor: 'tests' stamp: 'pau 6/28/2023 16:59:30'!
test05ImportCSVwithTwoCommasFormatRaiseError

	self shouldImportPepeWithNoAddressesFrom: self invalidImportDataWith2Commas.
	
	
	! !

!ImportTest methodsFor: 'tests' stamp: 'pau 6/28/2023 16:53:15'!
test06ImportCSVwithTypeThatStartsWithCRaiseError

	self shouldNotImportCustomersFrom: self invalidImportDataWithCustomerAsType
		andRaise: CustomerImporter errorWrongType.
	
	
	! !

!ImportTest methodsFor: 'tests' stamp: 'pau 6/28/2023 16:53:46'!
test07ImportCSVwithAddressesButNoCustomers
	
	self shouldNotImportCustomersFrom:  self invalidImportDataWithoutCustomers 
		andRaise: CustomerImporter errorNoCustomerForAddress.
	
	
	
	! !

!ImportTest methodsFor: 'tests' stamp: 'pau 6/28/2023 17:04:55'!
test08importCSVWithAnAddressThatHasNoStreetNumber
	
	self shouldImportPepeWithNoAddressesFrom: self invalidImportDataWithoutStreetNumber 
		andRaise: CustomerImporter errorInvalidFormat . 
	
	
	
	! !

!ImportTest methodsFor: 'tests' stamp: 'pau 6/28/2023 17:05:15'!
test09importCSVWithACustomerThatHasAnExtraField
	
	self shouldNotImportCustomersFrom:  self invalidImportDataWithExtraField 
		andRaise: CustomerImporter errorInvalidFormat. 
	
	
	! !

!ImportTest methodsFor: 'tests' stamp: 'pau 6/28/2023 16:59:58'!
test10ImportCSVWithStringOnNumberFieldOnAddressEntry
	
	self shouldImportPepeWithNoAddressesFrom:  self invalidImportDataWithStringInNumberField.
	
	
	
	! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'pau 6/28/2023 16:42:32'!
assertDontImportCustomersAndFailsWith: anErrorMessage

	^[:errorMessage|  self assert: (errorMessage messageText) equals: anErrorMessage.
									self assertNoCustomersInSession ]! !

!ImportTest methodsFor: 'assertions' stamp: 'pau 6/29/2023 21:21:56'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (self session numberOfCustomers )! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'pau 6/29/2023 21:25:54'!
assertNoCustomersInSession

	^ self assert:( self session numberOfCustomers) equals: 0! !

!ImportTest methodsFor: 'assertions' stamp: 'pau 6/29/2023 21:26:13'!
assertPepeIsOnlyCustomerAndHasNoAddresses

	| pepeCustomer | 
		
			pepeCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
			self assert: pepeCustomer numberOfAddressesRegistered equals: 0. 
			self assert: (self session numberOfCustomers ) equals: 1! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !

!ImportTest methodsFor: 'assertions' stamp: 'pau 7/1/2023 21:15:30'!
shouldImportPepeWithNoAddressesFrom: textFile 

	self should: [
		CustomerImporter valueFrom: textFile using: self session.]
		raise: Error
	      withExceptionDo: [:errorMessage| self assertPepeIsOnlyCustomerAndHasNoAddresses. 
		]. 
	
	
	
	! !

!ImportTest methodsFor: 'assertions' stamp: 'pau 7/1/2023 21:15:30'!
shouldImportPepeWithNoAddressesFrom: textFile andRaise: anError

	^ self should: [
		CustomerImporter valueFrom: textFile using: self session.]
		raise: Error
	      withExceptionDo: [:errorMessage| 
				
				self assert: (errorMessage messageText) equals:  anError.
				self assertPepeIsOnlyCustomerAndHasNoAddresses. 
			]! !

!ImportTest methodsFor: 'assertions' stamp: 'pau 7/1/2023 21:15:30'!
shouldNotImportCustomersFrom: textFile andRaise: anError

	self should: [
		CustomerImporter valueFrom: textFile using: self session.]
		raise: Error
	      withExceptionDo: (self assertDontImportCustomersAndFailsWith: anError). 
	
	
	
	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'pau 6/29/2023 21:31:33'!
setUp
	
	system := CustomerService current new.
	system beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'pau 6/29/2023 21:31:33'!
tearDown

	system commit.
	system close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'pau 6/29/2023 21:23:23'!
customerWithIdentificationType: anIdType number: anIdNumber
	
	^ (self session) customerWithIdentificationType: anIdType number: anIdNumber . 
	! !


!ImportTest methodsFor: 'test data' stamp: 'pau 6/26/2023 19:40:29'!
emptyImportData

	^ ReadStream on:''! !

!ImportTest methodsFor: 'test data' stamp: 'pau 6/26/2023 19:52:45'!
invalidImportData

	^ ReadStream on:
'	C,Pepe,Sanchez,D,22333444
	A,San Martin,3322,Olivos,1636,BsAs
	A,Maipu,888,Florida,1122,Buenos Aires
	C,Juan,Perez,C,23-25666777-9
	A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'pau 6/28/2023 16:15:10'!
invalidImportDataWith2Commas

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,,
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'pau 6/26/2023 21:07:30'!
invalidImportDataWithCustomerAsType

	^ ReadStream on:
'Customer,Pepe,Sanchez,D,22333444,
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'pau 6/26/2023 21:46:07'!
invalidImportDataWithEmptyLine

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444,

A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'pau 6/26/2023 21:28:59'!
invalidImportDataWithExtraField

	^ ReadStream on:
'C,Pepe,Pepito,Sanchez,D,22333444,
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'pau 6/26/2023 21:35:54'!
invalidImportDataWithStringInNumberField

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444,
A,San Martin,holas,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'pau 6/26/2023 21:14:51'!
invalidImportDataWithoutCustomers

	^ ReadStream on:
'A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires'! !

!ImportTest methodsFor: 'test data' stamp: 'pau 6/26/2023 21:25:58'!
invalidImportDataWithoutStreetNumber

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444,
A,San Martin,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!ImportTest methodsFor: 'session' stamp: 'pau 6/29/2023 21:31:33'!
session
	^system session! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !

!Customer methodsFor: 'addresses' stamp: 'pau 6/26/2023 21:57:07'!
numberOfAddressesRegistered
	^addresses size! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream line newCustomer record system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'pau 6/29/2023 21:36:49'!
initializeFrom: aReadStream using: aCustomerSystem 
	readStream := aReadStream.
	system := aCustomerSystem. ! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'pau 6/26/2023 21:09:03'!
value

	(readStream isEmpty) ifTrue:[self error: (self class errorCannotReadAnEmptyFile )]. 
	
	[ self isThereALineToRead ] whileTrue: [
		
		self splitLineIntoRecord.
		
		self importRecord. ].

	! !


!CustomerImporter methodsFor: 'asserts' stamp: 'pau 6/28/2023 17:10:54'!
assertCorrectNumberOfFieldsForAddress

	^ (record size ~= 6) ifTrue: [self error: (self class errorInvalidFormat )]! !

!CustomerImporter methodsFor: 'asserts' stamp: 'pau 6/28/2023 17:07:46'!
assertCorrectUseOfSeparators

	^ (line includesSubString: ',,') ifTrue: [ self error: (self class errorInvalidFormat) ]! !

!CustomerImporter methodsFor: 'asserts' stamp: 'pau 6/28/2023 17:13:18'!
assertTheresAlreadyOneCustomerImported

	^ (newCustomer isNil) ifTrue: [ self error: (self class errorNoCustomerForAddress )]! !

!CustomerImporter methodsFor: 'asserts' stamp: 'pau 6/28/2023 17:10:30'!
assertValidNumberOfFieldsForCustomer

	^ (record size ~= 5) ifTrue: [self error: (self class errorInvalidFormat )]! !


!CustomerImporter methodsFor: 'evaluating-private' stamp: 'pau 6/28/2023 17:16:07'!
importRecord

	self isCustomerRecord 
		ifTrue: [
			self parseCustomerAndAddToSession ]
		ifFalse: [
			(self isAddressRecord) ifTrue: [
				self readAddressAndAddToSessionIfThereIsACorrespondingCustomer. 
			]
	ifFalse: [ self error: (self class errorWrongType)]
			].
	! !

!CustomerImporter methodsFor: 'evaluating-private' stamp: 'pau 6/26/2023 21:09:24'!
isAddressRecord

	^ record first= 'A'! !

!CustomerImporter methodsFor: 'evaluating-private' stamp: 'pau 6/26/2023 21:09:30'!
isCustomerRecord

	^ record first = 'C'! !

!CustomerImporter methodsFor: 'evaluating-private' stamp: 'pau 6/26/2023 21:05:48'!
isThereALineToRead

	line := readStream nextLine. 
	
	^line notNil! !

!CustomerImporter methodsFor: 'evaluating-private' stamp: 'pau 6/28/2023 17:12:14'!
parseAddress
	
	| newAddress streetNumber zipCode |
	self assertCorrectNumberOfFieldsForAddress.
	
	streetNumber := record third asNumber .
	zipCode := record fifth asNumber.
	
	newAddress := Address new. 
	newCustomer addAddress: newAddress.
	newAddress streetName: record second.
	newAddress streetNumber: streetNumber .
	newAddress town: record fourth.
	newAddress zipCode: zipCode .
	newAddress province: record sixth. ! !

!CustomerImporter methodsFor: 'evaluating-private' stamp: 'pau 6/28/2023 17:10:30'!
parseCustomer
	
	self assertValidNumberOfFieldsForCustomer.
	
	newCustomer := Customer new. 
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth. 
	! !

!CustomerImporter methodsFor: 'evaluating-private' stamp: 'pau 6/29/2023 21:35:34'!
parseCustomerAndAddToSession

	self parseCustomer.
	system persist: newCustomer! !

!CustomerImporter methodsFor: 'evaluating-private' stamp: 'pau 6/29/2023 21:35:41'!
readAddressAndAddToSessionIfThereIsACorrespondingCustomer

	self assertTheresAlreadyOneCustomerImported.
	self parseAddress! !

!CustomerImporter methodsFor: 'evaluating-private' stamp: 'pau 6/28/2023 17:07:46'!
splitLineIntoRecord
	
	self assertCorrectUseOfSeparators.
	
	record := line findTokens: $,! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'pau 6/29/2023 21:42:48'!
from: aReadStream using: aCustomerSystem
	^self new initializeFrom: aReadStream using: aCustomerSystem.! !


!CustomerImporter class methodsFor: 'importing' stamp: 'pau 7/1/2023 21:15:30'!
valueFrom: aReadStream using: aSystem

	^(self from: aReadStream using: aSystem) value! !


!CustomerImporter class methodsFor: 'error description' stamp: 'pau 6/26/2023 20:44:33'!
errorCannotReadAnEmptyFile
	^'cannot read an empty file'! !

!CustomerImporter class methodsFor: 'error description' stamp: 'pau 6/26/2023 21:02:05'!
errorInvalidFormat
	^'cannot read this file'! !

!CustomerImporter class methodsFor: 'error description' stamp: 'pau 6/26/2023 21:15:21'!
errorNoCustomerForAddress
	^'cannot load an address without a customer'! !

!CustomerImporter class methodsFor: 'error description' stamp: 'pau 6/26/2023 20:44:00'!
errorWrongType
	^'type doesnt exists'! !


!classDefinition: #CustomerService category: 'CustomerImporter'!
Object subclass: #CustomerService
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerService methodsFor: 'session' stamp: 'pau 7/1/2023 21:18:15'!
session
	^self! !


!CustomerService methodsFor: 'testing' stamp: 'pau 7/1/2023 21:21:42'!
customerWithIdentificationType: anIdType number: anIdNumber
	self subclassResponsibility ! !

!CustomerService methodsFor: 'testing' stamp: 'pau 7/1/2023 21:21:20'!
numberOfCustomers
	self subclassResponsibility ! !


!CustomerService methodsFor: 'database' stamp: 'pau 7/1/2023 21:20:54'!
beginTransaction
	self subclassResponsibility ! !

!CustomerService methodsFor: 'database' stamp: 'pau 7/1/2023 21:21:30'!
close
	self subclassResponsibility ! !

!CustomerService methodsFor: 'database' stamp: 'pau 7/1/2023 21:20:48'!
commit
	self subclassResponsibility ! !

!CustomerService methodsFor: 'database' stamp: 'pau 7/1/2023 21:21:02'!
persist: aCustomer
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerService class' category: 'CustomerImporter'!
CustomerService class
	instanceVariableNames: ''!

!CustomerService class methodsFor: 'as yet unclassified' stamp: 'pau 6/29/2023 21:06:26'!
current
	
	^ self subclasses detect: [:aSubclass| aSubclass isCurrent]! !


!classDefinition: #PersistentCustomerService category: 'CustomerImporter'!
CustomerService subclass: #PersistentCustomerService
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!


!PersistentCustomerService methodsFor: 'testing' stamp: 'pau 6/29/2023 21:20:33'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !

!PersistentCustomerService methodsFor: 'testing' stamp: 'pau 7/1/2023 21:17:14'!
numberOfCustomers
	^ (session selectAllOfType: Customer) size! !


!PersistentCustomerService methodsFor: 'database' stamp: 'pau 6/29/2023 20:30:06'!
beginTransaction
	session beginTransaction ! !

!PersistentCustomerService methodsFor: 'database' stamp: 'pau 6/29/2023 20:40:03'!
close
	session close! !

!PersistentCustomerService methodsFor: 'database' stamp: 'pau 6/29/2023 20:30:50'!
commit
	session commit! !

!PersistentCustomerService methodsFor: 'database' stamp: 'pau 6/29/2023 21:37:16'!
persist: aCustomer
	session persist: aCustomer ! !


!PersistentCustomerService methodsFor: 'initialize' stamp: 'pau 6/29/2023 20:28:11'!
initialize
	session:= DataBaseSession for: (Array with: Address with: Customer).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PersistentCustomerService class' category: 'CustomerImporter'!
PersistentCustomerService class
	instanceVariableNames: ''!

!PersistentCustomerService class methodsFor: 'as yet unclassified' stamp: 'pau 7/1/2023 21:16:29'!
isCurrent
	^true! !


!classDefinition: #TransientCustomerService category: 'CustomerImporter'!
CustomerService subclass: #TransientCustomerService
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!


!TransientCustomerService methodsFor: 'testing' stamp: 'pau 6/29/2023 21:25:19'!
customerWithIdentificationType: anIdType number: anIdNumber
	
	^ (customers select: [:customer| customer identificationType = anIdType and: [customer identificationNumber = anIdNumber]]) first
	! !

!TransientCustomerService methodsFor: 'testing' stamp: 'pau 6/29/2023 21:21:38'!
numberOfCustomers
	^customers size! !


!TransientCustomerService methodsFor: 'database' stamp: 'pau 6/29/2023 20:42:33'!
beginTransaction! !

!TransientCustomerService methodsFor: 'database' stamp: 'pau 6/29/2023 20:42:41'!
close! !

!TransientCustomerService methodsFor: 'database' stamp: 'pau 6/29/2023 20:42:53'!
commit! !

!TransientCustomerService methodsFor: 'database' stamp: 'pau 6/29/2023 20:49:02'!
persist: aCustomer
	customers add: aCustomer ! !


!TransientCustomerService methodsFor: 'initialization' stamp: 'pau 6/29/2023 20:48:17'!
initialize

	customers := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransientCustomerService class' category: 'CustomerImporter'!
TransientCustomerService class
	instanceVariableNames: ''!

!TransientCustomerService class methodsFor: 'as yet unclassified' stamp: 'pau 7/1/2023 21:16:23'!
isCurrent
	^false! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
