Class {
	#name : #StandardErrorStructuredLogger,
	#superclass : #StandardStreamStructuredLogger,
	#category : #'Bell-Logging'
}

{ #category : #accessing }
StandardErrorStructuredLogger class >> instance [

	^ super instance
		  initializeOn: (LanguagePlatform current
				   globalNamed: #GsFile
				   ifAbsent: [ Error signal: 'GsFile class not found' ]) stderr;
		  yourself
]

{ #category : #initialization }
StandardErrorStructuredLogger >> initializeOn: standardStream [

	self name: 'stderr-json'.
	super initializeOn: standardStream
]
