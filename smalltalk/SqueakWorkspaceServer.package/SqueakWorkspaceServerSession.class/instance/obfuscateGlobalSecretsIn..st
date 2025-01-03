evaluating - private
obfuscateGlobalSecretsIn: aString

	self shouldIsolate ifFalse: [^ aString].
	^ SqueakWorkspaceServer obfuscateSecrets: self globalSecrets in: aString