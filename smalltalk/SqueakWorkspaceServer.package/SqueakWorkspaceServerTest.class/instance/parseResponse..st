private
parseResponse: aWebResponse

	^ aWebResponse content utf8ToSqueak parseAsJson