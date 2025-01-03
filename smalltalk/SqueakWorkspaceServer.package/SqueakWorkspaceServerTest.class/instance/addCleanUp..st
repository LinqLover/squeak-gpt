running
addCleanUp: aBlock

	(cleanUps ifNil: [cleanUps := OrderedCollection new])
		addLast: aBlock.