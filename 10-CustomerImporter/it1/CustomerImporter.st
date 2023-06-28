!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'pau 6/24/2023 18:19:41'!
test01TextFileWithTwoCustomersIsImportedCorrectly

	(ImportCustomer importCustomerOn: session from: self inputFileWithTwoCustomers) import. 
	
	self assert: (session selectAllOfType: Customer ) size equals: 2. 
	
	self customerPepeIsImplortedCorrectly.
	
	self customerJuanIsImportedCorrectly.
	
	
	
	
	
	
	
	
	! !


!ImportTest methodsFor: 'setUp' stamp: 'pau 6/22/2023 20:44:14'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.! !


!ImportTest methodsFor: 'tear down' stamp: 'pau 6/22/2023 20:34:27'!
tearDown

	session commit.
	session close! !


!ImportTest methodsFor: 'customers and addresses' stamp: 'pau 6/24/2023 17:20:02'!
customerJuan

	^ self selectCustomerWithId: 'C' number: '23-25666777-9'! !

!ImportTest methodsFor: 'customers and addresses' stamp: 'pau 6/24/2023 17:44:05'!
customerJuanIsImportedCorrectly

	self assert: self customerJuan hasName: 'Juan' lastName: 'Perez' hasAddresses: 1. 
	self assert: self customerJuan hasAddressWithStreet: 'Alem' number: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'! !

!ImportTest methodsFor: 'customers and addresses' stamp: 'pau 6/24/2023 17:23:53'!
customerPepe

	^ self selectCustomerWithId: 'D' number: '22333444'. 
	! !

!ImportTest methodsFor: 'customers and addresses' stamp: 'pau 6/24/2023 17:43:51'!
customerPepeIsImplortedCorrectly

	self assert: self customerPepe hasName: 'Pepe' lastName: 'Sanchez' hasAddresses: 2. 
	self assert: self customerPepe hasAddressWithStreet: 'San Martin' number: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assert: self customerPepe hasAddressWithStreet: 'Maipu' number: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'! !

!ImportTest methodsFor: 'customers and addresses' stamp: 'pau 6/24/2023 17:20:02'!
selectCustomerWithId: idType number: idNumber 

	^ (session select: [:customer| (customer identificationType = idType) and: [customer identificationNumber = idNumber] ] ofType: Customer) anyOne! !


!ImportTest methodsFor: 'asserts' stamp: 'pau 6/24/2023 17:38:02'!
assert: customer hasAddressWithStreet: streetName number: streetNumber town: town zipCode: zipCode province: province    
	
	self assert: (customer selectAddressesThatSatisfies: [:anAddress | anAddress  streetName = streetName and: 
											     anAddress streetNumber = streetNumber and:
												anAddress town  = town and: 
												anAddress zipCode  = zipCode and:
												anAddress province = province 
											]) notEmpty . ! !

!ImportTest methodsFor: 'asserts' stamp: 'pau 6/24/2023 17:03:51'!
assert: customer hasName: customerName lastName: customerLastName hasAddresses: amountOfAddresses  

	self assert: customer firstName equals: customerName.  
	self assert: customer lastName equals: customerLastName. 
	self assert: (customer amountOfAddressesRegistered ) equals:amountOfAddresses! !


!ImportTest methodsFor: 'inputFIle' stamp: 'pau 6/24/2023 18:07:19'!
inputFileWithTwoCustomers
	| textFile |
	textFile := 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'.
	
	^ ReadStream on: textFile from: 1 to: textFile size.! !


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

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !

!Customer methodsFor: 'addresses' stamp: 'pau 6/22/2023 21:57:25'!
amountOfAddressesRegistered
	^addresses size! !

!Customer methodsFor: 'addresses' stamp: 'pau 6/22/2023 21:56:29'!
selectAddressesThatSatisfies: aBlockCondition
	^addresses select: aBlockCondition ! !


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


!classDefinition: #ImportCustomer category: 'CustomerImporter'!
Object subclass: #ImportCustomer
	instanceVariableNames: 'databaseSession inputStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportCustomer methodsFor: 'initialization' stamp: 'pau 6/24/2023 18:17:07'!
initializeImportCustomerOn: aDatabaseSession from: anInputStream
	databaseSession := aDatabaseSession.
	inputStream := anInputStream.! !


!ImportCustomer methodsFor: 'evaluating' stamp: 'pau 6/24/2023 18:21:31'!
import
	| newCustomer line |
	
	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth .
			databaseSession persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := inputStream nextLine. ].

	inputStream close.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ImportCustomer class' category: 'CustomerImporter'!
ImportCustomer class
	instanceVariableNames: ''!

!ImportCustomer class methodsFor: 'instance creation' stamp: 'pau 6/24/2023 18:17:07'!
importCustomerOn: aDatabaseSession from: anInputStream
	^self new initializeImportCustomerOn: aDatabaseSession from: anInputStream! !
