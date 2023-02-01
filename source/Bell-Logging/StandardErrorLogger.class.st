Class {
	#name : #StandardErrorLogger,
	#superclass : #StandardStreamLogger,
	#category : #'Bell-Logging-Bell-Logging'
}

{ #category : #accessing }
StandardErrorLogger class >> instance [

	^ super instance
		  initializeOn: Stdio stderr;
		  yourself
]

{ #category : #initialization }
StandardErrorLogger >> initializeOn: standardStream [

	self name: 'stderr'.
	super initializeOn: standardStream
]
