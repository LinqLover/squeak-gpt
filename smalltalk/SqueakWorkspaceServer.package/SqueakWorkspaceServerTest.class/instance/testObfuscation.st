tests
testObfuscation

	| response answer firstSessionId ids |
	server shouldIsolate: true.
	
	response := self request: '/eval' do: [:fields |
		fields expression: '1 + 2'].
	answer := self parseResponse: response.
	self assert: response isSuccess.
	firstSessionId := answer sessionId.
	
	SqueakWorkspaceServerTest someState: server.
	
	response := self request: '/eval' do: [:fields |
		fields expression: 'SqueakWorkspaceServerTest someState sessions collect: #id as: Array'].
	answer := self parseResponse: response.
	self assert: response isSuccess.
	ids := Collection readCarefullyFrom: answer result.
	self assert: 2 equals: ids size.
	self assert: (ids includes: answer sessionId).
	self deny: (ids includes: firstSessionId).