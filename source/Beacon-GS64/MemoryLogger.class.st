"
This signal logger simply records the signals that it receives.

###Example1: Instance usage

```
	(MemoryLogger new 
		runDuring: [ 
			StringSignal emit: 'This is a message' ]	)
				inspect.
```

###Example 2: Global usage

```
	MemoryLogger reset.
	MemoryLogger start.
	StringSignal emit: 'This is a message' .
	MemoryLogger instance recordings inspect.
	MemoryLogger stop.
```
"
Class {
	#name : #MemoryLogger,
	#superclass : #SignalLogger,
	#instVars : [
		'recordings',
		'announcer',
		'mutex'
	],
	#category : #'Beacon-GS64'
}

{ #category : #'class initialization' }
MemoryLogger class >> reset [
	<script>

	self instance reset
]

{ #category : #accessing }
MemoryLogger >> announcer [
	"The announcer announces to potential watchers (typically viewers)
	that a new signal was recorded"
	^ announcer
]

{ #category : #initialization }
MemoryLogger >> initialize [
	super initialize.
	mutex := Mutex new.
	self reset.
	announcer := Announcer new
]

{ #category : #utilities }
MemoryLogger >> nextPut: aSignal [
	mutex critical: [
		recordings add: aSignal ].
	"the announcement is passed forward so that potential viewers
	can refresh when something changes. we do not create another announcement
	because it is not needed given that the only thing that can happen is
	for a new announcement to be recorded"
	self announcer announce: aSignal
]

{ #category : #accessing }
MemoryLogger >> recordings [
	"It answers a copy of the recorded collection to not grant
	access to the users to a shared resource that should only be
	modified via the mutex"
	^ recordings copy
]

{ #category : #initialize }
MemoryLogger >> reset [
	"it simply removes all recordings without
	affecting the running status of the logger"
	mutex critical: [
		recordings := OrderedCollection new ]
]
