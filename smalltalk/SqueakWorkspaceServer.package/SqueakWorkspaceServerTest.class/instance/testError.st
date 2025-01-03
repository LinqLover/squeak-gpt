tests
testError

	| response answer error |
	response := self request: '/eval' do: [:fields |
		fields expression: '12 / 0'].
	answer := self parseResponse: response.
	
	self assert: 400 equals: response code.
	error := answer at: #error.
	self assert: 'ZeroDivide: ' equals: error description.
	self assert: ('dividend\:\s+12' asRegex search: error asString).
	self assert: '*SmallInteger>>/' equals: error stack second.