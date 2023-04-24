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

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:41:17'!
assertIfSearchedStack: searchedStack isEqualTo: originalStack
	| assertCondition |

	assertCondition:= true.
	searchedStack size timesRepeat:[
		assertCondition :=assertCondition and: [searchedStack pop = (originalStack pop)]].
	self assert: assertCondition.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:41:30'!
assertIfSentencesInAStack: stack thatStartWith: prefix are: resultCollection
	self assert: (SentenceFinderByPrefix new find: prefix in: stack) equals: resultCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:40:52'!
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
	youReOwnYourOwnKid := 'I gave my blood, sweat, and tears for this'.! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Pau 4/24/2023 16:34:00'!
test01prefixIsNotInAnElementOfTheStack
	aStack push: lavanderHaze;
		push: youReOwnYourOwnKid.

	self assertIfSentencesInAStack: aStack thatStartWith: aPrefix are: aResultCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Pau 4/24/2023 16:50:01'!
test02prefixIsInAllElementsOfTheStack

	aStack push: tisTheDamnSeason; 
		push: invisibleString; 
		push: allTooWell.

	aResultCollection addFirst: tisTheDamnSeason; 
					addFirst: invisibleString ;
					addFirst: allTooWell.
	self assertIfSentencesInAStack: aStack thatStartWith: aPrefix are: aResultCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Pau 4/24/2023 16:50:36'!
test03prefixIsNotAnElementOfTheStackAndTheStackIsEmpty
	self assertIfSentencesInAStack: aStack thatStartWith: aPrefix are: aResultCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Pau 4/24/2023 16:50:44'!
test04sentenceFinderIsCaseSensitive

	aStack push: theLastGreatAmericanDinasty; 
		push: invisibleString; 
		push: badBlood.

	aResultCollection addFirst: invisibleString.

	self assertIfSentencesInAStack: aStack thatStartWith: aPrefix are: aResultCollection! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Pau 4/24/2023 16:51:31'!
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

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Pau 4/24/2023 16:51:45'!
test06StackPreserveElements

	| originalStack |
	aStack push: theLastGreatAmericanDinasty; 
		push: invisibleString; 
		push: badBlood.

	originalStack := aStack copy.
	SentenceFinderByPrefix new find: aPrefix in: aStack.

	self assertIfSearchedStack: aStack isEqualTo: originalStack.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Pau 4/24/2023 16:53:16'!
test07PrefixWithWhitespacesRaisesError

	aStack push: theLastGreatAmericanDinasty; 
		push: invisibleString; 
		push: badBlood.

	[SentenceFinderByPrefix new findSentencesIn: aStack thatStartWith: 'Time '.] on: Error do: 
		[:anError | anError messageText = SentenceFinderByPrefix prefixHasWhitespacesErrorMessage ]! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:19:49'!
initialize
	topElement  := OOStackBase new.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:28:36'!
isEmpty
	^ topElement size = 0! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:26:46'!
pop
	|previousTop|
	previousTop := topElement elementValue.
	topElement := topElement previous.
	^previousTop 
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:29:45'!
push: anElement
	topElement := OOStackElement withElement: anElement andPrevious: topElement.
	^topElement elementValue! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:31:32'!
size
	^topElement size! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:30:07'!
top
	^topElement elementValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackTopElement category: 'Stack-Exercise'!
Object subclass: #OOStackTopElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTopElement methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:09:33'!
elementValue
	self subclassResponsibility! !

!OOStackTopElement methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:10:56'!
previous
	self subclassResponsibility! !

!OOStackTopElement methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:10:43'!
size
	self subclassResponsibility! !


!classDefinition: #OOStackBase category: 'Stack-Exercise'!
OOStackTopElement subclass: #OOStackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:10:30'!
elementValue
	self error: (OOStack stackEmptyErrorDescription)! !

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:13:09'!
size
	^0! !


!classDefinition: #OOStackElement category: 'Stack-Exercise'!
OOStackTopElement subclass: #OOStackElement
	instanceVariableNames: 'previous elementValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:10:00'!
elementValue
	^elementValue ! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:12:34'!
initializeWithElement: anElement andPrevious: aPreviousStackElement
	previous := aPreviousStackElement.
	elementValue := anElement ! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:12:47'!
previous
	^previous ! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:13:28'!
size 
	^ 1 + (previous size)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElement class' category: 'Stack-Exercise'!
OOStackElement class
	instanceVariableNames: ''!

!OOStackElement class methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:11:21'!
withElement: anElement andPrevious: aPreviousStackElement
	^self new initializeWithElement: anElement andPrevious: aPreviousStackElement! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:43:37'!
assertIfSentencesInAStack: stack thatStartWith: prefix are: resultCollection
	
	self assert: (SentenceFinderByPrefix new findSentencesIn: stack thatStartWith: prefix) equals: resultCollection.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:39:16'!
checkIfStringHasWhitespaces: aString
	| assertCondition |
	assertCondition := aString anySatisfy: [:char | (char isSeparator)].
	^assertCondition! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:49:23'!
find: aPrefix in: aOOSctack
	|collectionWithSentencesThatStartWithPrefix|
	self checkIfStringHasWhitespaces: aPrefix. 
	
	collectionWithSentencesThatStartWithPrefix := OrderedCollection new.
	self findSentencesInStack:  aOOSctack thatStartWith:  aPrefix andStoreFoundSentencesIn: collectionWithSentencesThatStartWithPrefix. 
	^ collectionWithSentencesThatStartWithPrefix.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:42:37'!
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

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:14:35'!
raiseErrorIfPrefixHasWhitespaces: aPrefix
	(self checkIfStringHasWhitespaces: aPrefix) 
		ifTrue: [self error: self class prefixHasWhitespacesErrorMessage]! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:14:22'!
reconstructStack: anOOStack withCollection: anElementOrderedCollection

	anElementOrderedCollection do: [:anElement | anOOStack push: anElement].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'Pau 4/24/2023 16:14:01'!
prefixHasWhitespacesErrorMessage

	^ 'El prefijo no puede tener whitespaces'.! !
