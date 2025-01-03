tests
testNoIsolation

	| response answer sessionId |
	server shouldIsolate: false.
	SqueakWorkspaceServerTest someState: 1.
	
	response := self request: '/eval' do: [:fields |
		fields expression: 'SqueakWorkspaceServerTest someState: 2'].
	answer := self parseResponse: response.
	self assert: response isSuccess.
	sessionId := answer sessionId.
	
	response := self request: '/eval' do: [:fields |
		fields expression: 'SqueakWorkspaceServerTest someState'].
	answer := self parseResponse: response.
	self assert: response isSuccess.
	self assert: '2' equals: answer result.