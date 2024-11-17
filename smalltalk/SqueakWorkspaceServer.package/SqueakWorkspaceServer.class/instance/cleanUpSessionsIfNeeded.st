clean-up
cleanUpSessionsIfNeeded

	| now |
	now := DateAndTime now.
	(lastCleanupDate notNil and: [now - lastCleanupDate < 1 hour]) ifTrue: [^ self].
	
	self cleanUpSessions.
	lastCleanupDate := now.