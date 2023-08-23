Class {
	#name : #StandardOutputStructuredLogger,
	#superclass : #StandardStreamStructuredLogger,
	#category : #'Bell-Logging'
}

{ #category : #accessing }
StandardOutputStructuredLogger class >> instance [

	^ super instance
		  initializeOn: (LanguagePlatform current
				   globalNamed: #GsFile
				   ifAbsent: [ Error signal: 'GsFile class not found' ]) stdout;
		  yourself
]

{ #category : #initialization }
StandardOutputStructuredLogger >> initializeOn: standardStream [

	self name: 'stdout-json'.
	super initializeOn: standardStream
]
