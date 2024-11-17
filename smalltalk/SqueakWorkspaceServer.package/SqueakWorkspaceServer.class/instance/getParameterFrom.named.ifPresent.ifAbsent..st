request parsing
getParameterFrom: fields named: aString ifPresent: presentBlock ifAbsent: defaultBlock

	| value |
	value := fields at: aString ifAbsent:
		[^ defaultBlock ifNotNil: [defaultBlock value] ifNil:
			[SqueakWorkspaceServerError signalBadRequest: ('{1} parameter not specified' format: {aString})]].
	^ presentBlock value: value