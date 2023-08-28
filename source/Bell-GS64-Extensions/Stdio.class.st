"
I am a facade class to access standard output streams:

- standard input
- standard output
- standard error

I initialize standard streams in a lazy fashion, asking to the VM for the #stdioHandles. I cache those standard streams and release them on shutdown.

The possible scenarios, i.e. for each of stdin, stderr and stdout:

    the stream is attached to a terminal (default on posix platforms, PharoConsole.exe on Windows (see below for Pharo.exe))
    the stream is redirected to a normal file, e.g. pharo pharo.image > output.txt
    the stream is redirected to a pipe, e.g. pharo pharo.image | tee output.txt

To know exactly which kind of stream you are using, you can use File >> #fileDescriptorType: (args are 0 1 2 for the stdios).


Windows Subtleties
=====================

If launched as a desktop app (not from the console), Pharo.exe will not be linked to external streams because none is created. To overcome that, the default behavior of this class is to create a normal file for the three stdio. This can be modified to:
	not create a file (execute #useNullStreams)
	use a memory stream (execute #useMemoryStreams).
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
