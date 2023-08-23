Class {
	#name : #StandardOutputLogger,
	#superclass : #StandardStreamLogger,
	#category : #'Bell-Logging'
}

{ #category : #accessing }
StandardOutputLogger class >> instance [

	^ super instance
		  initializeOn: (LanguagePlatform current
				   globalNamed: #GsFile
				   ifAbsent: [ Error signal: 'GsFile class not found' ]) stdout;
		  yourself
]

{ #category : #initialization }
StandardOutputLogger >> initializeOn: standardStream [

	self name: 'stdout'.
	super initializeOn: standardStream
]
