Extension { #name : #LeHtmlVisitor }

{ #category : #'*GtHtmlExportPharoStyling' }
LeHtmlVisitor >> visitPharoSnippet: aLePharoSnippet [
	context html
		tag: #div
		attributes: (self
				classesFor: aLePharoSnippet
				withClasses: 'snippet textual-snippet code-snippet pharo-snippet')
		do: [ context html
				wrappedStream nextPutAll: (GtHtmlExportPharoStyler forSource: aLePharoSnippet code) ].
	^ self visitContent: aLePharoSnippet
]
