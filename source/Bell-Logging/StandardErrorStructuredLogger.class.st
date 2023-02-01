Class {
	#name : #StandardErrorStructuredLogger,
	#superclass : #StandardStreamStructuredLogger,
	#category : #'Bell-Logging-Bell-Logging'
}

{ #category : #accessing }
StandardErrorStructuredLogger class >> instance [

	^ super instance
		  initializeOn: Stdio stderr;
		  yourself
]

{ #category : #initialization }
StandardErrorStructuredLogger >> initializeOn: standardStream [

	self name: 'stderr-json'.
	super initializeOn: standardStream
]
