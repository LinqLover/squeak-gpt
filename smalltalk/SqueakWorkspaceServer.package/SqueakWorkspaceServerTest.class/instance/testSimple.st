tests
testSimple

	| response answer |
	response := self request: '/eval' do: [:fields |
		fields expression: '2 + 4 * 7'].
	answer := self parseResponse: response.
	
	self assert: response isSuccess.
	self assert: '42' equals: answer result.