services
handleDocumentRequest: aWebRequest

	| sessionId documentId shouldDownload session document contentAndType content contentType |
	self cleanUpSessionsIfNeeded.
	
	[sessionId := self getParameterFrom: aWebRequest fields named: #sessionId.
	documentId := self getParameterFrom: aWebRequest fields named: #documentId.
	shouldDownload := self getBooleanParameterFrom: aWebRequest fields named: #download ifAbsent: [false].
	
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
	
	contentAndType := session
		do: [{document content. document contentType} copyTwoLevel]
		storeError: [:ex | self serializeErrorAsJson: ex]
		ifFailed: [:error |
			^ aWebRequest
				sendResponseCode: 422
				content: (JsonObject new mimeError: error; yourself)
				type: 'application/json; charset=utf-8'
				close: false].
	
	content := contentAndType first.
	contentType := contentAndType second.
	^ aWebRequest
		send200Response: (session obfuscateGlobalSecretsIn: content) , String lf
		contentType: (session obfuscateGlobalSecretsIn: contentType)
		do: [:response |
			| name |
			name := documentId asString.
			MIMEType defaultSuffixes at: contentType ifPresent: [:suffix |
				name := '{1}.{2}' format: {name. suffix}].
			response headerAt: 'Content-Disposition' put:
				('{1}; filename="{2}"' format:
					{shouldDownload ifFalse: ['inline'] ifTrue: ['attachment'].
					name})]