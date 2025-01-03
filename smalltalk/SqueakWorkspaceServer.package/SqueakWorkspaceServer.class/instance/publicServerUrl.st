accessing
publicServerUrl

	"Could also use WebServer>>siteUrl but this registry mechanism does not precisely match our composition approach"
	self tunnelServerUrl ifNotNil: [:url | ^ url].
	^ 'http://localhost:{1}' format: {webServer listenerPort}