clean-up
cleanUpSessions

	| now |
	now := DateAndTime now.
	(sessions select: [:session |
		session lastAccessTime
			ifNil: [true]
			ifNotNil: [:lastAccessTime | (now - lastAccessTime) > self sessionRetentionDuration]])
				keysDo: [:sessionId | sessions removeKey: sessionId].