"
A StandardStreamLoggerTest is a test class for testing the behavior of StandardStreamLogger
"
Class {
	#name : #StandardStreamLoggerTest,
	#superclass : #TestCase,
	#category : #'Bell-Logging-Tests'
}

{ #category : #tests }
StandardStreamLoggerTest >> testStandardError [

	| record |

	record := LogRecord withMessage: 'Test error' andStructuredDataBy: [  ].

	StandardStreamLogger onStandardError nextPut: record
]

{ #category : #tests }
StandardStreamLoggerTest >> testStandardErrorStreamLogger [

	StandardStreamLogger onStandardError runFor: LogRecord
		during: [ LogRecord emitInfo: 'Test' ]
]

{ #category : #tests }
StandardStreamLoggerTest >> testStandardOutput [

	| record |

	record := LogRecord withMessage: 'Test' andStructuredDataBy: [].

	StandardStreamLogger onStandardOutput nextPut: record
]

{ #category : #tests }
StandardStreamLoggerTest >> testStandardOutputStreamLogger [

	StandardStreamLogger onStandardOutput runFor: LogRecord
		during: [ LogRecord emitInfo: 'Test' ]
]
