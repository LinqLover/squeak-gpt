tests
testSession

	| response answer sessionId |
	response := self request: '/eval' do: [:fields |
		fields expression: 'x := 1 + 2'].
	answer := self parseResponse: response.
	self assert: response isSuccess.
	self assert: '3' equals: answer result.
	sessionId := answer sessionId.
	self deny: sessionId isEmptyOrNil.
	
	response := self request: '/eval' do: [:fields |
		fields expression: 'x'].
	answer := self parseResponse: response.
	self assert: response isSuccess.
	self assert: 'nil' equals: answer result.
	
	response := self request: '/eval' do: [:fields |
		fields expression: 'x + 1'; sessionId: sessionId].
	answer := self parseResponse: response.
	self assert: response isSuccess.
	self assert: '4' equals: answer result.
	self assert: sessionId equals: answer sessionId.