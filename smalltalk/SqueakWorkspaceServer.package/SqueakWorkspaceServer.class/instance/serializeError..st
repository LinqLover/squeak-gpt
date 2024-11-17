private
serializeError: anException

	^ [OrderedJsonObject new
		description: anException description;
		stack:
			((anException signalerContext stack copyUpTo: anException privHandlerContext) allButLast
				collect: #asString);
		yourself]
			on: Error do: [:ex | '<error printing error: {1} gave: {2}>' format: {anException class. ex class}]