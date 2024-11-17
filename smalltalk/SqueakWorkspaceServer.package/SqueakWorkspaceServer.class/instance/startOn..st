controlling
startOn: port

	webServer := WebServer new.
	webServer
		addService: '/eval'
			action: [:request | self handleEvalRequest: request]
			methods: #('GET');
		addService: '/document'
			action: [:request | self handleDocumentRequest: request]
			methods: #('GET').
	webServer listenOn: port.