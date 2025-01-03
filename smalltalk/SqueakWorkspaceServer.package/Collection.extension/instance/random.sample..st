*SqueakWorkspaceServer-accessing
random: aRandom sample: sampleSize
	"Copied from SemanticText"

	^ sampleSize timesCollect:
		[self atRandom]