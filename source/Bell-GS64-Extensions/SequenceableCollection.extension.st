Extension { #name : #SequenceableCollection }

{ #category : #'*Bell-GS64-Extensions' }
SequenceableCollection >> split: aSequenceableCollection indicesDo: aBlock [
	"Perform an action specified as aBlock (with a start and end argument) to each of the indices of aSequenceableCollection that have been identified by taking the receiver as a splitter."
	"('||' split: 'foo||bar||2')>>>#('foo' 'bar' '2') asOrderedCollection"
	"(String streamContents: [:s | '||' split: 'foo||bar||2' indicesDo: [ :start :end | s << 's:' << start asString << ' ' << 'e:' << end asString << ' ' ]]) >>> 's:1 e:3 s:6 e:8 s:11 e:11 '"

	| position oldPosition |
	position := 1.
	oldPosition := position.
	position := aSequenceableCollection indexOfSubCollection: self startingAt: position.

	[ position > 0 ] whileTrue: [
		aBlock value: oldPosition value: position - 1.
		position := position + self size.
		oldPosition := position.
		position := aSequenceableCollection indexOfSubCollection: self startingAt: position.
	].

	aBlock value: oldPosition value: aSequenceableCollection size
]
