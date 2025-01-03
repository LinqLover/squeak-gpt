*SqueakWorkspaceServer-secrets
beSecret

	(self environment at: #GlobalSecrets ifAbsentPut: [WeakSet new])
		add: self.