secrets
obfuscateSecret: secretString

	| hash random characters |
	hash := SecureHashAlgorithm new hashMessage: secretString.
	random := Random seed: hash.
	characters := ($a to: $z) , ($A to: $Z) , ($0 to: $9).
	^ (1 to: secretString size)
		collect: [:i | characters atRandom]
		as: String