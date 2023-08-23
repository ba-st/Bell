Class {
	#name : #StandardErrorLogger,
	#superclass : #StandardStreamLogger,
	#category : #'Bell-Logging'
}

{ #category : #accessing }
StandardErrorLogger class >> instance [

	^ super instance
		  initializeOn: (LanguagePlatform current
				   globalNamed: #GsFile
				   ifAbsent: [ Error signal: 'GsFile class not found' ]) stderr;
		  yourself
]

{ #category : #initialization }
StandardErrorLogger >> initializeOn: standardStream [

	self name: 'stderr'.
	super initializeOn: standardStream
]
