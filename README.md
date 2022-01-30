# THL eKYC app

THL eKYC is a flutter mobile app built by Group 22 - Information System Integration Course, supervised by Assoc. Prof. Pham Van Hai ([HUST - SOICT](soict.hust.edu.vn)).

## Features

- Scan and extract information from Identity Card.
- People liveness detection.
- Verify user and Identity Card.

## Installation

eKYC app was developed as a micro-services app, which includes back-end and front-end (mobile app).

#### Back-end server

To install back-end server, you have to install [Docker](https://docs.docker.com/engine/install/) first.
After getting Docker installed, run the following command to pull back-end server:

```sh
docker pull thuanhppro12/tich-hop-httt
```

To start back-end server:

```sh
docker run -p 8000:8000 thuanhppro12/tich-hop-httt
```

To get the API, in the browser go to this link:
[localhost:8000/docs](localhost:8000/docs)

#### Front-end

The mobile app was developed with Flutter Framework.
For help getting started with Flutter, view
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Pull this git repo.
Then, get the dependencies:

```sh
flutter get pub
```

Run app in Android Virtual Device (install Android Studio first) or deploy on an Android phone (debugged mode)

```sh
flutter run
```

## License

MIT

**Free Software**
