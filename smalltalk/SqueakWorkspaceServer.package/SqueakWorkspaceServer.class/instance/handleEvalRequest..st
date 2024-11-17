services
handleEvalRequest: aWebRequest

	| answer code |
	self cleanUpSessionsIfNeeded.
	
	answer := [self
		evalRequest: aWebRequest
		ifSuccess: [:resultAnswer |
			code := 200.
			resultAnswer]
		ifError: [:resultAnswer :type :exception |
			code := 400.
			resultAnswer copy
				at: type put: (self serializeError: exception);
				yourself]]
		on: SqueakWorkspaceServerError do: [:ex |
			code := ex statusCode.
			ex asJsonObject].
	^ aWebRequest
		sendResponseCode: code
		content: answer asJsonString squeakToUtf8
		type: 'application/json; charset=utf-8'
		close: false