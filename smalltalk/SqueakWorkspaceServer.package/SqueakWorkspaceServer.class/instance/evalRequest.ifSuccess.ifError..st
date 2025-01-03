services
evalRequest: aWebRequest ifSuccess: successBlock ifError: errorBlock

	| session expression asMime result resultString answer |
	session := self
		getParameterFrom: aWebRequest fields
		named: #sessionId
		ifPresent: [:sessionId |
			sessions at: sessionId ifAbsent:
				[^ SqueakWorkspaceServerError signalNotFound: 'This session does not exist. Maybe it was already pruned by the server. In that case, its variables must be manually recreated in a new session.']]
		ifAbsent:
			[| newSession |
			newSession := SqueakWorkspaceServerSession new
				shouldIsolate: self shouldIsolate;
				yourself.
			sessions at: newSession id put: newSession].
	
	expression := self getParameterFrom: aWebRequest fields named: #expression.
	asMime := self getBooleanParameterFrom: aWebRequest fields named: #asMime.
	
	answer := JsonObject new.
	answer sessionId: session id.
	session lastAccessTime: DateAndTime now.
	
	result := session
		evaluate: expression
		storeError: [:ex | self serializeErrorAsJson: ex]
		ifFailed: [:error | ^ errorBlock value: answer value: session value: #error value: error].
	
	resultString := session
		do: [result printString copy]
		storeError: [:ex | self serializeErrorAsJson: ex]
		ifFailed: [:error | ^ errorBlock value: answer value: session value: #printError value: error].
	
	asMime ifTrue:
		[| documentId |
		session
			do:
				[(result respondsTo: #content) ifFalse: [self error: 'not a valid MIMEDocument'].
				result contentType]
			storeError: [:ex | self serializeErrorAsJson: ex]
			ifFailed: [:error | ^ errorBlock value: answer value: session value: #mimeError value: error].
		documentId := session storeDocument: result.
		answer url: self publicServerUrl , ('/document?sessionId={1}&documentId={2}' format: {session id. documentId})].
	answer result: resultString.
	
	^ successBlock value: answer value: session