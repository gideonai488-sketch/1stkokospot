# 1stkokospot

Flutter workspace for building a food-ordering app.

## Quick Start

1. Run Flutter commands from the repo root with:

```bash
./flutterw <command>
```

2. Install app dependencies:

```bash
cd food_ordering_app
../flutterw pub get
```

3. Run the app:

```bash
../flutterw run
```

## What Was Set Up

- Local Flutter SDK at `.flutter-sdk/`
- App scaffold at `food_ordering_app/`
- Wrapper command `./flutterw`

## Android Build Note

Flutter detected a Java/Gradle compatibility warning for Android builds.

- Recommended Java range for the generated Android project: Java 17 to Java 24
- To pin Java for Flutter:

```bash
./flutterw config --jdk-dir=<JDK_DIRECTORY>
```