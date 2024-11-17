evaluating
evaluate: aString ifFail: failBlock

	history addLast: aString.
	^ Compiler new
		evaluate: aString
		in: self makeContextForThisSession
		to: self receiver
		environment: Smalltalk globals
		notifying: self
		ifFail: [failBlock value]
		logged: false