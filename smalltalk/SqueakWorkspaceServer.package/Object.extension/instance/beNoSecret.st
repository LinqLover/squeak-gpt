*SqueakWorkspaceServer-secrets
beNoSecret

	(self environment at: #GlobalSecrets ifAbsent: [^ self])
		remove: self ifAbsent: nil.