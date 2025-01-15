Class {
	#name : #GtHtmlExportPharoStyler,
	#superclass : #Object,
	#instVars : [
		'coder'
	],
	#classInstVars : [
		'StyleMethodAnnotations'
	],
	#category : #GtHtmlExportPharoStyling
}

{ #category : #styling }
GtHtmlExportPharoStyler class >> disableMethodAnnotationStyling [
	StyleMethodAnnotations := false
]

{ #category : #styling }
GtHtmlExportPharoStyler class >> enableMethodAnnotationStyling [
	StyleMethodAnnotations := true
]

{ #category : #initialization }
GtHtmlExportPharoStyler class >> forMethod: aMethod [
	^ self new
		coder: (GtPharoMethodCoder forMethod: aMethod);
		style
]

{ #category : #initialization }
GtHtmlExportPharoStyler class >> forSource: aString [
	^ self new
		coder: (GtPharoSnippetCoder forSource: aString);
		style
]

{ #category : #initialization }
GtHtmlExportPharoStyler class >> initialize [
	super initialize.
	self disableMethodAnnotationStyling
]

{ #category : #styling }
GtHtmlExportPharoStyler class >> shouldStyleMethodAnnotations [
	^ StyleMethodAnnotations
]

{ #category : #accessing }
GtHtmlExportPharoStyler >> coder [
	^ coder
]

{ #category : #accessing }
GtHtmlExportPharoStyler >> coder: anObject [
	coder := anObject
]

{ #category : #styling }
GtHtmlExportPharoStyler >> style [
	| aCollection anHtmlStream anAst aSourceText aStyler |
	aCollection := OrderedCollection new.
	anHtmlStream := ZnHtmlOutputStream on: (WriteStream on: String new).
	anAst := self coder astSync.
	aSourceText := self coder currentSourceText copy unstyled.
	aStyler := GtPharoStyler new
			coderViewModel: self coder asCoderViewModel;
			style: aSourceText ast: anAst.
	aSourceText readStream iterator
		in: [ :anIterator | 
			[ anIterator hasNext ]
				whileTrue: [ anIterator nextSpan
						in: [ :aSpan | aCollection add: aSpan text -> aSpan attributes ] ] ].
	anHtmlStream
		tag: #pre
		attributes: {#style.
				'white-space: pre-wrap; word-wrap: break-word'}
		do: [ aCollection
				do: [ :anAssociation | 
					| attributes |
					attributes := anAssociation value
							select: [ :each | 
								{BlTextForegroundAttribute.
									BlFontWeightAttribute} includes: each class ]
							thenCollect: [ :each | each asCssStyle ].
					attributes := attributes
							ifEmpty: [ #() ]
							ifNotEmpty: [ :notEmpty | 
								{#style.
									notEmpty joinUsing: ';'} ].
					anHtmlStream
						tag: #span
						attributes: attributes
						with: anAssociation key ] ].
	^ anHtmlStream rawStream contents
]
