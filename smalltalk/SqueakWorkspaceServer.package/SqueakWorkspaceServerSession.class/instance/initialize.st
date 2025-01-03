initialize-release
initialize

	super initialize.
	
	id := UUID new asString beSecret.
	shouldIsolate := self defaultShouldIsolate.
	
	self resetBindings.
	self resetDocuments.
	self resetHistory.