request parsing
getBooleanParameterFrom: fields named: aString ifAbsent: absentBlock

	| value |
	value := self
		getParameterFrom: fields
		named: aString
		ifAbsent: (absentBlock ifNotNil: [[^ absentBlock value]]).
	(#('1' 'true' '') includes: value) ifTrue: [^ true].
	(#('0' 'false') includes: value) ifTrue: [^ false].
	^ SqueakWorkspaceServerError signalBadRequest: ('invalid value for parameter {1}' format: {aString})