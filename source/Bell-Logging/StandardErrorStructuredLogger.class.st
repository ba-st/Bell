Class {
	#name : #StandardErrorStructuredLogger,
	#superclass : #StandardStreamStructuredLogger,
	#category : #'Bell-Logging'
}

{ #category : #accessing }
StandardErrorStructuredLogger class >> instance [
	"Avoid using GsFile>>stderr for debugging purposes
	 (returns nil when connected via GemBuilder on VAST64 for Windows)"

	^ super instance
		  initializeOn: ((LanguagePlatform current
				    globalNamed: #GsFile
				    ifAbsent: [ Error signal: 'GsFile class not found' ])
				   _getStdFile: 2
				   onClient: false);
		  yourself
]

{ #category : #initialization }
StandardErrorStructuredLogger >> initializeOn: standardStream [

	self name: 'stderr-json'.
	super initializeOn: standardStream
]
