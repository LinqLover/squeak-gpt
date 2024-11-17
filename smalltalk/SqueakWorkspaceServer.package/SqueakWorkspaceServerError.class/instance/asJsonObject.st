converting
asJsonObject

	^ JsonObject new
		requestError: self messageText asString;
		yourself