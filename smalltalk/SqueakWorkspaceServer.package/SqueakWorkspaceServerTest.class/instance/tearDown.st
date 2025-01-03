running
tearDown

	| home |
	(home := thisContext) insertEnsure: [super tearDown].
	
	self class someState: nil.
	
	cleanUps ifNotNil:
		[cleanUps removeAllSuchThat: [:block |
			home insertEnsure: block.
			true]].