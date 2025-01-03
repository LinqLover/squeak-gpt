private
obfuscateSecretsIn: aString

	self shouldIsolate ifFalse: [^ aString].
	^ self class obfuscateSecretsIn: aString