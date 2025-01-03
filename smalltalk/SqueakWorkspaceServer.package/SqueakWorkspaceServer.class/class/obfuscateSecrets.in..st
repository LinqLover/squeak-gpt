secrets
obfuscateSecrets: secrets in: aString

	^ secrets
		inject: aString
		into: [:string :secret |
			string copyReplaceAll: secret with:
				(self obfuscateSecret: secret)]