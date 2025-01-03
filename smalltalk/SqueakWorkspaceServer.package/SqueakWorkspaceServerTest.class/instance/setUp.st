running
setUp

	super setUp.
	
	server := self serverClass new.
	port := 8110.
	server startOn: port.
	self addCleanUp:
		[server stop].