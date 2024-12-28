private
sourceWithErrorFor: anException
	"ChatGPT created this by itself to improve its debugging capabilities"

	| messageText location |
	messageText := anException messageText.
	location := anException location.
	^ String streamContents: [:stream |
		stream
			nextPutAll: (messageText copyFrom: 1 to: location - 1);
			nextPutAll: anException errorMessage;
			nextPutAll: (messageText copyFrom: location to: messageText size)]