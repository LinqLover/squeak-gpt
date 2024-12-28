controlling
startOn: port

	webServer := WebServer new.
	webServer
		addService: '/eval'
			action: [:request |
				self authenticate: request do: [self handleEvalRequest: request]]
			methods: #('GET');
		addService: '/document'
			action: [:request |
				"not authenticated because read-only (and embedded resources should not require authentication in web browsers)"
				self handleDocumentRequest: request]
			methods: #('GET').
	webServer listenOn: port.