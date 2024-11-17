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
			newSession := SqueakWorkspaceServerSession new.
			sessions at: newSession id put: newSession].
	
	expression := self getParameterFrom: aWebRequest fields named: #expression.
	asMime := self getBooleanParameterFrom: aWebRequest fields named: #asMime.
	
	answer := JsonObject new.
	answer sessionId: session id.
	session lastAccessTime: DateAndTime now.
	
	[result := session evaluate: expression]
		on: Error do: [:ex | ^ errorBlock value: answer value: #error value: ex].
	
	[resultString := result printString]
		on: Error do: [:ex | ^ errorBlock value: answer value: #printError value: ex].
	
	asMime ifTrue:
		[| documentId |
		[(result respondsTo: #content) ifFalse: [self error: 'not a valid MIMEDocument'].
		result contentType]
			on: Error do: [:ex | ^ errorBlock value: answer value: #mimeError value: ex].
		documentId := session storeDocument: result.
		answer url: self publicServerUrl , ('/document?sessionId={1}&documentId={2}' format: {session id. documentId})].
	answer result: resultString.
	
	^ successBlock value: answer