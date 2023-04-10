!classDefinition: #I category: 'Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Naturales'!
I class
	instanceVariableNames: 'next pred'!

!I class methodsFor: 'as yet unclassified' stamp: 'Pau 3/30/2023 12:41:18'!
* aNaturalNumber
	"mult por 1 mantiene el valor"
	^aNaturalNumber ! !

!I class methodsFor: 'as yet unclassified' stamp: 'Pau 3/30/2023 12:37:11'!
+ aNaturalNumber
	|sum|
	sum := pred isNil
		ifTrue: [aNaturalNumber next ] "caso algo + 1 : next (1) "
		ifFalse: [pred + aNaturalNumber next ]. "n1 + n2:  pred(n1) + next(n2)"
	^sum. ! !

!I class methodsFor: 'as yet unclassified' stamp: 'Pau 3/27/2023 21:42:09'!
- naturalNumber
	^'No podes restarle al 1'! !

!I class methodsFor: 'as yet unclassified' stamp: 'Pau 3/30/2023 20:37:43'!
/ aNaturalNumber
	self error: 'El uno no se divide che!!'
! !

!I class methodsFor: 'as yet unclassified' stamp: 'Pau 3/30/2023 20:46:21'!
< aNaturalNumber
	^ (aNaturalNumber ~= self) ! !

!I class methodsFor: 'as yet unclassified' stamp: 'Pau 3/27/2023 20:58:00'!
next
	next ifNil: [next := self cloneNamed: self name , 'I'].
	next setPred: self.
	^next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Pau 3/27/2023 20:55:29'!
pred 
	^pred! !

!I class methodsFor: 'as yet unclassified' stamp: 'Pau 3/27/2023 20:57:15'!
setPred: asignarPred
	^pred:= asignarPred! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'Pau 4/3/2023 16:36:14'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.
	pred := nil.! !


!classDefinition: #II category: 'Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Naturales'!
II class
	instanceVariableNames: 'next pred'!

!II class methodsFor: 'as yet unclassified' stamp: 'Pau 3/30/2023 12:54:18'!
* aNaturalNumber
	aNaturalNumber = I ifTrue: [^self].
	^ (self + self) * (aNaturalNumber pred)! !

!II class methodsFor: 'as yet unclassified' stamp: 'Pau 3/27/2023 21:49:44'!
+ aNaturalNumber
	|sum|
	sum := pred isNil
		ifTrue: [aNaturalNumber next ]
		ifFalse: [pred + aNaturalNumber next ].
	^sum. ! !

!II class methodsFor: 'as yet unclassified' stamp: 'Pau 3/30/2023 12:40:03'!
- naturalNumber
	naturalNumber = I ifTrue:[^self pred ]. "n -1 : pred(n)"
	^self pred - (naturalNumber pred) "n - m : pred(n) - pred(m)"! !

!II class methodsFor: 'as yet unclassified' stamp: 'Pau 3/30/2023 20:42:45'!
/ aNaturalNumber
	aNaturalNumber = I ifTrue: [^self]. "caso: x /1 = x  "
	^ ((self - aNaturalNumber ) / (aNaturalNumber)) next " (x-n)/n  +1"! !

!II class methodsFor: 'as yet unclassified' stamp: 'Pau 3/31/2023 13:23:07'!
< aNaturalNumber
	aNaturalNumber = I ifTrue: [^false].
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'Pau 3/27/2023 21:49:44'!
next
	next ifNil: [next := self cloneNamed: self name , 'I'].
	next setPred: self.
	^next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Pau 3/27/2023 21:49:44'!
pred 
	^pred! !

!II class methodsFor: 'as yet unclassified' stamp: 'Pau 3/27/2023 21:49:44'!
setPred: asignarPred
	^pred:= asignarPred! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'Pau 4/3/2023 16:36:14'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	pred := I.! !

I initializeAfterFileIn!
II initializeAfterFileIn!