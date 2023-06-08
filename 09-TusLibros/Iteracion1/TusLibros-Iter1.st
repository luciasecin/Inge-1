!classDefinition: #CartTest category: 'TusLibros-Iter1'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iter1'!

!CartTest methodsFor: 'test' stamp: 'cylu 6/7/2023 16:58:03'!
test01NewCartIsEmpty

	|cart|
	cart := Cart createCart.
	
	self assert: cart listCart isEmpty.! !

!CartTest methodsFor: 'test' stamp: 'pau 6/8/2023 14:50:12'!
test02CartHasBookAfterAddingBook

	|cart expectedCart|
	cart := Cart createCart.
	expectedCart := Dictionary new.
	
	expectedCart add: self bookLosJuegosDelHambre -> 1.
	
	cart addToCart: self bookLosJuegosDelHambre.

	self assert: cart listCart equals: expectedCart.! !

!CartTest methodsFor: 'test' stamp: 'pau 6/8/2023 14:50:33'!
test03CartHasBookAfterAddingSameBookTwice

	|cart expectedCart |
	cart := Cart createCart.
	expectedCart := Dictionary new.
	expectedCart add: self bookLosJuegosDelHambre -> 2.
	
	cart addToCart: self bookLosJuegosDelHambre.
	cart addToCart: self bookLosJuegosDelHambre.

	self assert: cart listCart equals: expectedCart.! !

!CartTest methodsFor: 'test' stamp: 'pau 6/8/2023 14:50:46'!
test04CartHasBookAfterAddingMoreThanOneOfTheSameBook

	|cart expectedCart |
	cart := Cart createCart.
	expectedCart := Dictionary new.
	expectedCart add: self bookLosJuegosDelHambre -> 3.
	
	cart addToCart: self bookLosJuegosDelHambre amount: 3.

	self assert: cart listCart equals: expectedCart.! !

!CartTest methodsFor: 'test' stamp: 'pau 6/8/2023 14:51:03'!
test05CannotAddNonPositiveAmountOfBooks

	|cart |
	cart := Cart createCart.
	self 
		should: [cart addToCart: self bookLosJuegosDelHambre amount: 0]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cart invalidAmountErrorMessage.
			self assert: cart listCart isEmpty]! !

!CartTest methodsFor: 'test' stamp: 'pau 6/8/2023 14:51:23'!
test06CannotAddBookNotInStore

	|cart |
	cart := Cart createCart.
	self 
		should: [cart addToCart: self BookNotInStore]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cart bookNotInStoreErrorMessage.
			self assert: cart listCart isEmpty]! !


!CartTest methodsFor: 'books' stamp: 'pau 6/8/2023 14:51:18'!
BookNotInStore

	^ 'Book not in store'! !

!CartTest methodsFor: 'books' stamp: 'pau 6/8/2023 14:49:48'!
bookLosJuegosDelHambre

	^ 'Los Juegos del Hambre: En Llamas'! !


!classDefinition: #Cart category: 'TusLibros-Iter1'!
Object subclass: #Cart
	instanceVariableNames: 'booksInCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iter1'!

!Cart methodsFor: 'initialization' stamp: 'cylu 6/7/2023 16:58:39'!
initialize 
	
	booksInCart := Dictionary new.! !


!Cart methodsFor: 'add item' stamp: 'cylu 6/7/2023 17:17:08'!
addToCart: aBookToAdd
	
	aBookToAdd = 'Book not in store' ifTrue: [self error: self class bookNotInStoreErrorMessage].
	(booksInCart includesKey: aBookToAdd) 
		ifTrue: [booksInCart at: aBookToAdd put: ((booksInCart at: aBookToAdd) + 1)]
		ifFalse: [booksInCart add: aBookToAdd -> 1]! !

!Cart methodsFor: 'add item' stamp: 'cylu 6/7/2023 17:11:34'!
addToCart: book amount: amountToAdd
	
	(amountToAdd < 1) ifTrue: [self error: self class invalidAmountErrorMessage].
	amountToAdd timesRepeat: [self addToCart: book]! !


!Cart methodsFor: 'list cart' stamp: 'cylu 6/7/2023 16:58:22'!
listCart
	^booksInCart .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Iter1'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'cylu 6/7/2023 17:15:59'!
bookNotInStoreErrorMessage

	^'cannot add book that is not in the store'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'cylu 6/7/2023 16:58:54'!
createCart

	^self new.! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'cylu 6/7/2023 17:09:59'!
invalidAmountErrorMessage

	^'Can not add less than one book.'! !
