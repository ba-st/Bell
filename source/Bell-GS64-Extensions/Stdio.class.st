"
I am a facade class to access standard output streams, equivalent to the class of the same name that exists in Pharo, and created for compatibility reasons.
"
Class {
	#name : #Stdio,
	#superclass : #Object,
	#classVars : [
		'CreateWriteStreamBlock',
		'Stderr',
		'Stdin',
		'Stdout'
	],
	#category : #'Bell-GS64-Extensions'
}

{ #category : #accessing }
Stdio class >> stderr [
	"GsFile>>stderr returns nil when connected via GemBuilder on VAST64 for Windows.
	In that case we open the stream on the server."

	^ GsFile stderr ifNil: [ GsFile _getStdFile: 2 onClient: false ]
]

{ #category : #accessing }
Stdio class >> stdin [
	"GsFile>>stdin returns nil when connected via GemBuilder on VAST64 for Windows.
	In that case we open the stream on the server."

	^ GsFile stdin ifNil: [ GsFile _getStdFile: 0 onClient: false ]
]

{ #category : #accessing }
Stdio class >> stdout [
	"GsFile>>stdout returns nil when connected via GemBuilder on VAST64 for Windows.
	In that case we open the stream on the server."

	^ GsFile stdout ifNil: [ GsFile _getStdFile: 1 onClient: false ]
]
