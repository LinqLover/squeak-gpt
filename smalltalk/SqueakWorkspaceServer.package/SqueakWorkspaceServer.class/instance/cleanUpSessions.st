clean-up
cleanUpSessions

	| now |
	now := DateAndTime now.
	(sessions select: [:session |
		(now - session lastAccessTime) > self sessionRetentionDuration])
			keysDo: [:sessionId | sessions removeKey: sessionId].