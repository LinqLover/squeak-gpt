evaluating
do: aBlock storeError: storeErrorBlock ifFailed: failBlock

	| errors result |
	self shouldIsolate ifTrue: [^ self doSafely: aBlock storeError: storeErrorBlock ifFailed: failBlock].
	
	result := aBlock
		on: Error , Warning , Halt do:
			[:ex | errors := {storeErrorBlock value: ex}].
	errors ifNotNil:
		[^ failBlock cull: errors first].
	^ result