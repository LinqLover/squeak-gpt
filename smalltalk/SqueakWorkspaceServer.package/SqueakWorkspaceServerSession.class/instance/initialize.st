initialize-release
initialize

	super initialize.
	
	id := UUID new asString.
	
	self resetBindings.
	self resetDocuments.
	self resetHistory.