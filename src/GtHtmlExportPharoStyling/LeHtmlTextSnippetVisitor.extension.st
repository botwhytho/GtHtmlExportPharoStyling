Extension { #name : #LeHtmlTextSnippetVisitor }

{ #category : #'*GtHtmlExportPharoStyling' }
LeHtmlTextSnippetVisitor >> visitCodeBlock: aCodeBlock [
	context html
		tag: #div
		attributes: #('class' 'code_block')
		do: [ context html
				tag: 'pre'
				do: [ (aCodeBlock language value
						in: [ :aValue | aValue isNil or: [ aValue asLowercase = 'smalltalk' ] ])
						ifTrue: [ context html wrappedStream
								nextPutAll: (GtHtmlExportPharoStyler forSource: aCodeBlock code value asString trimBoth) ]
						ifFalse: [ context html
								tag: 'code'
								attributes: {'class'.
										aCodeBlock language value}
								with: aCodeBlock code value asString trimBoth ] ] ]
]
