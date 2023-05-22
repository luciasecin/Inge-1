!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'pau 5/21/2023 22:03:30'!
test01PortfolioWithEmptyAccountHasBalanceZero

	|portfolio account|
	account := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert:  portfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'pau 5/21/2023 22:04:57'!
test02PortfolioWithAccountHasItsBalance
	
	|portfolio account|
	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert:  portfolio balance equals: 50.! !

!PortfolioTest methodsFor: 'tests' stamp: 'pau 5/21/2023 22:10:48'!
test03PortfolioWithTwoAccountsHasTheSumOfTheirBalances
	
	|portfolio account account2|
	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	
	account2 := ReceptiveAccount new.
	Deposit register: 50 on: account2.
	
	portfolio := Portfolio new.
	portfolio add: account;add: account2.! !

!PortfolioTest methodsFor: 'tests' stamp: 'pau 5/21/2023 22:11:10'!
test04PortfolioWithEmptyPortfolioHasBalanceZero
	
	|portfolio |
		
	portfolio := Portfolio new.
	
	portfolio add: (Portfolio new).
	
	self assert:  portfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'pau 5/21/2023 22:14:26'!
test05PortfolioWithEmptyAccountHasNoTransactionsRegistered 
	|portfolio |
		
	portfolio := Portfolio new.

	portfolio add: (ReceptiveAccount new).
	
	self deny:  (portfolio hasRegistered: (Deposit for: 50)).! !

!PortfolioTest methodsFor: 'tests' stamp: 'pau 5/21/2023 22:16:26'!
test06PortfolioWithAccountHasRegisteredItsTransactions
	|portfolio account transaction|
		
	portfolio := Portfolio new.
	account := ReceptiveAccount new. 
	transaction := Deposit register: 50 on: (account).
	 
	portfolio add: account.
	
	self assert:  (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'pau 5/21/2023 22:19:34'!
test07PortfolioWithTwoAccountsHasRegisteredTheirTransactions
	
	|portfolio account transaction account2 transaction2 |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	account2 :=  ReceptiveAccount new.
	transaction := Deposit register: 50 on: (account).
	transaction2 := Deposit register: 50 on: (account2).
	
	portfolio add: account; add: account2.
	
	self assert:  (portfolio hasRegistered: transaction).
	self assert:  (portfolio hasRegistered: transaction2).! !

!PortfolioTest methodsFor: 'tests' stamp: 'pau 5/21/2023 22:25:38'!
test08PortfolioWithEmptyAccountHasEmptyTransactions

	|portfolio|
		
	portfolio := Portfolio new.

	portfolio add: (ReceptiveAccount new).
	
	self assert: (portfolio transactions isEmpty).! !

!PortfolioTest methodsFor: 'tests' stamp: 'pau 5/21/2023 22:27:13'!
test09PortfolioWithAccountHasItsTransactions

	|portfolio account transaction transactions|
		
	portfolio := Portfolio new.
	account := ReceptiveAccount new. 
	transaction := Deposit register: 50 on: (account).
	transactions := OrderedCollection with: transaction.
	 
	portfolio add: account.
	
	self assert: (portfolio transactions) equals: transactions.! !

!PortfolioTest methodsFor: 'tests' stamp: 'pau 5/21/2023 22:30:56'!
test10PortfolioWithTwoAccountHasTheirTransactions

	|portfolio account transaction1 account2 transaction2 transactions|
		
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	account2 :=  ReceptiveAccount new.
	transaction1 := Deposit register: 50 on: (account).
	transaction2 := Deposit register: 50 on: (account2).
	transactions := OrderedCollection with: transaction1 with: transaction2.
	
	portfolio add: account; add: account2.
	
	self assert: (portfolio transactions) equals: transactions.! !

!PortfolioTest methodsFor: 'tests' stamp: 'pau 5/21/2023 23:05:37'!
test11CantAddAccountAlreadyInCurrentPortofolio
	
	|portfolio account|
		
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio add: account.
	
	self should: [portfolio add: account.] 
	raise: Error
	withExceptionDo: [:anError| self assert: (anError messageText) equals: (ReceptiveAccount cannotAddTwice)]
! !

!PortfolioTest methodsFor: 'tests' stamp: 'pau 5/21/2023 23:05:31'!
test12CantAddAccountAlreadyInChildPortfolio
	
	|portfolioParent portfolioChild account|
		
	portfolioParent := Portfolio new.
	portfolioChild := Portfolio new.
	
	account := ReceptiveAccount new.
	
	portfolioChild add: account.
	portfolioParent add: portfolioChild.
	
	self should: [portfolioParent add: account.] 
	raise: Error
	withExceptionDo: [:anError| self assert: (anError messageText) equals:  (ReceptiveAccount cannotAddTwice)]
! !

!PortfolioTest methodsFor: 'tests' stamp: 'pau 5/21/2023 23:05:23'!
test13CantAddAccountAlreadyInParentPortfolio
	
	|portfolioParent portfolioChild account|
	
	portfolioParent := Portfolio new.
	portfolioChild := Portfolio new.
	
	account := ReceptiveAccount new.
	
	 portfolioParent add: account.
	portfolioParent add: portfolioChild.
	
	self should: [portfolioChild add:account.] 
	raise: Error
	withExceptionDo: [:anError| self assert: (anError messageText) equals: (ReceptiveAccount cannotAddTwice)]
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'pau 5/21/2023 23:04:48'!
test14CantAddPortfolioAlreadyInCurrentPortfolio
	
	|portfolio portfolioToBeAdded |
		
	portfolio := Portfolio new.
	portfolioToBeAdded := Portfolio new.
	
	portfolio add: portfolioToBeAdded .
	
	self should: [portfolio add: portfolioToBeAdded.] 
	raise: Error
	withExceptionDo: [:anError| self assert: (anError messageText) equals: (Portfolio cannotAddTwice)]! !

!PortfolioTest methodsFor: 'tests' stamp: 'pau 5/21/2023 23:24:56'!
test15CannotAddAccountAlreadyInOtherParent
	
	|portfolioDad  portfolioMom portfolioChild account |
		
	portfolioDad := Portfolio new.
	portfolioMom := Portfolio new.
	portfolioChild:= Portfolio new.
	account := ReceptiveAccount new.
	
	portfolioMom add: portfolioChild.
	portfolioMom add: account.
	portfolioDad add: portfolioChild .

	self should: [portfolioChild add:account.] 
	raise: Error
	withExceptionDo: [:anError| self assert: (anError messageText) equals: (ReceptiveAccount cannotAddTwice)]! !

!PortfolioTest methodsFor: 'tests' stamp: 'pau 5/22/2023 16:02:20'!
test16CannotAddAnAccountThatIsAlreadyInAGrandparentPortfolio
	
	|portfolioGrandparent  portfolioParent portfolioChild account account2 |
		
	portfolioGrandparent  := Portfolio new.
	portfolioParent := Portfolio new.
	portfolioChild:= Portfolio new.
	
	account := ReceptiveAccount new.
	
	portfolioChild add:account.
	
	portfolioParent add: portfolioChild.
	
	portfolioGrandparent  add: portfolioParent.
	
	account2 := ReceptiveAccount new.
	
	portfolioGrandparent add:account2.
	 
	self should: [portfolioChild add: account2. ] 
	raise: Error
	withExceptionDo: [:anError| self assert: (anError messageText) equals: (ReceptiveAccount cannotAddTwice)]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'testing' stamp: 'pau 5/21/2023 22:00:03'!
isDeposit 
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'pau 5/21/2023 22:00:41'!
addMyselfToBalance: balance 
	^balance + value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'pau 5/21/2023 22:01:09'!
addMyselfToBalance: balance 
	^balance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #BankAccount category: 'Portfolio-Ejercicio'!
Object subclass: #BankAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BankAccount methodsFor: 'as yet unclassified' stamp: 'pau 5/22/2023 15:48:51'!
balance
	self subclassResponsibility ! !

!BankAccount methodsFor: 'as yet unclassified' stamp: 'pau 5/22/2023 16:02:55'!
contains: anAccountOrPortfolio
	self subclassResponsibility ! !

!BankAccount methodsFor: 'as yet unclassified' stamp: 'pau 5/22/2023 15:48:13'!
hasRegistered: aTransaction
	self subclassResponsibility.! !

!BankAccount methodsFor: 'as yet unclassified' stamp: 'pau 5/22/2023 15:49:12'!
transactions
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
BankAccount subclass: #Portfolio
	instanceVariableNames: 'content roots'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'add' stamp: 'pau 5/22/2023 16:07:47'!
add: anAccountOrAPortfolio 
	
	(anAccountOrAPortfolio isKindOf: Portfolio) ifTrue: [anAccountOrAPortfolio setRootPortfolio: roots.].
	 
	self anyRootPortfolioHas: anAccountOrAPortfolio.
				
	content add: anAccountOrAPortfolio! !

!Portfolio methodsFor: 'add' stamp: 'pau 5/21/2023 22:53:49'!
contains: anAccountOrAPortfolio
	
	self = anAccountOrAPortfolio ifTrue: [^true].
	
	^content anySatisfy: [:anAccountOrPortfolioAlreadyInPortfolio | 
				anAccountOrPortfolioAlreadyInPortfolio contains: anAccountOrAPortfolio]! !


!Portfolio methodsFor: 'testing' stamp: 'pau 5/21/2023 22:17:59'!
hasRegistered: aTransaction

	^content anySatisfy: [:anAccountOrPortfolio| anAccountOrPortfolio hasRegistered: aTransaction]! !


!Portfolio methodsFor: 'transactions' stamp: 'pau 5/22/2023 15:29:47'!
transactions
	|transactions|
	transactions := OrderedCollection new.
	content do: [:anAccountOrPortfolio | transactions addAll: anAccountOrPortfolio transactions].
	^transactions 
	 ! !


!Portfolio methodsFor: 'balance' stamp: 'pau 5/21/2023 22:11:30'!
balance
	^content sum:[:anAccountOrAPortfolio| anAccountOrAPortfolio balance]ifEmpty: [0]! !


!Portfolio methodsFor: 'initialize' stamp: 'pau 5/22/2023 15:56:42'!
initialize
	content := OrderedCollection new.
	roots := Set  with: self.! !

!Portfolio methodsFor: 'initialize' stamp: 'pau 5/22/2023 16:02:02'!
setRootPortfolio: rootPortfolios
	(roots = (Set with: self))
		ifTrue:[roots := rootPortfolios.]
		ifFalse: [roots addAll: rootPortfolios].
		
	content do:[:anAccountOrPortfolio|  anAccountOrPortfolio setRootPortfolio: rootPortfolios].
	! !


!Portfolio methodsFor: 'add-private' stamp: 'pau 5/22/2023 16:06:11'!
anyRootPortfolioHas: anAccountOrAPortfolio

	^ roots do: [:root| (root contains: anAccountOrAPortfolio)
					ifTrue: [self assertCannotAdd: anAccountOrAPortfolio].]! !

!Portfolio methodsFor: 'add-private' stamp: 'pau 5/22/2023 16:05:23'!
assertCannotAdd: anAccountOrAPortfolio

	^ self error: anAccountOrAPortfolio class cannotAddTwice! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error description' stamp: 'pau 5/21/2023 23:03:19'!
cannotAddTwice
	^ 'Portfolio already in portfolio'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
BankAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'pau 5/21/2023 22:01:43'!
balance

	^transactions inject: 0 into: [:balance :aTransaction | aTransaction addMyselfToBalance: balance ].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'pau 5/22/2023 15:51:31'!
contains: anAccount
	^ self = anAccount! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'add-private' stamp: 'pau 5/22/2023 15:25:23'!
setRootPortfolio: rootPortfolios
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Ejercicio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'error description' stamp: 'pau 5/21/2023 23:03:35'!
cannotAddTwice
	^ 'Account already in portfolio'! !
