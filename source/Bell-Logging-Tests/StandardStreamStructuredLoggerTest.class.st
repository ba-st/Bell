"
A StandardStreamStructuredLoggerTest is a test class for testing the behavior of StandardStreamStructuredLogger
"
Class {
	#name : #StandardStreamStructuredLoggerTest,
	#superclass : #TestCase,
	#category : #'Bell-Logging-Tests'
}

{ #category : #tests }
StandardStreamStructuredLoggerTest >> testStandardError [

	| record |

	record := LogRecord withMessage: 'Test error' andStructuredDataBy: [  ].

	StandardStreamStructuredLogger onStandardError nextPut: record
]

{ #category : #tests }
StandardStreamStructuredLoggerTest >> testStandardErrorStreamLogger [

	StandardStreamStructuredLogger onStandardError runFor: LogRecord during: [ 
		LogRecord
			emitStructuredTraceInfo: 'Test'
			with: [ :data | data at: #testSelector put: testSelector ]
		]
]

{ #category : #tests }
StandardStreamStructuredLoggerTest >> testStandardOutput [

	| record |

	record := LogRecord withMessage: 'Test' andStructuredDataBy: [  ].

	StandardStreamStructuredLogger onStandardOutput nextPut: record
]

{ #category : #tests }
StandardStreamStructuredLoggerTest >> testStandardOutputStreamLogger [

	StandardStreamStructuredLogger onStandardOutput runFor: LogRecord during: [ 
		LogRecord
			emitStructuredTraceInfo: 'Test'
			with: [ :data | data at: #testSelector put: testSelector ]
		]
]
