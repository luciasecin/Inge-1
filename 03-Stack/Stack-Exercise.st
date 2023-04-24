!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'aStack aResultCollection aPrefix allTooWell badBlood tisTheDamnSeason invisibleString theLastGreatAmericanDinasty lavanderHaze pictureTuBurn youReOwnYourOwnKid'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Pau 4/23/2023 13:49:59'!
test01prefixIsNotInAnElementOfTheStack
	aStack push: lavanderHaze;
		push: youReOwnYourOwnKid.
	
	self assertIfSentencesInAStack: aStack thatStartWith: aPrefix are: aResultCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'lucy 4/23/2023 21:36:41'!
test02prefixIsInAllElementsOfTheStack

	aStack push: tisTheDamnSeason; 
		push: invisibleString; 
		push: allTooWell.
	
	aResultCollection addFirst: tisTheDamnSeason; 
					addFirst: invisibleString ;
					addFirst: allTooWell.
					
	self assertIfSentencesInAStack: aStack thatStartWith: aPrefix are: aResultCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Pau 4/23/2023 13:49:22'!
test03prefixIsNotAnElementOfTheStackAndTheStackIsEmpty
	self assertIfSentencesInAStack: aStack thatStartWith: aPrefix are: aResultCollection. ! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Pau 4/23/2023 13:49:28'!
test04sentenceFinderIsCaseSensitive
	
	aStack push: theLastGreatAmericanDinasty; 
		push: invisibleString; 
		push: badBlood.
	
	aResultCollection addFirst: invisibleString.
	
	self assertIfSentencesInAStack: aStack thatStartWith: aPrefix are: aResultCollection. ! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Pau 4/23/2023 13:49:35'!
test05prefixIsInSomeElementsOfTheStack
	
	aStack push: theLastGreatAmericanDinasty; 
		push: invisibleString; 
		push: badBlood;
		push: youReOwnYourOwnKid;
		push: allTooWell;
		push:lavanderHaze;
		push: pictureTuBurn;
		push: tisTheDamnSeason.
	
	aResultCollection addFirst: invisibleString;
				addFirst: allTooWell ;
				addFirst: tisTheDamnSeason .
	
	self assertIfSentencesInAStack: aStack thatStartWith: aPrefix are: aResultCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'lucy 4/23/2023 21:37:43'!
test06StackPreservesElements
	
	| originalStack |
	aStack push: theLastGreatAmericanDinasty; 
		push: invisibleString; 
		push: badBlood.
		
	originalStack := OOStack new.
	originalStack push: theLastGreatAmericanDinasty; 
		push: invisibleString; 
		push: badBlood.
		
	SentenceFinderByPrefix new findSentencesIn: aStack thatStartWith: aPrefix.
	
	self assertIfSearchedStack: aStack isEqualTo: originalStack.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'lucy 4/23/2023 21:11:01'!
test07PrefixWithWhitespacesRaisesError

	aStack push: theLastGreatAmericanDinasty; 
		push: invisibleString; 
		push: badBlood.
		
	[SentenceFinderByPrefix new findSentencesIn: aStack thatStartWith: 'Time '.] on: Error do: 
		[:anError | anError messageText = SentenceFinderByPrefix prefixHasWhitespacesErrorMessage ]! !


!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'Pau 4/23/2023 12:38:56'!
setUp
	aStack :=OOStack new.
	aResultCollection  := OrderedCollection new.
	aPrefix := 'Time'.
	
	theLastGreatAmericanDinasty := 'I had a marvelous time ruining everything'.
	tisTheDamnSeason:= 'Time flies, messy as the mud on your truck tires'.
	invisibleString := 'Time, mystical time, cutting me open then healing me fine'.
	badBlood := 'time can heal but this won’t'.
	pictureTuBurn := 'So watch me strike a match on all my wasted time'.
	allTooWell :='Time wont fly, its like Im paralyzed by it'.
	lavanderHaze := 'I feel the lavender haze creeping up on me'.
	youReOwnYourOwnKid := 'I gave my blood, sweat, and tears for this'.
	

	
	! !


!SentenceFinderByPrefixTest methodsFor: 'assertConditions-private' stamp: 'Pau 4/23/2023 13:41:21'!
assertIfSearchedStack: searchedStack isEqualTo: originalStack
	| assertCondition |
	
	assertCondition:= true.
	searchedStack size timesRepeat:[
		assertCondition :=assertCondition and: [searchedStack pop = (originalStack pop)]].
	self assert: assertCondition.! !

!SentenceFinderByPrefixTest methodsFor: 'assertConditions-private' stamp: 'lucy 4/23/2023 20:44:56'!
assertIfSentencesInAStack: stack thatStartWith: prefix are: resultCollection
	self assert: (SentenceFinderByPrefix new findSentencesIn: stack thatStartWith: prefix) equals: resultCollection.	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topElement size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialize' stamp: 'Pau 4/23/2023 11:02:17'!
initialize
	topElement := OOStackBase new.
	size := 0.
	! !


!OOStack methodsFor: 'operations' stamp: 'Pau 4/23/2023 11:07:22'!
isEmpty
	^ size =0
	! !

!OOStack methodsFor: 'operations' stamp: 'Pau 4/23/2023 11:21:58'!
pop
	|elementToPop|
	elementToPop := topElement.
	topElement := topElement previous.
	size := size-1.
	^elementToPop elementValue.
	
	! !

!OOStack methodsFor: 'operations' stamp: 'Pau 4/23/2023 11:02:11'!
push: anElement
	topElement := OOStackElement withElement: anElement andPrevious: topElement.
	size := size+1
	! !

!OOStack methodsFor: 'operations' stamp: 'Pau 4/23/2023 11:01:58'!
size 
	^size! !

!OOStack methodsFor: 'operations' stamp: 'Pau 4/23/2023 11:16:21'!
top
	^topElement elementValue.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackBase category: 'Stack-Exercise'!
OOStack subclass: #OOStackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'accessing' stamp: 'Pau 4/23/2023 11:16:44'!
elementValue
	self error: (self class stackEmptyErrorDescription)! !

!OOStackBase methodsFor: 'accessing' stamp: 'Pau 4/23/2023 11:14:40'!
previous
	self error: (self class stackEmptyErrorDescription)! !


!OOStackBase methodsFor: 'initialize' stamp: 'Pau 4/23/2023 11:05:52'!
initialize! !


!classDefinition: #OOStackElement category: 'Stack-Exercise'!
OOStack subclass: #OOStackElement
	instanceVariableNames: 'elementValue previousElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'accessing' stamp: 'Pau 4/23/2023 11:16:32'!
elementValue
	^elementValue! !

!OOStackElement methodsFor: 'accessing' stamp: 'Pau 4/23/2023 11:13:14'!
previous
	
	^previousElement.
	! !


!OOStackElement methodsFor: 'initialize' stamp: 'Pau 4/23/2023 10:57:50'!
initializeWithElement: anElement andPrevious: aPreviousStackElement
	elementValue := anElement.
	previousElement := aPreviousStackElement! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElement class' category: 'Stack-Exercise'!
OOStackElement class
	instanceVariableNames: ''!

!OOStackElement class methodsFor: 'instance creation' stamp: 'Pau 4/23/2023 11:23:12'!
withElement: anElement andPrevious: aPreviousStackElement
	^self new initializeWithElement: anElement andPrevious: aPreviousStackElement
	
	! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'find' stamp: 'lucy 4/23/2023 21:26:22'!
findSentencesIn: anOOStack thatStartWith: aPrefixToFind

	|elementsThatContainPrefix elementsPopped |
	
	self raiseErrorIfPrefixHasWhitespaces: aPrefixToFind.
		
	elementsThatContainPrefix := OrderedCollection new.
	
	elementsPopped := self findSentencesInStack: anOOStack thatStartWith: aPrefixToFind andStoreFoundSentencesIn: elementsThatContainPrefix.
		
	self reconstructStack: anOOStack withCollection: elementsPopped.
	
	^elementsThatContainPrefix.! !


!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'lucy 4/23/2023 21:03:03'!
checkIfStringHasWhitespaces: aString
	| assertCondition |
	assertCondition := aString anySatisfy: [:char | (char isSeparator)].
	^assertCondition.! !

!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'lucy 4/23/2023 21:31:53'!
findSentencesInStack: anOOStack thatStartWith: aPrefixToFind andStoreFoundSentencesIn: elementsThatContainPrefix
	|elementsPopped|
	
	elementsPopped := OrderedCollection new.
	
	anOOStack size timesRepeat: [
		|currentElement|
		currentElement := anOOStack pop.
		elementsPopped addFirst: currentElement .
		
		(currentElement is: aPrefixToFind substringAt: 1)
			ifTrue: [ elementsThatContainPrefix add: currentElement. ]].
		
	^elementsPopped ! !

!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'lucy 4/23/2023 21:08:46'!
raiseErrorIfPrefixHasWhitespaces: aPrefix
	(self checkIfStringHasWhitespaces: aPrefix) 
		ifTrue: [self error: self class prefixHasWhitespacesErrorMessage]! !

!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'lucy 4/23/2023 20:39:08'!
reconstructStack: anOOStack withCollection: anElementOrderedCollection

	anElementOrderedCollection do: [:anElement | anOOStack push: anElement].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'errors' stamp: 'lucy 4/23/2023 21:08:05'!
prefixHasWhitespacesErrorMessage

	^ 'El prefijo no puede tener whitespaces'! !
