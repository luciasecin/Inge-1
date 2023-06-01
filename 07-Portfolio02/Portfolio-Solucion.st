!classDefinition: #AccountSummaryTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'pau 5/31/2023 20:36:24'!
test01EmptyAccountSummaryHasOnlyBalance0
	
	| account summary expectedSummary|
	
	account := ReceptiveAccount new.
	summary := AccountSummary for: account. 
	expectedSummary := 'Balance = 0'.

	self assert: (summary printSummary) equals: expectedSummary.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'pau 5/31/2023 20:38:02'!
test02AccountWithDepositPrintsSummaryCorrectly
	
	| account expectedSummary summary |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	expectedSummary := 'Depósito por 100.
Balance = 100'.
	
	summary := AccountSummary for: account. 
	self assert: (summary printSummary) equals: expectedSummary.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'pau 5/31/2023 20:46:06'!
test03AccountWithDepositAndWithdrawalPrintsSummaryCorrectly
	
	| account expectedSummary summary |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	expectedSummary := 'Depósito por 100.
Extracción por 50.
Balance = 50'.

	summary := AccountSummary for: account. 
	self assert: (summary printSummary)equals: expectedSummary.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'pau 5/31/2023 20:46:10'!
test04AccountWithTransferenceInPrintsSummaryCorrectly
	
	| account expectedSummary summary |
	
	account := ReceptiveAccount new.
	Transference from: (ReceptiveAccount new) transfer: 30 to: account.
	expectedSummary := 'Entrada por transferencia de 30.
Balance = 30'.

	summary := AccountSummary for: account. 
	self assert: (summary printSummary)equals: expectedSummary.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'pau 5/31/2023 20:46:16'!
test05AccountWithTransferenceOutPrintsSummaryCorrectly
	
	| account expectedSummary summary |
	
	account := ReceptiveAccount new.
	Transference from: account transfer: 30 to:  (ReceptiveAccount new).
	expectedSummary := 'Salida por transferencia de 30.
Balance = -30'.

	summary := AccountSummary for: account. 
	self assert: (summary printSummary)equals: expectedSummary.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'pau 5/31/2023 20:07:21'!
test06EmptyPortfolioSummaryHasOnlyBalance0
	
	| portfolio expectedSummary summary |
	
	portfolio := Portfolio new.
	expectedSummary := 'Balance = 0'.

	summary := AccountSummary for: portfolio . 
	self assert: (summary printSummary) equals: expectedSummary.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'pau 5/31/2023 20:46:23'!
test07PortfolioWithOneAccountPrintsSummaryCorrectly
	
	| account portfolio expectedSummary summary |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	expectedSummary := 'Depósito por 100.
Balance = 100'.

	summary := AccountSummary for: portfolio . 
	self assert: (summary printSummary) equals: expectedSummary.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'pau 5/31/2023 20:46:26'!
test08PortfolioWithTwoAccountsPrintsSummaryCorrectly
	
	| account1 account2 portfolio expectedSummary summary |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account2.
	portfolio := Portfolio with: account1 with: account2.
	
	expectedSummary := 'Depósito por 100.
Extracción por 50.
Balance = 50'.

	summary := AccountSummary for: portfolio . 
	self assert: (summary printSummary) equals: expectedSummary.! !


!classDefinition: #IndentedReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #IndentedReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!IndentedReportTest methodsFor: 'as yet unclassified' stamp: 'pau 6/1/2023 16:19:55'!
test01PortfolioWithOneAccountHasCorrectlyIndentedTheReportOfThatAccount
	
	|portfolio indentedReport account expectedReport |
	
	account := ReceptiveAccount named: 'Cuenta de Homero'.
	
	portfolio:= Portfolio named: 'Portfolio de la familia' with: account.
	
	indentedReport := IndentedReport with: portfolio. 
	
	expectedReport := 
'Portfolio de la familia
	Cuenta de Homero
		Balance = 0'.
	
	self assert:  indentedReport report equals: expectedReport. ! !

!IndentedReportTest methodsFor: 'as yet unclassified' stamp: 'pau 6/1/2023 16:39:07'!
test02PortfolioWithTwoAccountHasCorrectlyIndentedTheReportOfThatAccount
	
	|portfolio indentedReport accountHomer expectedReport accountMarge |
	
	accountHomer := ReceptiveAccount named: 'Cuenta de Homero'.
	accountMarge := ReceptiveAccount named: 'Cuenta de Marge'.
	
	portfolio:= Portfolio named: 'Portfolio de la familia' with: accountHomer.
	portfolio add: accountMarge. 
	
	indentedReport := IndentedReport with: portfolio. 
	
	expectedReport := 
'Portfolio de la familia
	Cuenta de Homero
		Balance = 0
	Cuenta de Marge
		Balance = 0'.
	
	self assert:  indentedReport report equals: expectedReport. ! !

!IndentedReportTest methodsFor: 'as yet unclassified' stamp: 'pau 6/1/2023 17:01:47'!
test03PortfolioWithOneAccountWithMultipleTransactionsHasCorrectlyIndentedTheReportOfThatAccount
	
	|portfolio indentedReport account expectedReport |
	
	account := ReceptiveAccount named: 'Cuenta de Homero'.
	Deposit register:  10 on: account; register: 100 on:account.  
	
	portfolio:= Portfolio named: 'Portfolio de la familia' with: account.
	
	indentedReport := IndentedReport with: portfolio. 
	
	expectedReport := 
'Portfolio de la familia
	Cuenta de Homero
		Depósito por 10.
		Depósito por 100.
		Balance = 110'.
	
	self assert:  indentedReport report equals: expectedReport. ! !


!classDefinition: #PortfolioStructureTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioStructureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioStructureTest methodsFor: 'tests' stamp: 'pau 6/1/2023 16:02:56'!
test01emptyPortfolioOnlyHasTheNameOfThatPortfolio
	|portfolio portfolioName portfolioStructure |
	
	portfolioName := 'Soy el portfolio solitario'. 
	
	portfolio:= Portfolio named: portfolioName .
	
	portfolioStructure := PortfolioStructureReport with: portfolio. 
	
	self assert:  portfolioStructure portfolioStructure equals: portfolioName. ! !

!PortfolioStructureTest methodsFor: 'tests' stamp: 'pau 6/1/2023 16:02:56'!
test02PortfolioWithOneAccountHasTheNameOfBoths
	
	|portfolio portfolioStructure account expectedPortfolioStructure |
	
	account := ReceptiveAccount named: 'Cuenta de Homero'.
	
	portfolio:= Portfolio named: 'Portfolio de la familia' with: account.
	
	portfolioStructure := PortfolioStructureReport with: portfolio. 
	
	expectedPortfolioStructure := 
'Portfolio de la familia
	Cuenta de Homero'.
	
	self assert:  portfolioStructure portfolioStructure equals: expectedPortfolioStructure. ! !

!PortfolioStructureTest methodsFor: 'tests' stamp: 'pau 6/1/2023 16:02:56'!
test03PortfolioWithTwoAccountsHasTheNameOfBothAccountsAndPortfolio
	
	|portfolio portfolioStructure account expectedPortfolioStructure account2 |
	
	account := ReceptiveAccount named: 'Cuenta de Homero'.
	account2 := ReceptiveAccount named: 'Cuenta de Marge'.
	
	portfolio:= Portfolio named: 'Portfolio de la familia' with: account.
	portfolio add: account2.
	
	portfolioStructure := PortfolioStructureReport with: portfolio. 
	
	expectedPortfolioStructure := 
'Portfolio de la familia
	Cuenta de Homero
	Cuenta de Marge'.
	
	self assert:  portfolioStructure portfolioStructure equals: expectedPortfolioStructure. ! !

!PortfolioStructureTest methodsFor: 'tests' stamp: 'pau 6/1/2023 16:02:56'!
test04PortfolioWithAccountAndPortfolioHasTheNameOfBothAccountAndPortfolios
	
	|portfolio portfolioStructure accountHomero expectedPortfolioStructure portfolioMarge accountMarge |
	
	accountHomero := ReceptiveAccount named: 'Cuenta de Homero'.
	accountMarge := ReceptiveAccount named: 'Cuenta de Marge'. 
	
	portfolioMarge:= Portfolio named: 'Portfolio de Marge' with: accountMarge.
	
	portfolio:= Portfolio named: 'Portfolio de la familia' with: accountHomero.
	portfolio  add: portfolioMarge . 
	
	portfolioStructure := PortfolioStructureReport with: portfolio. 
	
	expectedPortfolioStructure := 
'Portfolio de la familia
	Cuenta de Homero
	Portfolio de Marge
		Cuenta de Marge'.
	
	self assert:  portfolioStructure portfolioStructure equals: expectedPortfolioStructure. ! !

!PortfolioStructureTest methodsFor: 'tests' stamp: 'pau 6/1/2023 16:02:56'!
test05PortfolioWithAccountAndPortfoliosHasTheNameOfThem
	
	|portfolio portfolioStructure accountHomero expectedPortfolioStructure portfolioMarge accountMarge accountLisa1 accountLisa2 portfolioLisa |
	
	accountHomero := ReceptiveAccount named: 'Cuenta de Homero'.
	accountMarge := ReceptiveAccount named: 'Cuenta de Marge'. 
	
	accountLisa1 := ReceptiveAccount named: 'Cuenta de Lisa'.
	accountLisa2 := ReceptiveAccount named: 'Cuenta de Lisa para la universidad'. 
	
	portfolioMarge:= Portfolio named: 'Portfolio de Marge' with: accountMarge.
	
	
	portfolioLisa:= Portfolio named: 'Portfolio de Lisa' with: accountLisa1.
	portfolioLisa add: accountLisa2. 
	portfolioMarge add: portfolioLisa. 
	
	portfolio:= Portfolio named: 'Portfolio de la familia' with: accountHomero.
	portfolio  add: portfolioMarge . 
	
	portfolioStructure := PortfolioStructureReport with: portfolio. 
	
	expectedPortfolioStructure := 
'Portfolio de la familia
	Cuenta de Homero
	Portfolio de Marge
		Cuenta de Marge
		Portfolio de Lisa
			Cuenta de Lisa
			Cuenta de Lisa para la universidad'.
	
	self assert:  portfolioStructure portfolioStructure equals: expectedPortfolioStructure. ! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #TransferNetTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'tests' stamp: 'pau 5/31/2023 18:04:33'!
test01AccountWithNoTransferenceGivesZero

	| account  tranferNet|
	
	account := ReceptiveAccount new.
	tranferNet := TransferNet for: account. 
	
	self assert: (tranferNet tranferNet ) equals: 0.! !

!TransferNetTest methodsFor: 'tests' stamp: 'pau 5/31/2023 18:08:02'!
test02ReceivingAccountOfOnlyOneTranferenceThenTranferNetIsTheAmountOfThanTransference

	| senderAccount receivingAccount tranference tranferNet |
	
	senderAccount := ReceptiveAccount new.
	receivingAccount := ReceptiveAccount new.
	tranference := Transference from: senderAccount transfer: 10 to: receivingAccount.
	
	tranferNet := TransferNet for: receivingAccount. 
	
	self assert: (tranferNet tranferNet) equals: 10.! !

!TransferNetTest methodsFor: 'tests' stamp: 'pau 5/31/2023 18:21:23'!
test03SenderAccountOfOnlyOneTranferenceThenTranferNetTheNegativeOfTheTransferedAmount

	| senderAccount receivingAccount tranference tranferNet |
	
	senderAccount := ReceptiveAccount new.
	receivingAccount := ReceptiveAccount new.
	tranference := Transference from: senderAccount transfer: 10 to: receivingAccount.
	
	tranferNet := TransferNet for: senderAccount. 
	
	self assert: (tranferNet tranferNet) equals: -10.! !

!TransferNetTest methodsFor: 'tests' stamp: 'pau 5/31/2023 18:27:21'!
test04TranferNetOfAccountWithMultipleTranferencesIsTheSumOfAllTransferences

	| account1 account2 tranferNet tranference1 tranference2 tranference3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	tranference1 := Transference from: account1 transfer: 100 to: account2.
	tranference2 := Transference from: account2 transfer: 10 to: account1.
	tranference3 := Transference from: account1 transfer: 100 to: account2.
	tranferNet := TransferNet for: account2. 
	
	self assert: (tranferNet tranferNet) equals: 190.! !

!TransferNetTest methodsFor: 'tests' stamp: 'pau 5/31/2023 18:34:32'!
test05TranferNetOfAnEmptyPortfolioIs0
	| portfolio transferNet |
	
	portfolio := Portfolio new.
	transferNet := TransferNet for: portfolio. 

	self assert: (transferNet tranferNet) equals: 0.! !

!TransferNetTest methodsFor: 'tests' stamp: 'pau 5/31/2023 18:39:56'!
test06TranferNetOfAnPortfolioThatHasOneAccountWithTranference
	| portfolio transferNet receptiveAccont1 receptiveAccont2 tranference |
	
	portfolio := Portfolio new.
	receptiveAccont1 := ReceptiveAccount new.
	receptiveAccont2 := ReceptiveAccount new.
	portfolio add: receptiveAccont1. 
	
	tranference := Transference from:  receptiveAccont1  transfer: 100  to:receptiveAccont2 . 

	transferNet := TransferNet for: portfolio. 

	self assert: (transferNet tranferNet) equals: -100.! !

!TransferNetTest methodsFor: 'tests' stamp: 'pau 6/1/2023 15:51:42'!
test07AccountWithMoreTransactionsOnlyAddTranferences
	| portfolio transferNet receptiveAccont1 receptiveAccont2 tranference deposit1 deposit2 |
	
	portfolio := Portfolio new.
	receptiveAccont1 := ReceptiveAccount new.
	receptiveAccont2 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: receptiveAccont1.
	deposit2 := Deposit register: 100 on: receptiveAccont2.
	
	portfolio add: receptiveAccont1. 
	
	tranference := Transference from:  receptiveAccont1  transfer: 100  to:receptiveAccont2 . 

	transferNet := TransferNet for: portfolio. 
	
	
	self assert: (transferNet tranferNet) equals: -100.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetTest class' category: 'Portfolio-Solucion'!
TransferNetTest class
	instanceVariableNames: 'ranferNetOfAnEmptyPortfolioIs0'!


!classDefinition: #TransferenceTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceTest methodsFor: 'test' stamp: 'luct 5/22/2023 21:50:37'!
test01TransactionChangesAccountBalancesCorrectly

	|senderAccount receivingAccount transference|
	
	senderAccount := ReceptiveAccount new.
	receivingAccount := ReceptiveAccount new.
	
	transference := Transference from: senderAccount transfer: 10 to: receivingAccount.
	
	self assert: (senderAccount balance) equals: -10.
	self assert: (receivingAccount balance) equals: 10.! !

!TransferenceTest methodsFor: 'test' stamp: 'pau 6/1/2023 16:08:19'!
test02SenderAndReceiverHaveRegisteredTransference

	|senderAccount receivingAccount transference|
	
	senderAccount := ReceptiveAccount new.
	receivingAccount := ReceptiveAccount new.
	
	transference := Transference from: senderAccount transfer: 10 to: receivingAccount.
	
	self assert: (senderAccount hasRegistered: (transference sentTransaction)).
	self assert: (receivingAccount hasRegistered: (transference receivedTransaction )).! !

!TransferenceTest methodsFor: 'test' stamp: 'pau 6/1/2023 16:08:32'!
test04CanNavigateToAndFromBothEndsOfTransference

	|senderAccount receivingAccount transference|
	
	senderAccount := ReceptiveAccount new.
	receivingAccount := ReceptiveAccount new.
	
	transference := Transference from: senderAccount transfer: 10 to: receivingAccount.
	
	self assert: (transference sentTransaction receiverTransaction) equals: transference receivedTransaction.
	self assert: (transference receivedTransaction senderTransaction) equals: transference sentTransaction.! !

!TransferenceTest methodsFor: 'test' stamp: 'pau 6/1/2023 16:08:38'!
test05CanNotTransferToYourself

	| account |
	
	account := ReceptiveAccount new.

	self 
		should: [ Transference from: account transfer: 10 to: account]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Transference canNotTransferToYourselfErrorMessage equals: anError messageText.]! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'visit' stamp: 'pau 6/1/2023 15:40:51'!
visit: aVisitor
	self subclassResponsibility. ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'visitors' stamp: 'pau 6/1/2023 14:37:20'!
addTo: aVisitor
	
	aVisitor addPortfolio: self. ! !

!Portfolio methodsFor: 'visitors' stamp: 'pau 6/1/2023 14:27:01'!
visit: aVisitor
	
	accounts do: [ :anAccount | aVisitor addTo: anAccount]
	
	
	

	! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'pau 6/1/2023 14:29:48'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'pau 6/1/2023 11:02:12'!
initializeNamed: aName

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := aName.	! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'name' stamp: 'pau 6/1/2023 11:05:23'!
name
	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'pau 6/1/2023 10:59:20'!
named: aName
	^self new initializeNamed: aName! !

!Portfolio class methodsFor: 'instance creation' stamp: 'pau 6/1/2023 11:41:40'!
named: aName with: anAccount

	^self new initializeNamed: aName ;add: anAccount
		! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!Portfolio class methodsFor: 'error description' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'pau 6/1/2023 11:03:07'!
initialize
	
	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'pau 6/1/2023 11:32:47'!
initializeNamed: aName
	
	super initialize.
	transactions := OrderedCollection new.
	name := aName.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'lucy 5/28/2023 18:55:43'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'visitors' stamp: 'pau 6/1/2023 14:33:35'!
addTo: aVisitor
	aVisitor addAccount: self.! !

!ReceptiveAccount methodsFor: 'visitors' stamp: 'pau 6/1/2023 15:39:51'!
visit: aVisitor

	transactions do:[:aTransaction| aTransaction addTo: aVisitor]! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'name' stamp: 'pau 6/1/2023 11:47:53'!
name
	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'pau 6/1/2023 11:38:30'!
named: aName
	^self new initializeNamed: aName ! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'summary' stamp: 'pau 6/1/2023 10:36:45'!
addTo: aSummaryCollection

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'add - private-' stamp: 'pau 6/1/2023 10:36:45'!
addTo: aSummary
	aSummary addDepositTo: self. 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transference category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Transference
	instanceVariableNames: 'sentTransaction receivedTransaction value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transference methodsFor: 'sender' stamp: 'lucy 5/28/2023 12:30:47'!
sentTransaction 

	^sentTransaction! !


!Transference methodsFor: 'initialization' stamp: 'pau 6/1/2023 16:13:13'!
initializeSend: anAmount from: senderAccount to: receivingAccount

	(senderAccount = receivingAccount ) ifTrue: [self error: self class canNotTransferToYourselfErrorMessage].

	value := anAmount.
	
	receivedTransaction := TransferenceIn for: self.
	sentTransaction := TransferenceOut for: self.
	
	senderAccount register: sentTransaction.
	receivingAccount register: receivedTransaction.
! !


!Transference methodsFor: 'receiver' stamp: 'lucy 5/28/2023 12:31:05'!
receivedTransaction

	^receivedTransaction ! !


!Transference methodsFor: 'balance' stamp: 'lucy 5/28/2023 13:40:20'!
affectBalance: aBalance

	self subclassResponsibility ! !

!Transference methodsFor: 'balance' stamp: 'lucy 5/28/2023 13:40:29'!
value

	^value! !


!Transference methodsFor: 'add-private' stamp: 'pau 6/1/2023 10:36:45'!
addTo: aSummaryCollection

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'Portfolio-Solucion'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'instance creation' stamp: 'lucy 5/31/2023 16:24:49'!
canNotTransferToYourselfErrorMessage 
	
	^'Cannot transfer money to yourself'! !

!Transference class methodsFor: 'instance creation' stamp: 'lucy 5/28/2023 13:28:53'!
from: senderAccount transfer: anAmount to: receivingAccount
	
	^self new initializeSend: anAmount from: senderAccount to: receivingAccount ! !


!classDefinition: #TransferenceIn category: 'Portfolio-Solucion'!
Transference subclass: #TransferenceIn
	instanceVariableNames: 'sender transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceIn methodsFor: 'balance' stamp: 'lucy 5/28/2023 13:49:07'!
affectBalance: aBalance

	^aBalance + transference value! !


!TransferenceIn methodsFor: 'amount' stamp: 'lucy 5/31/2023 16:27:12'!
amountReceived

	^transference value! !


!TransferenceIn methodsFor: 'sender' stamp: 'lucy 5/28/2023 17:42:06'!
senderTransaction

	^transference sentTransaction ! !


!TransferenceIn methodsFor: 'initalization' stamp: 'pau 6/1/2023 16:11:20'!
initializeWith: aTransference.

	transference := aTransference.! !


!TransferenceIn methodsFor: 'add -private-' stamp: 'pau 6/1/2023 10:36:45'!
addTo: aSummary

	aSummary addTranferenceInTo: self.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceIn class' category: 'Portfolio-Solucion'!
TransferenceIn class
	instanceVariableNames: ''!

!TransferenceIn class methodsFor: 'instance creation' stamp: 'pau 6/1/2023 16:12:20'!
for: aTransference

	^self new initializeWith: aTransference .! !


!classDefinition: #TransferenceOut category: 'Portfolio-Solucion'!
Transference subclass: #TransferenceOut
	instanceVariableNames: 'receiver transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceOut methodsFor: 'receiver' stamp: 'lucy 5/28/2023 17:42:31'!
receiverTransaction

	^transference receivedTransaction ! !


!TransferenceOut methodsFor: 'amount' stamp: 'lucy 5/31/2023 16:29:10'!
amountSent

	^transference value! !


!TransferenceOut methodsFor: 'balance' stamp: 'lucy 5/28/2023 13:43:42'!
affectBalance: aBalance

	^aBalance - transference value! !


!TransferenceOut methodsFor: 'initialization' stamp: 'pau 6/1/2023 16:11:01'!
initializeWith: aTransference.

	transference := aTransference.! !


!TransferenceOut methodsFor: 'add -private-' stamp: 'pau 6/1/2023 10:36:45'!
addTo: aSummary

	aSummary addTranferenceOutTo:self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceOut class' category: 'Portfolio-Solucion'!
TransferenceOut class
	instanceVariableNames: ''!

!TransferenceOut class methodsFor: 'instance creation' stamp: 'pau 6/1/2023 16:12:35'!
for: aTransference

	^self new initializeWith: aTransference .! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'add -private-' stamp: 'pau 6/1/2023 10:36:45'!
addTo: aSummary

	aSummary addWithdrawTo: self.! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #ReportVisitor category: 'Portfolio-Solucion'!
Object subclass: #ReportVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportVisitor methodsFor: 'add transactions' stamp: 'pau 6/1/2023 10:38:09'!
addDepositTo: aDeposited! !

!ReportVisitor methodsFor: 'add transactions' stamp: 'pau 6/1/2023 10:38:48'!
addTransferInTo: aTransferIn
! !

!ReportVisitor methodsFor: 'add transactions' stamp: 'pau 6/1/2023 10:38:53'!
addTransferOutTo: aTransferOut
! !

!ReportVisitor methodsFor: 'add transactions' stamp: 'pau 6/1/2023 10:38:30'!
addWithdrawTo: aWithdraw
! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
ReportVisitor subclass: #AccountSummary
	instanceVariableNames: 'summary account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialize' stamp: 'pau 5/31/2023 20:12:39'!
initializeWith: anAccount 
	account := anAccount.
	summary := OrderedCollection new.! !


!AccountSummary methodsFor: 'print summary' stamp: 'pau 6/1/2023 12:57:27'!
printSummary
	| balance final_summary |
	account visit: self. 
	
	final_summary := summary inject: '' into: [:finalSummary :string | finalSummary,string, ((Character numericValue: 10) asString)].
	
	balance := ('Balance = ', account balance asString) asString.
	
	^final_summary,balance! !


!AccountSummary methodsFor: 'log transactions -private' stamp: 'pau 6/1/2023 10:33:54'!
addDepositTo: aDeposited

	summary add: 'Depósito por ', aDeposited value asString, '.'.
	! !

!AccountSummary methodsFor: 'log transactions -private' stamp: 'pau 6/1/2023 14:26:33'!
addTo: anAccount

	anAccount visit: self.
	! !

!AccountSummary methodsFor: 'log transactions -private' stamp: 'pau 6/1/2023 10:34:07'!
addTranferenceInTo: transferIn

	summary add: 'Entrada por transferencia de ', transferIn amountReceived asString, '.'.! !

!AccountSummary methodsFor: 'log transactions -private' stamp: 'pau 6/1/2023 10:34:21'!
addTranferenceOutTo: aTransferenceOut

	summary add: 'Salida por transferencia de ', aTransferenceOut amountSent asString, '.'.! !

!AccountSummary methodsFor: 'log transactions -private' stamp: 'pau 6/1/2023 10:34:35'!
addWithdrawTo: aWithdraw

	summary add: 'Extracción por ', aWithdraw value asString, '.'.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'pau 5/31/2023 20:01:49'!
for: anAccount
	^self new initializeWith: anAccount ! !


!classDefinition: #IndentedReport category: 'Portfolio-Solucion'!
ReportVisitor subclass: #IndentedReport
	instanceVariableNames: 'portfolio report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!IndentedReport methodsFor: 'initialize' stamp: 'pau 6/1/2023 16:34:28'!
initializeWith: aPortfolio
	portfolio := aPortfolio.
	report := ''. ! !


!IndentedReport methodsFor: 'report' stamp: 'pau 6/1/2023 16:37:16'!
report
	portfolio visit: self.
	^portfolio name, report! !


!IndentedReport methodsFor: 'add-private' stamp: 'pau 6/1/2023 17:01:04'!
addAccount: aReceptiveAccount
	
	| newLine summary tab tabbedSummary |
	summary := (AccountSummary for: aReceptiveAccount) printSummary. 
	newLine := (Character numericValue: 10) asString. 
	tab := (Character numericValue: 9) asString. 
	tabbedSummary := String new.
	
	summary do: [:char | (char = (Character numericValue: 10)) 
					ifTrue: [tabbedSummary := tabbedSummary, newLine,tab,tab.]
                             					ifFalse:[tabbedSummary := tabbedSummary,char asString]].
				
	report := report,newLine,tab, (aReceptiveAccount name), newLine, tab, tab, tabbedSummary .
	
	! !

!IndentedReport methodsFor: 'add-private' stamp: 'pau 6/1/2023 16:32:01'!
addTo: anAccount
	anAccount addTo: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IndentedReport class' category: 'Portfolio-Solucion'!
IndentedReport class
	instanceVariableNames: ''!

!IndentedReport class methodsFor: 'instance creation' stamp: 'pau 6/1/2023 16:20:15'!
with: aPortfolio 
	^self new initializeWith: aPortfolio ! !


!classDefinition: #PortfolioStructureReport category: 'Portfolio-Solucion'!
ReportVisitor subclass: #PortfolioStructureReport
	instanceVariableNames: 'portfolio accountNames porfoliosNames'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioStructureReport methodsFor: 'initialize' stamp: 'pau 6/1/2023 14:52:44'!
initializeWith: aPortfolio 
	portfolio := aPortfolio.
	portfolioStructure:= OrderedCollection new.
	accountNames := OrderedCollection new.
	porfoliosNames := OrderedCollection new.
	! !


!PortfolioStructureReport methodsFor: 'portfolio structure' stamp: 'pau 6/1/2023 15:36:55'!
portfolioStructure
	
	| newLine finalPortfolioStructure|
	newLine:= (Character numericValue: 10) asString. 
	portfolio visit: self. 
	
	finalPortfolioStructure := String new. 
	accountNames do: [:aName| finalPortfolioStructure := finalPortfolioStructure, newLine,aName].
	
	porfoliosNames do: [:aPortfolioStructure| finalPortfolioStructure := finalPortfolioStructure, (aPortfolioStructure addTabsToPortolioStructure) ].
	
	^portfolio name, finalPortfolioStructure! !


!PortfolioStructureReport methodsFor: 'add-private-' stamp: 'pau 6/1/2023 14:52:59'!
addAccount: anAccount 
	accountNames add: ( (Character numericValue: 9) asString , (anAccount name))! !

!PortfolioStructureReport methodsFor: 'add-private-' stamp: 'pau 6/1/2023 16:02:56'!
addPortfolio: aPortfolio
	|portfolioStructureSubPortfolio|
	
	portfolioStructureSubPortfolio := PortfolioStructureReport with: aPortfolio.
	porfoliosNames add: portfolioStructureSubPortfolio. ! !

!PortfolioStructureReport methodsFor: 'add-private-' stamp: 'pau 6/1/2023 15:31:51'!
addTabsToPortolioStructure
	|tab newLine tabbedPortfolioStructure portfolioStruct | 
	
	newLine:= (Character numericValue: 10) asString. 
	tab := (Character numericValue: 9) asString. 
	
	tabbedPortfolioStructure := String new,newLine, tab.
	portfolioStruct := self portfolioStructure. 
	
	portfolioStruct do: [:char | (char = (Character numericValue: 10)) 
									ifTrue: [tabbedPortfolioStructure := tabbedPortfolioStructure, newLine,tab.]
				                             					ifFalse:[tabbedPortfolioStructure:= tabbedPortfolioStructure,char asString]].
	^tabbedPortfolioStructure.! !

!PortfolioStructureReport methodsFor: 'add-private-' stamp: 'pau 6/1/2023 14:35:37'!
addTo: anAccount

	anAccount addTo: self. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioStructureReport class' category: 'Portfolio-Solucion'!
PortfolioStructureReport class
	instanceVariableNames: ''!

!PortfolioStructureReport class methodsFor: 'instance creation' stamp: 'pau 6/1/2023 11:03:52'!
with: aPortfolio 
	^self new initializeWith: aPortfolio ! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
ReportVisitor subclass: #TransferNet
	instanceVariableNames: 'account tranferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialize' stamp: 'pau 5/31/2023 19:57:20'!
initializeWithAccount: anAccount 
	tranferNet := 0.
	account := anAccount.! !


!TransferNet methodsFor: 'tranfer net' stamp: 'pau 6/1/2023 12:57:27'!
tranferNet
	account visit: self. 
	^tranferNet ! !


!TransferNet methodsFor: 'add tranference -private-' stamp: 'pau 6/1/2023 15:46:26'!
addDepositTo: aDeposit! !

!TransferNet methodsFor: 'add tranference -private-' stamp: 'pau 6/1/2023 14:27:23'!
addTo: anAccount
	anAccount visit: self! !

!TransferNet methodsFor: 'add tranference -private-' stamp: 'pau 6/1/2023 10:41:39'!
addTranferenceInTo: aTransferenceIn 
	tranferNet := tranferNet + aTransferenceIn amountReceived . ! !

!TransferNet methodsFor: 'add tranference -private-' stamp: 'pau 6/1/2023 13:10:59'!
addTranferenceOutTo: aTransferenceOut 
	tranferNet := tranferNet - aTransferenceOut amountSent. ! !

!TransferNet methodsFor: 'add tranference -private-' stamp: 'pau 6/1/2023 15:46:43'!
addWithdrawTo: aWithdraw! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'transferNet' stamp: 'pau 5/31/2023 18:09:07'!
for: account
	^self new initializeWithAccount: account ! !
