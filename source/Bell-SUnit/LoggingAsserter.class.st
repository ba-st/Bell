"
I'm a kind of configurable test. 

My intention is to be used in composition relations with other tests that needs to test logging results.

Users need to provide a logger.
"
Class {
	#name : #LoggingAsserter,
	#superclass : #Object,
	#instVars : [
		'memoryLogger',
		'testCase'
	],
	#category : #'Bell-SUnit'
}

{ #category : #'instance creation' }
LoggingAsserter class >> on: aTestCase [ 
	
	^ self new initializeOn: aTestCase
]

{ #category : #asserting }
LoggingAsserter >> assertLogRecordsMatch: expectedLogEntries [

	memoryLogger recordings with: expectedLogEntries do: [ :record :expectedLogEntry | 
		testCase assert: ( record printString includesSubstring: expectedLogEntry ) ]
]

{ #category : #asserting }
LoggingAsserter >> assertLogRecordsMatchRegexes: regexExpressions [

  memoryLogger recordings with: regexExpressions do: [ :record :regexExpression |
      testCase
        assert: ( record printString matchesRegex: regexExpression )
        description:
        ( '<1s> does not match <2s>' expandMacrosWith: record printString with: regexExpression )
    ]
]

{ #category : #initialization }
LoggingAsserter >> initializeOn: aTestCase [ 

	memoryLogger := MemoryLogger new.
	testCase := aTestCase
]

{ #category : #running }
LoggingAsserter >> runMemoryLoggerDuring: aBlockClosure [

	memoryLogger runDuring: aBlockClosure
]

{ #category : #running }
LoggingAsserter >> stopLoggers [

	memoryLogger reset.
]
