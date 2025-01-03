private
request: endpoint do: fieldBlock

	^ WebClient httpGet:
		('http://localhost:{1}/eval?{2}' format:
			{port.
			WebUtils encodeUrlEncodedForm: (JsonObject new in: fieldBlock)})