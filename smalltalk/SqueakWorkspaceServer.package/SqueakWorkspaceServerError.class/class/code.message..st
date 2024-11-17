instance creation
code: statusCode message: messageText

	^ self new
		statusCode: statusCode;
		messageText: messageText;
		yourself