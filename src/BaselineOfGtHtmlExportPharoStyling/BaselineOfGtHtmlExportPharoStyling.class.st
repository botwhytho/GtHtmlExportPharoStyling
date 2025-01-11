Class {
	#name : #BaselineOfGtHtmlExportPharoStyling,
	#superclass : #BaselineOf,
	#category : #BaselineOfGtHtmlExportPharoStyling
}

{ #category : #baseline }
BaselineOfGtHtmlExportPharoStyling >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'GtHtmlExportPharoStyling'
		]
]
