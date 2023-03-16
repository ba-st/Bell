Class {
	#name : #LogRecord,
	#superclass : #BeaconSignal,
	#category : #'Bell-Logging'
}

{ #category : #actions }
LogRecord class >> emitDebuggingInfo: aString [

	^ self emitStructuredDebuggingInfo: aString with: [  ]
]

{ #category : #actions }
LogRecord class >> emitError: aString [

	^ ( self withMessage: aString andStructuredDataBy: [  ] )
		  beError;
		  emit
]

{ #category : #actions }
LogRecord class >> emitInfo: aString [

	^ ( self withMessage: aString andStructuredDataBy: [  ] ) emit
]

{ #category : #actions }
LogRecord class >> emitInfo: aString during: aBlock [

	self emitInfo: aString , '...'.
	[ 
	aBlock value.
	self emitInfo: aString , '... [DONE]'
	] ifCurtailed: [ self emitError: aString , '... [FAILED]' ]
]

{ #category : #actions }
LogRecord class >> emitStructuredDebuggingInfo: aString with: aBlock [

	^ ( self withMessage: aString andStructuredDataBy: aBlock )
		  beForDebugging;
		  emit
]

{ #category : #actions }
LogRecord class >> emitStructuredTraceInfo: aString with: aBlock [

	^ ( self withMessage: aString andStructuredDataBy: aBlock )
		  beForTracing;
		  emit
]

{ #category : #actions }
LogRecord class >> emitTraceInfo: aString [

	^ self emitStructuredTraceInfo: aString with: [  ]
]

{ #category : #actions }
LogRecord class >> emitWarning: aString [

	^ ( self withMessage: aString andStructuredDataBy: [  ] )
		  beWarning;
		  emit
]

{ #category : #'instance creation' }
LogRecord class >> withMessage: aString andStructuredDataBy: aBlock [

	^ self new initializeWithMessage: aString andStructuredDataBy: aBlock
]

{ #category : #private }
LogRecord >> beError [

	self properties at: #logLevel put: 'ERROR'
]

{ #category : #private }
LogRecord >> beForDebugging [

	self properties at: #logLevel put: 'DEBUG'
]

{ #category : #private }
LogRecord >> beForTracing [

	self properties at: #logLevel put: 'TRACE'
]

{ #category : #private }
LogRecord >> beWarning [

	self properties at: #logLevel put: 'WARNING'
]

{ #category : #initialization }
LogRecord >> initializeWithMessage: aString andStructuredDataBy: aBlock [

	| data |

	self properties at: #messageText put: aString.
	data := OrderedDictionary new.
	aBlock cull: data.
	self properties at: #data put: data
]

{ #category : #testing }
LogRecord >> isInformational [

	^ #( 'INFO' 'TRACE' 'DEBUG' ) includes: self logLevel
]

{ #category : #accessing }
LogRecord >> logLevel [

	^ self properties at: #logLevel ifAbsent: [ 'INFO' ]
]

{ #category : #accessing }
LogRecord >> messageText [

	^ self properties at: #messageText
]

{ #category : #printing }
LogRecord >> printOneLineContentsOn: stream [

	stream nextPutAll: self messageText.
	( self properties at: #data ) ifNotEmpty: [ :data | 
		stream
			space;
			nextPutAll: ( NeoJSONWriter toString: data )
		]
]

{ #category : #printing }
LogRecord >> printOneLineJsonOn: stream [

	| json |

	json := OrderedDictionary new.
	json
		at: #time put: self timestamp asString;
		at: #level put: self logLevel;
		at: #message put: self messageText;
		at: #process put: self processId.

	( self properties at: #data ) keysAndValuesDo: [ :key :value | json at: key put: value ].

	stream nextPutAll: ( NeoJSONWriter toString: json )
]

{ #category : #printing }
LogRecord >> printOneLineOn: stream [

	stream
		nextPutAll: self timestamp asString;
		space;
		nextPut: $[;
		nextPutAll: self logLevel;
		nextPut: $];
		space.
	self printOneLineContentsOn: stream
]
