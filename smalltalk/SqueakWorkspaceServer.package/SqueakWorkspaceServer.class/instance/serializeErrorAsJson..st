private
serializeErrorAsJson: anException
	"Needed for exporting errors outside of sandbox."

	^ #serializedErrorJson -> (self serializeError: anException) asJsonString