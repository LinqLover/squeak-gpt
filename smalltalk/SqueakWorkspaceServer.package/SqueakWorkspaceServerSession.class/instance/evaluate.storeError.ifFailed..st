evaluating
evaluate: aString storeError: storeErrorBlock ifFailed: failBlock

	history addLast: aString.
	^ self
		do:
			[Compiler new
				evaluate: aString
				in: self makeContextForThisSession
				to: self receiver
				environment: Smalltalk globals
				notifying: self
				ifFail: nil
				logged: false]
		storeError: storeErrorBlock
		ifFailed: failBlock