Class {
	#name : #StandardOutputLogger,
	#superclass : #StandardStreamLogger,
	#category : #'Bell-Logging'
}

{ #category : #accessing }
StandardOutputLogger class >> instance [
	"Avoid using GsFile>>stdout for debugging purposes
	 (returns nil when connected via GemBuilder on VAST64 for Windows)"

	^ super instance
		  initializeOn: ((LanguagePlatform current
				    globalNamed: #GsFile
				    ifAbsent: [ Error signal: 'GsFile class not found' ])
				   _getStdFile: 1
				   onClient: false);
		  yourself
]

{ #category : #initialization }
StandardOutputLogger >> initializeOn: standardStream [

	self name: 'stdout'.
	super initializeOn: standardStream
]
