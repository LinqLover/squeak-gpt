signaling
signalCode: statusCode message: messageText

	^ (self code: statusCode message: messageText)
		signal