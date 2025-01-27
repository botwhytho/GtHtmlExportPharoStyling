
## Installation

```st
[ EpMonitor current
	disableDuring: [ Metacello new
			repository: 'github://botwhytho/GtHtmlExportPharoStyling:main/src';
			baseline: 'GtHtmlExportPharoStyling';
			load ] ] asAsyncFuture
	await: AsyncFutureExecutionConfiguration default lowPriority
```
