Extension { #name : #LeHtmlTextSnippetAnnotationVisitor }

{ #category : #'*GtHtmlExportPharoStyling' }
LeHtmlTextSnippetAnnotationVisitor >> visitMethodAnnotation: aMethodAnnotation [
	| methodNameArgument method methodExists |
	methodNameArgument := aMethodAnnotation nameNode.
	method := methodNameArgument imageObject.
	methodExists := method isNotNil.

	context html
		inlineTag: 'code'
		attributes: {'class'.
				'annotation annotation-label annotation-label-method annotation-label-code expandable-annotation-label {1}'
					format: {(aMethodAnnotation isExpanded and: [ methodExists ])
								ifTrue: [ 'annotation-sibling-is-expanded' ]
								ifFalse: [ 'annotation-sibling-is-collapsed' ]}.
				'style'.
				'word-break: break-all;'}
		with: (aMethodAnnotation hasLabel
				ifTrue: [ aMethodAnnotation label ]
				ifFalse: [ methodNameArgument fullName ]).

	methodExists ifFalse: [ ^ self ].

	context html
		tag: 'span'
		attributes: {'class'.
				'textual-snippet code-snippet pharo-method-snippet expandable-annotation-view {1}'
					format: {aMethodAnnotation isExpanded
								ifTrue: [ 'expanded-annotation-view' ]
								ifFalse: [ 'collapsed-annotation-view' ]}}
		do: [ self flag: #TODO.	"Not styling method annotations by default because some css is making *most method annotations appear expanded and outside the snippet visual container. Oddly enough the method LeHtmlGtBookPiece class>>#gtBook works in collapsed/expanded correctly but only *sometimes, depending on the additional text around it in the text snippet."
			GtHtmlExportPharoStyler shouldStyleMethodAnnotations
				ifTrue: [ context html wrappedStream
						nextPutAll: (GtHtmlExportPharoStyler forMethod: method) ]
				ifFalse: [ context html
						inlineTag: 'code'
						attributes: #('class' '')
						with: method sourceCode ] ]
]
