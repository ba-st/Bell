"
This is a simple signal that holds a message.

###Usage:
```
	(StringSignal emit: 'This is a message') message
```	

	

"
Class {
	#name : #StringSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'message'
	],
	#category : #'Bell-GS64-Extras'
}

{ #category : #'instance creation' }
StringSignal class >> emit: aString [
	^ self new
		message: aString;
		emit
]

{ #category : #accessing }
StringSignal >> message [

	^ message
]

{ #category : #accessing }
StringSignal >> message: anObject [

	message := anObject
]

{ #category : #printing }
StringSignal >> printOneLineContentsOn: stream [

	stream nextPutAll: self message
]