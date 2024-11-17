services
handleDocumentRequest: aWebRequest

	| sessionId documentId session document content contentType |
	self cleanUpSessionsIfNeeded.
	
	[sessionId := self getParameterFrom: aWebRequest fields named: #sessionId.
	documentId := self getParameterFrom: aWebRequest fields named: #documentId.
	
	session := sessions at: sessionId ifAbsent:
		[^ SqueakWorkspaceServerError signalNotFound: 'This session does not exist. Maybe it was already pruned by the server. In that case, its variables must be manually recreated in a new session.'].
	document := session documentAt: documentId ifAbsent:
		[^ SqueakWorkspaceServerError signalNotFound: 'Document not found']]
			on: SqueakWorkspaceServerError do: [:ex |
				^ aWebRequest
					sendResponseCode: ex statusCode
					content: ex asJsonObject asJsonString squeakToUtf8
					type: 'application/json; charset=utf-8'
					close: false].
	
	[content := document content.
	contentType := document contentType]
		on: Error do: [:ex |
			^ aWebRequest
				sendResponseCode: 500
				content: (JsonObject new mimeError: (self serializeError: ex); yourself)
				type: 'application/json; charset=utf-8'
				close: false].
	
	^ aWebRequest
		send200Response: content  , String lf
		contentType: contentType