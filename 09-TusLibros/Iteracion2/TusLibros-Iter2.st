!classDefinition: #CartTest category: 'TusLibros-Iter2'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iter2'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'cylu 6/12/2023 14:22:00'!
defaultCatalog

	^Dictionary with: self itemSellByTheStore -> (100*peso)! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros-Iter2'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'creditInCard cardUsed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iter2'!

!CashierTest methodsFor: 'tests' stamp: 'pau 6/12/2023 00:31:17'!
test01CheckoutOfAnEmptyCartRaisesError
	
	self should: [Cashier checkout: self emptyCartWithCatalog 
				charging: self validCreditCard 
				withProcessor: self merchantProcessorValidCreditCard 
				on: Date today registeringOn:  self salesBook.
				]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier errorCannotCheckoutEmptyCart. 
			self assert: self salesBook isEmpty]

	
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'pau 6/12/2023 00:41:02'!
test02CheckoutTotalOfACartWithOneBookIsCorrectAndIsRegistered
	|cart cashier  totalAtCheckout expectedSalesBook salesBook|
	
	salesBook := self salesBook . 
	cart := self emptyCartWithCatalog. 
	cart add: self validBook. 
	
	cashier := Cashier checkout: cart 
			charging: self validCreditCard 
			withProcessor: self merchantProcessorValidCreditCard 
			on: Date today registeringOn:  salesBook.
	
	totalAtCheckout := cashier checkout. 
	expectedSalesBook := OrderedCollection with: 100*peso. 
	
	self assert: totalAtCheckout equals: 100*peso. 
	self assert: expectedSalesBook equals: salesBook. 

	

	
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'pau 6/12/2023 00:50:42'!
test03CartCannotBeRepurchasedAfterCheckout

	|cart cashier|
	 
	cart := self emptyCartWithCatalog. 
	cart add: self validBook. 
	
	cashier := Cashier checkout: cart 
			charging: self validCreditCard 
			withProcessor: self merchantProcessorValidCreditCard 
			on: Date today registeringOn:  self salesBook.
	
	cashier checkout. 
	
	self assertCartCannotBePurchasedAfterCheckout: cart.! !

!CashierTest methodsFor: 'tests' stamp: 'pau 6/12/2023 00:50:49'!
test04CheckoutWithAnExpiredCardRaisesError

	|cart salesBook |
	salesBook := self salesBook. 
	
	cart := Cart acceptingItemsOf: self catalogWithTwoBooks. 
	cart add: self validBook; add: self validBook2. 
	
	self 
		should: [Cashier checkout: cart 
			charging: self invalidCreditCard 
			withProcessor: self merchantProcessorValidCreditCard 
			on: Date today registeringOn:  salesBook.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier errorCannotCheckoutWithAnExpiredCreditCard. 
			self assert: salesBook isEmpty ]

	

	
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'pau 6/12/2023 00:50:54'!
test05CardWithoutEnoughMoneyCannotCheckout

	|cart salesBook cashier |
	salesBook := self salesBook. 
	
	cart := Cart acceptingItemsOf: self catalogWithTwoBooks. 
	cart add: self validBook; add: self validBook2. 
	
	cashier := Cashier checkout: cart 
					 charging: self validCreditCard 
					withProcessor: self merchantProcessorNotEnoughCredit 
					on: Date today 
					registeringOn:  self salesBook. 
	self 
		should: [cashier checkout]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier errorCannotCheckoutWithACreditCardWithoutEnoughCredit. 
			self assert: salesBook isEmpty ]

	

	
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'cylu 6/12/2023 14:23:43'!
test06CheckoutTotalOfACartWithTwoBookIsProcessedWithMerchantProcessor

	|cart cashier creditCardToUse|
	
	cart := Cart acceptingItemsOf: self catalogWithTwoBooks. 
	cart add: self validBook; add: self validBook2. 
	
	creditCardToUse := self validCreditCard. 
	
	cashier := Cashier checkout: cart 
			charging: creditCardToUse 
			withProcessor: self merchantProcessorValidCreditCard 
			on: Date today registeringOn: self salesBook.
	
	cashier checkout.
	
	self assert: creditInCard = (200*peso).
	self assert: cardUsed == creditCardToUse .
! !


!CashierTest methodsFor: 'support' stamp: 'pau 6/8/2023 20:24:25'!
catalog

	^Dictionary with: self validBook -> (100*peso)! !

!CashierTest methodsFor: 'support' stamp: 'pau 6/8/2023 20:31:39'!
catalogWithTwoBooks

	^Dictionary with: self validBook -> (100*peso) with: self validBook2 -> (200*peso)! !

!CashierTest methodsFor: 'support' stamp: 'pau 6/12/2023 00:31:17'!
emptyCartWithCatalog

	^ Cart acceptingItemsOf: self catalog! !

!CashierTest methodsFor: 'support' stamp: 'pau 6/11/2023 20:32:38'!
invalidCreditCard

	^ CreditCard expiresIn: (Date today monthIndex -1) of: Date today year.  ! !

!CashierTest methodsFor: 'support' stamp: 'pau 6/12/2023 00:44:44'!
merchantProcessorNotEnoughCredit
	^ [:aCreditCard :anAmountToDebit| ^self error: Cashier errorCannotCheckoutWithACreditCardWithoutEnoughCredit]! !

!CashierTest methodsFor: 'support' stamp: 'pau 6/12/2023 00:44:55'!
merchantProcessorReportedCard
	^ [:aCreditCard :anAmountToDebit| ^self error: Cashier errorCannotCheckoutWithAReportedCreditCard]! !

!CashierTest methodsFor: 'support' stamp: 'pau 6/12/2023 01:08:03'!
merchantProcessorValidCreditCard
	^ [:aCreditCard :anAmountToDebit|
		creditInCard := creditInCard - anAmountToDebit.
		cardUsed := aCreditCard ]! !

!CashierTest methodsFor: 'support' stamp: 'pau 6/8/2023 21:18:48'!
salesBook

	^ OrderedCollection new! !

!CashierTest methodsFor: 'support' stamp: 'pau 6/8/2023 20:02:21'!
validBook

	^ 'Los juegos del hambre: En llamas'! !

!CashierTest methodsFor: 'support' stamp: 'pau 6/8/2023 20:32:20'!
validBook2

	^ 'Cazadores de sombras'! !

!CashierTest methodsFor: 'support' stamp: 'pau 6/11/2023 20:42:38'!
validCreditCard

	^ CreditCard expiresIn: Date today monthIndex of: Date today year.  ! !


!CashierTest methodsFor: 'asserts' stamp: 'pau 6/12/2023 00:16:00'!
assertCartCannotBePurchasedAfterCheckout: aCart

	self should: [Cashier checkout: aCart 
				charging: self validCreditCard 
				withProcessor: self merchantProcessorValidCreditCard 
				on: Date today registeringOn:  self salesBook.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier errorCannotCheckoutEmptyCart. 
			self assert: self salesBook isEmpty]! !


!CashierTest methodsFor: 'setUp' stamp: 'pau 6/12/2023 01:07:42'!
setUp
	creditInCard :=500*peso.
	cardUsed := self validCreditCard.! !


!classDefinition: #Cart category: 'TusLibros-Iter2'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iter2'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'pau 6/8/2023 20:26:58'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'pau 6/8/2023 20:28:38'!
emptyYourself
	items := OrderedCollection new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'pau 6/8/2023 20:27:59'!
totalPrice
	^items inject: 0 into: [:subtotal :aBook| subtotal +  (catalog at: aBook) * (self occurrencesOf: aBook) ]. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Iter2'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros-Iter2'!
Object subclass: #Cashier
	instanceVariableNames: 'salesBook cart creditCard dateOfOperation merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iter2'!

!Cashier methodsFor: 'checkout' stamp: 'pau 6/12/2023 00:39:38'!
checkout
	|cartTotal |
	
	
	cartTotal := cart totalPrice. 
	
	self debitTotalUsingMerchantProcessor: cartTotal. 
	
	self emptyCart. 
	
	self registerOperation: cartTotal. 
	
	^cartTotal 
	
	! !


!Cashier methodsFor: 'initialization' stamp: 'pau 6/12/2023 00:09:45'!
initializeCheckout: aCart charging: aCreditCard withProcessor: aMerchantProcesor on: aDate registeringOn: aSalesBook
	cart := aCart .
	creditCard := aCreditCard . 
	dateOfOperation := aDate . 
	salesBook := aSalesBook. 
	merchantProcessor := aMerchantProcesor. ! !


!Cashier methodsFor: 'checkout -private' stamp: 'pau 6/12/2023 00:44:24'!
debitTotalUsingMerchantProcessor: cartTotal

	^ merchantProcessor value: creditCard value: cartTotal! !

!Cashier methodsFor: 'checkout -private' stamp: 'pau 6/12/2023 00:39:09'!
emptyCart

	^ cart emptyYourself! !

!Cashier methodsFor: 'checkout -private' stamp: 'pau 6/12/2023 00:39:38'!
registerOperation: cartTotal

	^ salesBook add: cartTotal! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros-Iter2'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error description' stamp: 'pau 6/8/2023 19:57:59'!
errorCannotCheckoutEmptyCart
	^'Cannot checkout an empty cart'! !

!Cashier class methodsFor: 'error description' stamp: 'pau 6/12/2023 00:06:42'!
errorCannotCheckoutWithACreditCardWithoutEnoughCredit
	^'Credit card doesnt have enogh credit'! !

!Cashier class methodsFor: 'error description' stamp: 'pau 6/12/2023 00:22:04'!
errorCannotCheckoutWithAReportedCreditCard
	^'Cannot checkout with a card that was reported lost or stolen'! !

!Cashier class methodsFor: 'error description' stamp: 'pau 6/8/2023 21:33:09'!
errorCannotCheckoutWithAnExpiredCreditCard
	^'Cannot checkout an empty cart'! !


!Cashier class methodsFor: 'asserts' stamp: 'pau 6/8/2023 21:11:54'!
assertCannotBeEmpty: aCart
	aCart isEmpty ifTrue: [self error: self errorCannotCheckoutEmptyCart]. ! !

!Cashier class methodsFor: 'asserts' stamp: 'pau 6/11/2023 20:35:36'!
assertIsNotExpired: aCreditCart on: aDate 
	(aCreditCart isExpiredOn: aDate) ifTrue: [self error: self errorCannotCheckoutWithAnExpiredCreditCard]! !


!Cashier class methodsFor: 'instance creation' stamp: 'pau 6/12/2023 00:10:48'!
checkout: aCart charging: aCreditCard withProcessor: aMerchantProcesor on: aDate registeringOn: aSalesBook 
	self assertCannotBeEmpty: aCart. 
	self assertIsNotExpired: aCreditCard on: aDate. 
	
	^self new initializeCheckout: aCart charging: aCreditCard withProcessor: aMerchantProcesor on: aDate registeringOn: aSalesBook ! !


!classDefinition: #CreditCard category: 'TusLibros-Iter2'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationYear expirationMonth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iter2'!

!CreditCard methodsFor: 'initialization' stamp: 'pau 6/8/2023 21:47:46'!
initializeIn: aMonth of: aYear
	expirationYear := aYear. 
	expirationMonth := aMonth. ! !


!CreditCard methodsFor: 'is expired' stamp: 'pau 6/11/2023 20:39:59'!
isExpiredOn: aDate 
	
	^ aDate year yearNumber > expirationYear yearNumber or: [ aDate monthIndex > expirationMonth] ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros-Iter2'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'pau 6/8/2023 21:45:40'!
expiresIn: aMonth of: aYear
	^  self new initializeIn: aMonth of: aYear. ! !
