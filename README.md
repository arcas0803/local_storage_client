# Local Storage Client

This is a client for the access to the local storage service.

It's base on Isar package.

## Getting Started

### Installation

Add the following to your `pubspec.yaml` file:

```yaml

dependencies:
  secure_storage_client: ^0.0.1
    git:
      url: https://github.com/arcas0803/local_storage_client.git
      ref: main

```

## Usage

### Import

```dart

import 'package:local_storage_client/local_storage_client.dart';

```

### Methods

#### read

```dart

final localStorage = LocalStorage<String, String>();

localStorage.read(id: 'your_id');


```

#### write

```dart

final localStorage = LocalStorage<String, String>();

localStorage.write(value: 'your_value');

```

#### delete

```dart

final localStorage = LocalStorage<String, String>();

localStorage.delete(id: 'your_id');


```

#### deleteAll


```dart

final localStorage = LocalStorage<String, String>();

secureStorage.deleteAll();

```

#### readAll

```dart

final localStorage = LocalStorage<String, String>();

localStorage.readAll();

```


### Configuration

#### Logger

It's possible to enable the logger to see the logs of the client.

Just pass the `logger` parameter to the constructor.

```dart

final logger = Logger();

final localStorage = LocalStorage(logger: logger);

```

#### Telemetry

It's possible to handle telemetry events passing to methods to the constructor.

```dart

final localStorage = LocalStorage(
  FutureOr<void> Function(Failure)? telemetryOnError,
  FutureOr<void> Function()? telemetryOnSuccess,
);

```

Telemetry on error is called when an error occurs.

Telemetry on success is called when the method is executed successfully.

#### Error handling

The exceptions available are:

- `LocalStorageReadFailure` when the read method fails.

- `LocalStorageWriteFailure` when the write method fails.

- `LocalStorageKeyNotFoundFailure` when the key is not found.

- `LocalStorageValueNotFoundFailure` when the value is not found.

- `LocalStorageIntializationFailure` when the initialization fails.

There is an class called `LocalStorageFailureUtil` with a method called `getFailureNameUI` to get a user friendly message from the exception.

```dart

final failureName = LocalStorageFailureUtil.getFailureNameUI(
    context: context, 
    failure:failure);

```

