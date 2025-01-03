tests
testDocument

	| response answer document |
	response := self request: '/eval' do: [:fields |
		fields expression: 'RectangleMorph new imageForm asMIMEDocument'; asMime: true].
	answer := self parseResponse: response.
	
	self assert: response isSuccess.
	self assert: ('MIMEDocument (image/png, * bytes)' match: answer result).
	
	response := WebClient httpGet: answer url.
	self assert: response isSuccess.
	document := MIMEDocument contentType: response contentType content: response content.
	document setField: 'content-disposition' to:
		(MIMEHeaderValue fromMIMEHeader: (response headerAt: 'content-disposition')).
	self assert: 'image/png' equals: document contentType.
	self assert: RectangleMorph new imageForm bits equals: document image bits.
	self assert: ('#*.png' match: document attachmentFileName).