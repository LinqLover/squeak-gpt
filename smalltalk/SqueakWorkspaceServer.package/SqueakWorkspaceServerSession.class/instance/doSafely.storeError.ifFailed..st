evaluating
doSafely: aBlock storeError: storeErrorBlock ifFailed: failBlock
	"aBlock and storeErrorBlock are executed in isolation, failBlock is evaluated outside isolation!"

	| sandbox resultAndErrors error newSandboxMemory result |
	thisContext insertOn: self sandboxErrorClass , Warning do: failBlock.
	sandbox := (sandboxMemory ifNil: [self sandboxClass new] ifNotNil: [self sandboxClass fromMemory: sandboxMemory])
		stepLimit: self maximumStepCount;
		flag: #todo; "garbage-collect side effects that are not related to bindings"
		yourself.
	"mainly good style/optimization"
	{bindings. bindings array} , bindings array , bindings values do: [:ea |
		sandbox addObject: ea].
	self globalSecrets do: [:secret |
		sandbox patchObject: secret with:
			(self obfuscateSecret: secret)].
	
	resultAndErrors := [sandbox
		evaluate:
			[| errors |
			result := aBlock on: Error , Warning , Halt do:
				[:ex | errors := {storeErrorBlock value: ex}].
			{result. errors}]
		ifFailed: [:ex | error := ex]]
			valueWithin: self maximumEvalTime onTimeout:
				[^ failBlock value: TimedOut new].
	
	newSandboxMemory := sandbox exportMemory.
	self maximumMemorySize ifNotNil: [:maxSize |
		| memSize |
		memSize := newSandboxMemory memorySize.
		memSize > maxSize ifTrue:
			[newSandboxMemory := nil.
			memSize := 0.
			self notify: 'Memory limit was exceeded. Results of this operation will not be saved.'].
		memSize > (maxSize // 2) ifTrue:
			["self notify: 'You have reached {1}% of your memory limit now. Maybe think about an upgrade or back up your data?'."].
		self flag: #todo. "Add warning mechanism for appending to response. Server should abort operation when memory limit wauring asMime request!"].
	sandboxMemory := newSandboxMemory.
	
	error ifNotNil: [^ failBlock cull: error].
	resultAndErrors second ifNotNil: [:errors | ^ failBlock cull: errors first].
	result := resultAndErrors first.
	
	^ result