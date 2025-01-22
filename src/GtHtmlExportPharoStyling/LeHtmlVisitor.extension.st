Extension { #name : #LeHtmlVisitor }

{ #category : #'*GtHtmlExportPharoStyling' }
LeHtmlVisitor >> visitPharoRewriteSnippet: aLePharoRewriteSnippet [
	context html
		tag: #div
		attributes: (self
				classesFor: aLePharoRewriteSnippet
				withClasses: 'snippet textual-snippet code-snippet pharorewrite-snippet')
		do: [ context html wrappedStream
				nextPutAll: (GtHtmlExportPharoStyler
						in: [ :aStyler | 
							aLePharoRewriteSnippet isMethodPattern
								ifTrue: [ aStyler forPattern: aLePharoRewriteSnippet search ]
								ifFalse: [ aStyler forMethodPattern: aLePharoRewriteSnippet search ] ]) ].

	aLePharoRewriteSnippet replace trimBoth
		ifNotEmpty: [ context html
				tag: #div
				attributes: #('class' 'snippet textual-snippet code-snippet pharoreplace-snippet')
				do: [ context html wrappedStream
						nextPutAll: (GtHtmlExportPharoStyler
								in: [ :aStyler | 
									aLePharoRewriteSnippet isMethodPattern
										ifTrue: [ aStyler forPattern: aLePharoRewriteSnippet replace ]
										ifFalse: [ aStyler forMethodPattern: aLePharoRewriteSnippet replace ] ]) ] ].

	^ self visitContent: aLePharoRewriteSnippet
]

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
