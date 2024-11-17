request parsing
getBooleanParameterFrom: fields named: aString

	^ self
		getBooleanParameterFrom: fields
		named: aString
		ifAbsent: [false]