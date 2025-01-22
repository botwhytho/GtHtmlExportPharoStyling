Class {
	#name : #GtHtmlExportPharoStyler,
	#superclass : #Object,
	#instVars : [
		'coder'
	],
	#classInstVars : [
		'styleMethodAnnotations'
	],
	#category : #GtHtmlExportPharoStyling
}

{ #category : #styling }
GtHtmlExportPharoStyler class >> disableMethodAnnotationStyling [
	styleMethodAnnotations := false
]

{ #category : #styling }
GtHtmlExportPharoStyler class >> enableMethodAnnotationStyling [
	styleMethodAnnotations := true
]

{ #category : #initialization }
GtHtmlExportPharoStyler class >> forMethod: aMethod [
	^ self new
		coder: (GtPharoMethodCoder forMethod: aMethod);
		style
]

{ #category : #initialization }
GtHtmlExportPharoStyler class >> forMethodPattern: aString [
	^ self new
		coder: (GtPharoSnippetCoder forSource: aString);
		stylePharoMethodPattern
]

{ #category : #initialization }
GtHtmlExportPharoStyler class >> forPattern: aString [
	^ self new
		coder: (GtPharoSnippetCoder forSource: aString);
		stylePharoPattern
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
	^ styleMethodAnnotations
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

{ #category : #styling }
GtHtmlExportPharoStyler >> stylePharoMethodPattern [
	| aCollection anHtmlStream anAst aSourceText aStyler |
	aCollection := OrderedCollection new.
	anHtmlStream := ZnHtmlOutputStream on: (WriteStream on: String new).
	anAst := GtPharoPatternParser
			parse: self coder sourceCode source
			startingAt: GtPharoParser startingStateForMethodSequence.
	aSourceText := self coder currentSourceText copy unstyled.
	aStyler := GtCompositeSmaCCASTStyler forParser: GtPharoPatternParser.
	aStyler stylers: {GtPharoPatternStyler new}.
	aStyler startingState: GtPharoParser startingStateForMethodSequence.
	aStyler style: aSourceText ast: anAst.
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

{ #category : #styling }
GtHtmlExportPharoStyler >> stylePharoPattern [
	| aCollection anHtmlStream anAst aSourceText aStyler |
	aCollection := OrderedCollection new.
	anHtmlStream := ZnHtmlOutputStream on: (WriteStream on: String new).
	anAst := GtPharoPatternParser parse: self coder sourceCode source.
	aSourceText := self coder currentSourceText copy unstyled.
	aStyler := GtCompositeSmaCCASTStyler forParser: GtPharoPatternParser.
	aStyler stylers: {GtPharoPatternStyler new}.
	aStyler style: aSourceText ast: anAst.
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
