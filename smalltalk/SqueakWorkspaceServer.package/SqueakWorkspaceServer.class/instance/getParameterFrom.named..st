request parsing
getParameterFrom: fields named: aString

	^ self
		getParameterFrom: fields
		named: aString
		ifAbsent: nil