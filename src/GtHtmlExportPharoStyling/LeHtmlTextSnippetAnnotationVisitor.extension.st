Extension { #name : #LeHtmlTextSnippetAnnotationVisitor }

{ #category : #'*GtHtmlExportPharoStyling' }
LeHtmlTextSnippetAnnotationVisitor >> visitMethodAnnotation: aMethodAnnotation [
	| methodNameArgument method methodExists |
	methodNameArgument := aMethodAnnotation nameNode.
	method := methodNameArgument imageObject.
	methodExists := method isNotNil.

	context html
		inlineTag: 'code'
		attributes: {'class'. 'annotation annotation-label annotation-label-method annotation-label-code expandable-annotation-label {1}'
				format: {(aMethodAnnotation isExpanded and: [ methodExists ])
							ifTrue: [ 'annotation-sibling-is-expanded' ]
							ifFalse: [ 'annotation-sibling-is-collapsed' ]}}
		with: (aMethodAnnotation hasLabel
				ifTrue: [ aMethodAnnotation label ]
				ifFalse: [ methodNameArgument fullName ]).
				
	methodExists ifFalse: [ ^ self ].
				
	self flag: #TODO. "Formatting here breaks EXCEPT on LeHtmlGtBookPiece class>>#gtBook somehow. I've tried testing with methods that have even less width in their source code but those break too, not sure what the issue is"
	context html 
		tag: 'span'
		attributes: {'class'. 'textual-snippet code-snippet pharo-method-snippet expandable-annotation-view {1}'
				format: {(aMethodAnnotation isExpanded)
							ifTrue: [ 'expanded-annotation-view' ]
							ifFalse: [ 'collapsed-annotation-view' ]}}
		do: [ 
			context html 
				wrappedStream nextPutAll: (GtHtmlExportPharoStyler forMethod: method) ]
]
