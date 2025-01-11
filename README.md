
## Installation

```st
[ EpMonitor current
	disableDuring: [ Metacello new
			repository: 'github://';
			baseline: 'github://botwhytho/GtHtmlExportPharoStyling:main/src';
			load ] ] asAsyncFuture
	await: AsyncFutureExecutionConfiguration default lowPriority
```
