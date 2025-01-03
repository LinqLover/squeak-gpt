services
handleEvalRequest: aWebRequest

	| answer code session |
	self cleanUpSessionsIfNeeded.
	
	answer := [self
		evalRequest: aWebRequest
		ifSuccess: [:resultAnswer :theSession |
			code := 200.
			session := theSession.
			resultAnswer]
		ifError: [:resultAnswer :theSession :errorType :exception |
			code := 400.
			session := theSession.
			resultAnswer copy
				at: errorType put: (self serializeError: exception);
				yourself]]
		on: SqueakWorkspaceServerError do: [:ex |
			code := ex statusCode.
			ex asJsonObject].
	^ aWebRequest
		sendResponseCode: code
		content:
			(session
				ifNotNil: [session obfuscateGlobalSecretsIn: answer asJsonString]
				ifNil: [self obfuscateSecretsIn: answer asJsonString]) squeakToUtf8
		type: 'application/json; charset=utf-8'
		close: false