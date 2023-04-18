!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!NumeroTest methodsFor: 'testNuestros' stamp: 'Pau 4/18/2023 16:33:41'!
test01ochomenostres
	self assert: (eight - three) equals: five. ! !

!NumeroTest methodsFor: 'testNuestros' stamp: 'Pau 4/18/2023 16:34:19'!
test02unomenosuno
	self assert: (one - one) equals: zero. ! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:23:59'!
* aMultiplier 
	
	^aMultiplier multiplyToEntero: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:11:31'!
+ anAdder 
	
	^anAdder addToEntero: self. 

! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:33:36'!
- aSubtrahend 
	^aSubtrahend subtractToEntero: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:41:54'!
/ aDivisor 
	^aDivisor divideEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Pau 4/18/2023 16:45:01'!
// aDivisor 
	
	^Entero with: (self integerValue) // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Pau 4/18/2023 16:45:11'!
addToEntero: anEnteroToBeAddedTo
	
	^Entero with: (self integerValue) + anEnteroToBeAddedTo integerValue.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:18:31'!
addToFraction: fractionToBeAddedTo
	|newNumerator newDenominator |
	
	newNumerator := fractionToBeAddedTo numerator + (fractionToBeAddedTo denominator * self).
	newDenominator := fractionToBeAddedTo denominator.
	
	^newNumerator / newDenominator ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:43:01'!
divideEntero: anEnteroToBeDivided 
	
	^Fraccion with: anEnteroToBeDivided over: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:45:10'!
divideFraccion: aFraccionToBeDivided 

	^aFraccionToBeDivided  numerator / (aFraccionToBeDivided  denominator * self)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Pau 4/18/2023 16:45:22'!
greatestCommonDivisorWith: anEntero 
	
	^Entero with: ((self integerValue) gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Pau 4/18/2023 16:45:29'!
multiplyToEntero: anEnteroToMultiplied 
	
	^Entero with: (self integerValue) * anEnteroToMultiplied integerValue
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:26:44'!
multiplyToFraccion: aFraccionToBeMultiplied
	^aFraccionToBeMultiplied numerator * self / aFraccionToBeMultiplied denominator! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:39:23'!
subtractFromFraccion: aFraccionToBeSubtractedFrom
	
	| newNumerator newDenominator |
	newNumerator := aFraccionToBeSubtractedFrom numerator -  (aFraccionToBeSubtractedFrom denominator * self) .
	newDenominator := aFraccionToBeSubtractedFrom denominator.
	
	^newNumerator / newDenominator ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Pau 4/18/2023 16:40:00'!
subtractToEntero: anEnteroToBeSubtractedFrom
	
	^Entero with: (anEnteroToBeSubtractedFrom integerValue - (self integerValue))
	! !


!Entero methodsFor: 'comparing' stamp: 'Pau 4/18/2023 16:11:59'!
= anObject

	^(anObject isKindOf: self class) and: [ (self integerValue) = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'Pau 4/18/2023 16:12:03'!
hash

	^(self integerValue) hash! !



!Entero methodsFor: 'value' stamp: 'Pau 4/18/2023 16:10:14'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^self subclassResponsibility.! !


!Entero methodsFor: 'printing' stamp: 'Pau 4/18/2023 16:12:17'!
printOn: aStream

	aStream print: (self integerValue) ! !


!Entero methodsFor: 'testing' stamp: 'Pau 4/18/2023 16:12:22'!
isNegative
	
	^(self integerValue) < 0! !

!Entero methodsFor: 'testing' stamp: 'Pau 4/18/2023 16:12:28'!
isOne
	
	^(self integerValue) = 1! !

!Entero methodsFor: 'testing' stamp: 'Pau 4/18/2023 16:12:32'!
isZero
	
	^(self integerValue) = 0! !


!Entero methodsFor: 'fibo' stamp: 'Pau 4/18/2023 15:56:35'!
fibonacci
	
	self subclassResponsibility.
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'Pau 4/18/2023 16:22:00'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	
	"Creo que esto se va al usar polimorfismo"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	aValue isZero ifTrue: [^Cero with: aValue].
	aValue = 1 ifTrue: [^Uno with: aValue].
	aValue negative  ifTrue: [^Negativos with: aValue].
	^PositivosMayoresAUno with: aValue. 
	
	"self subclassResponsibility."
	"^self new initalizeWith: aValue"! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'as yet unclassified' stamp: 'Pau 4/18/2023 16:46:48'!
fibonacci
"esto devolver un UNO de la subclase lo que pasa que no lo sabemos crear aun" 
	^Uno with: 1.! !

!Cero methodsFor: 'as yet unclassified' stamp: 'Pau 4/18/2023 16:09:37'!
integerValue
	^0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: 'Numero-Exercise'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'as yet unclassified' stamp: 'Pau 4/18/2023 16:22:28'!
with: aValue
	^self new! !


!classDefinition: #Negativos category: 'Numero-Exercise'!
Entero subclass: #Negativos
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negativos methodsFor: 'as yet unclassified' stamp: 'Pau 4/18/2023 15:51:12'!
fibonacci
	self error: Entero negativeFibonacciErrorDescription! !

!Negativos methodsFor: 'as yet unclassified' stamp: 'Pau 4/18/2023 16:14:54'!
initializeWith: aValue
	value := aValue.! !

!Negativos methodsFor: 'as yet unclassified' stamp: 'Pau 4/18/2023 16:14:13'!
integerValue
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Negativos class' category: 'Numero-Exercise'!
Negativos class
	instanceVariableNames: ''!

!Negativos class methodsFor: 'as yet unclassified' stamp: 'Pau 4/18/2023 16:16:51'!
with: aValue
	^ (self new) initializeWith: aValue! !


!classDefinition: #PositivosMayoresAUno category: 'Numero-Exercise'!
Entero subclass: #PositivosMayoresAUno
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!PositivosMayoresAUno methodsFor: 'as yet unclassified' stamp: 'Pau 4/18/2023 16:25:21'!
fibonacci
	|one two|
	one := Uno with: 1. 
	two := PositivosMayoresAUno with: 2.
	
	^(self - one) fibonacci + (self - two) fibonacci! !

!PositivosMayoresAUno methodsFor: 'as yet unclassified' stamp: 'Pau 4/18/2023 16:15:26'!
initializeWith: aValue
	value := aValue.! !

!PositivosMayoresAUno methodsFor: 'as yet unclassified' stamp: 'Pau 4/18/2023 16:14:04'!
integerValue
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositivosMayoresAUno class' category: 'Numero-Exercise'!
PositivosMayoresAUno class
	instanceVariableNames: ''!

!PositivosMayoresAUno class methodsFor: 'as yet unclassified' stamp: 'Pau 4/18/2023 16:16:44'!
with: aValue
	^ (self new) initializeWith: aValue! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'as yet unclassified' stamp: 'Pau 4/18/2023 15:53:35'!
fibonacci
"esto devolver un UNO de la subclase lo que pasa que no lo sabemos crear aun" 
	^self! !

!Uno methodsFor: 'as yet unclassified' stamp: 'Pau 4/18/2023 16:09:50'!
integerValue
	^1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: 'Numero-Exercise'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'as yet unclassified' stamp: 'Pau 4/18/2023 16:22:34'!
with: aValue
	^self new.! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:27:02'!
* aMultiplier 
	
	^ aMultiplier multiplyToFraccion: self
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:20:08'!
+ anAdder 
	^ anAdder addToFraction: self
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:38:39'!
- aSubtrahend 

	^ aSubtrahend subtractFromFraccion: self
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:44:38'!
/ aDivisor 
	
	^aDivisor divideFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:13:02'!
addToEntero: anEnteroToBeAddedTo 
"anAdder chequear"

	^anEnteroToBeAddedTo * (denominator) + (numerator) / (denominator)
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:19:42'!
addToFraction: fractionToBeAddedTo

	| newNumerator newDenominator |
	newNumerator := (numerator * fractionToBeAddedTo denominator) + (denominator * fractionToBeAddedTo numerator).
        newDenominator := denominator * fractionToBeAddedTo denominator.

        ^newNumerator / newDenominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:42:16'!
divideEntero: anEnteroToBeDivided 

	^anEnteroToBeDivided * (denominator / numerator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:45:42'!
divideFraccion: aFraccionToBeDivided 
	
	^ (denominator * aFraccionToBeDivided numerator)/(numerator * aFraccionToBeDivided denominator) ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:23:33'!
multiplyToEntero: anEnteroToBeMultiplied
	
	^numerator * anEnteroToBeMultiplied / denominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:25:57'!
multiplyToFraccion: aFraccionToBeMultiplied
	
	^(numerator * aFraccionToBeMultiplied numerator) / (denominator * aFraccionToBeMultiplied denominator)
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:37:58'!
subtractFromFraccion: aFraccionToBeSubtractedFrom 
	| newNumerator newDenominator |
	
	newNumerator := (denominator * aFraccionToBeSubtractedFrom numerator) - (numerator * aFraccionToBeSubtractedFrom denominator).
        newDenominator := denominator * aFraccionToBeSubtractedFrom denominator.

        ^newNumerator / newDenominator 
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Pau 4/17/2023 21:32:47'!
subtractToEntero: anEnteroToBeSubtractedFrom
	
	^anEnteroToBeSubtractedFrom * denominator - numerator / denominator! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'NR 9/23/2018 23:45:19'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
