accessing
storeDocument: aMIMEDocument

	| id |
	[id := UUID new asString] doWhileTrue: [documents includesKey: id].
	id beSecret.
	documents at: id put: aMIMEDocument.
	^ id