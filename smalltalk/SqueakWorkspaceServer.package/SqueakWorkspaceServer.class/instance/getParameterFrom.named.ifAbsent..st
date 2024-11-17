request parsing
getParameterFrom: fields named: aString ifAbsent: defaultBlock

	^ self
		getParameterFrom: fields
		named: aString
		ifPresent: [:value | value]
		ifAbsent: defaultBlock