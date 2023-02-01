"
A LaunchpadLogRecordTest is a test class for testing the behavior of LaunchpadLogRecord
"
Class {
	#name : #LogRecordTest,
	#superclass : #LaunchpadTest,
	#category : #'Bell-Logging-Tests'
}

{ #category : #tests }
LogRecordTest >> testEmitCombinedEvents [

	self
		runMemoryLoggerDuring: [ 
			self
				should: [ 
					LogRecord emitInfo: 'Starting app' during: [ 
						LogRecord emitInfo: 'Setting up data'.
						LogRecord emitWarning: 'Missing data, using default.'.
						Error signal
						]
					]
				raise: Error
			]
		assertingLogRecordsMatch:
			#( '[INFO] Starting app...'
				'[INFO] Setting up data'
				'[WARNING] Missing data, using default.'
			   '[ERROR] Starting app... [FAILED]' )
]

{ #category : #tests }
LogRecordTest >> testEmitDebug [

	self
		runMemoryLoggerDuring: [ LogRecord emitDebuggingInfo: 'Ouch!' ]
		assertingLogRecordsMatch: #( '[DEBUG] Ouch!' )
]

{ #category : #tests }
LogRecordTest >> testEmitError [

	self
		runMemoryLoggerDuring: [ LogRecord emitError: 'Ouch!' ]
		assertingLogRecordsMatch: #( '[ERROR] Ouch!' )
]

{ #category : #tests }
LogRecordTest >> testEmitInfo [

	self
		runMemoryLoggerDuring: [ LogRecord emitInfo: 'Starting' ]
		assertingLogRecordsMatch: #( '[INFO] Starting' )
]

{ #category : #tests }
LogRecordTest >> testEmitInfoDuring [

	| wasEvaluated |

	wasEvaluated := false.
	self
		runMemoryLoggerDuring: [ LogRecord emitInfo: 'Starting' during: [ wasEvaluated := true ] ]
		assertingLogRecordsMatch: #( 
			'[INFO] Starting...'
			'[INFO] Starting... [DONE]' ).
	self assert: wasEvaluated
]

{ #category : #tests }
LogRecordTest >> testEmitInfoDuringWhenActionFails [

	self
		runMemoryLoggerDuring: [ 
		self should: [ LogRecord emitInfo: 'Starting' during: [ Error signal ] ] raise: Error ]
		assertingLogRecordsMatch: #( 
			'[INFO] Starting...'
			'[ERROR] Starting... [FAILED]' )
]

{ #category : #tests }
LogRecordTest >> testEmitStructuredDebuggingInfo [

	self
		runMemoryLoggerDuring: [ 
			LogRecord
				emitStructuredDebuggingInfo: 'Ouch!'
				with: [ :data | data at: #errorCode put: 1234 ]
			]
		assertingLogRecordsMatch: #( '[DEBUG] Ouch! {"errorCode":1234}' )
]

{ #category : #tests }
LogRecordTest >> testEmitStructuredTraceInfo [

	self
		runMemoryLoggerDuring: [ 
			LogRecord
				emitStructuredTraceInfo: 'Ouch!'
				with: [ :data | data at: #errorCode put: 1234 ] ]
		assertingLogRecordsMatch: #( '[TRACE] Ouch! {"errorCode":1234}' )
]

{ #category : #tests }
LogRecordTest >> testEmitTrace [

	self
		runMemoryLoggerDuring: [ LogRecord emitTraceInfo: 'Ouch!' ]
		assertingLogRecordsMatch: #( '[TRACE] Ouch!' )
]

{ #category : #tests }
LogRecordTest >> testEmitWarning [

	self
		runMemoryLoggerDuring: [ LogRecord emitWarning: 'Missing value, using X as default' ]
		assertingLogRecordsMatch: #( '[WARNING] Missing value, using X as default' )
]

{ #category : #tests }
LogRecordTest >> testPrintOneLineJsonOn [

	"Tests structured JSON formatting for log records.
	The expected output is something like:
  	{'time':'2022-06-16T11:01:54.154679-03:00','level':'INFO','message':'Enabling free disk space monitoring','process':'Morphic UI Process','limit':'50MB','notify':true}	"

	| record logLine |

	record := LogRecord
		          withMessage: 'Enabling free disk space monitoring'
		          andStructuredDataBy: [ :data | 
			          data
				          at: #limit put: '50MB';
				          at: #notify put: true
			          ].

	logLine := String streamContents: [ :s | record printOneLineJsonOn: s ].

	self
		assert: ( logLine beginsWith: '{"time":"' );
		assert: ( logLine includesSubstring:
					  '","level":"INFO","message":"Enabling free disk space monitoring","process":"' );
		assert: ( logLine endsWith: '","limit":"50MB","notify":true}' )
]
