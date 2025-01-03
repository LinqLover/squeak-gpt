tests
testIsolation

	| response answer sessionId error |
	server shouldIsolate: true.
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
	self assert: '1' equals: answer result.
	
	response := self request: '/eval' do: [:fields |
		fields expression: 'SqueakWorkspaceServerTest someState'; sessionId: sessionId].
	answer := self parseResponse: response.
	self assert: response isSuccess.
	self assert: '2' equals: answer result.
	
	response := self request: '/eval' do: [:fields |
		fields expression: 'FileDirectory default exists'].
	answer := self parseResponse: response.
	self assert: 400 equals: response code.
	error := answer at: #error.
	self assert: (error description includesSubstring: 'forbidden' caseSensitive: false).