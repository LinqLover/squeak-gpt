accessing
storeDocument: aMIMEDocument

	| id |
	[id := UUID new asString] doWhileTrue: [documents includesKey: id].
	documents at: id put: aMIMEDocument.
	^ id