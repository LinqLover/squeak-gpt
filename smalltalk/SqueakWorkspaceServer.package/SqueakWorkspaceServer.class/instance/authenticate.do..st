controlling
authenticate: aWebRequest do: handleBlock

	self hasBearerToken ifFalse: [^ handleBlock value].
	^ webServer
		authenticate: aWebRequest
		realm: self authenticationRealm
		methods: #(bearer)
		do: handleBlock