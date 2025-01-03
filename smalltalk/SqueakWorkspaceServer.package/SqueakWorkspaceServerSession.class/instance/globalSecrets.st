evaluating - private
globalSecrets
	"Don't obfuscate our own secrets here."

	^ SqueakWorkspaceServer globalSecrets copyWithoutAll: self secrets