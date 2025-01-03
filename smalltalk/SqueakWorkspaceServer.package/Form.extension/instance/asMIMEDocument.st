*SqueakWorkspaceServer-converting-pseudo-override
asMIMEDocument

	^ MIMEDocument contentType: 'image/png' content:
		(ByteArray streamContents: [:stream |
			PNGReadWriter putForm: self onStream: stream])
				asString