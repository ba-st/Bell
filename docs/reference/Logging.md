# Logging

Bell logging builds on top of [Beacon](https://github.com/pharo-project/pharo-beacon).
For a summary of Beacon take a look at [this blog post](http://www.humane-assessment.com/blog/beacon).

Bell provides logging information by signaling `LogRecord` instances,
including a log level that can be `TRACE`, `DEBUG`, `INFO`, `WARNING`, or `ERROR`.
To emit your logs, you can use `LogRecord` by sending one of the
`emit` messages:

- `emitTraceInfo:` will produce informational signals with trace information.
- `emitStructuredTraceInfo:with:` will produce informational signals with
  trace information and additional structured data provided by the user.
- `emitDebuggingInfo:` will produce informational signals with debugging information.
- `emitStructuredDebuggingInfo:with:` will produce informational signals with
  debugging information and additional structured data provided by the user.
- `emitInfo:` and `emitInfo:during:` will produce informational signals.
- `emitWarning:` will produce warning signals.
- `emitError:` will produce error signals.
