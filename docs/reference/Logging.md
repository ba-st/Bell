# Logging

Bell logging builds on top of [Beacon](https://github.com/pharo-project/pharo-beacon).
For a summary of Beacon take a look at [this blog post](http://www.humane-assessment.com/blog/beacon).

## Emitting Log Records

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

## Loggers

Log records are finally output in some format by setting a logger to handle
them. Bell provides the following loggers:

- `StandardErrorLogger` will output the log records to `stdout`
- `StandardOutputLogger` will output the log records to `stderr`
- `StandardErrorStructuredLogger` will output the log records to `stdout` in
  `json` format
- `StandardOutputStructuredLogger` will output the log records to `stderr` in
  `json` format

For example, the following log records:

```smalltalk
  LogRecord emitInfo: 'Receiving commands over TCP/22222'.
  LogRecord emitInfo: 'Obtaining configuration' during: [
    LogRecord emitWarning: 'Port not found, defaulting to 5322'.
    LogRecord emitInfo: 'Hostname: localhost' ].
  LogRecord emitError: 'Missing required parameter'.
  LogRecord emitDebuggingInfo: 'PORT: 5322'.
  LogRecord emitStructuredDebuggingInfo: 'Configuration'
            with: [ :data |
              data
                at: #port put: 5322;
                at: #hostname put: 'localhost' ].
  LogRecord emitTraceInfo: 'PORT: 5322'.
  LogRecord emitStructuredTraceInfo: 'Configuration'
            with: [ :data |
              data
                at: #port put: 5322;
                at: #hostname put: 'localhost' ].
```

will produce the following output when using the non-structured loggers:

```bash
2023-02-17T09:33:27.206319-03:00 [INFO] Receiving commands over TCP/22222
2023-02-17T09:33:27.206593-03:00 [INFO] Obtaining configuration...
2023-02-17T09:33:27.207128-03:00 [WARNING] Port not found, defaulting to 5322
2023-02-17T09:33:27.207191-03:00 [INFO] Hostname: localhost
2023-02-17T09:33:27.207235-03:00 [INFO] Obtaining configuration... [DONE]
2023-02-17T09:33:27.207265-03:00 [ERROR] Missing required parameter
2023-02-17T09:33:27.207297-03:00 [DEBUG] PORT: 5322
2023-02-17T09:33:27.207335-03:00 [DEBUG] Configuration {"port":5322,"hostname":"localhost"}
2023-02-17T09:33:27.207383-03:00 [TRACE] PORT: 5322
2023-02-17T09:33:27.207419-03:00 [TRACE] Configuration {"port":5322,"hostname":"localhost"}
```

and the following output when using the structured loggers:

<!-- markdownlint-disable line_length -->
```json
{"time":"2023-02-17T09:34:48.291938-03:00","level":"INFO","message":"Receiving commands over TCP/22222","process":"Launchpad CLI"}
{"time":"2023-02-17T09:34:48.292173-03:00","level":"INFO","message":"Obtaining configuration...","process":"Launchpad CLI"}
{"time":"2023-02-17T09:34:48.292461-03:00","level":"WARNING","message":"Port not found, defaulting to 5322","process":"Launchpad CLI"}
{"time":"2023-02-17T09:34:48.292534-03:00","level":"INFO","message":"Hostname: localhost","process":"Launchpad CLI"}
{"time":"2023-02-17T09:34:48.292565-03:00","level":"INFO","message":"Obtaining configuration... [DONE]","process":"Launchpad CLI"}
{"time":"2023-02-17T09:34:48.292594-03:00","level":"ERROR","message":"Missing required parameter","process":"Launchpad CLI"}
{"time":"2023-02-17T09:34:48.292619-03:00","level":"DEBUG","message":"PORT: 5322","process":"Launchpad CLI"}
{"time":"2023-02-17T09:34:48.292649-03:00","level":"DEBUG","message":"Configuration","process":"Launchpad CLI","port":5322,"hostname":"localhost"}
{"time":"2023-02-17T09:34:48.292685-03:00","level":"TRACE","message":"PORT: 5322","process":"Launchpad CLI"}
{"time":"2023-02-17T09:34:48.292713-03:00","level":"TRACE","message":"Configuration","process":"Launchpad CLI","port":5322,"hostname":"localhost"}
```
