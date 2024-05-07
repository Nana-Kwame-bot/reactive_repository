# Reactive Repository

This brick is designed to help you to connect your blocs through the domain layer, using the [rxdart](https://pub.dev/packages/rxdart) package in Dart. It provides a reactive repository to keep your blocs' state synchronized. More information about this pattern can be found [Connecting Blocs through Domain](https://bloclibrary.dev/architecture/#connecting-blocs-through-domain) and [Effective Bloc-to-Bloc Communication Strategies in the Domain Layer](https://henryadu.hashnode.dev/effective-bloc-to-bloc-communication-strategies-in-the-domain-layer).

## Features 🌟

- **Reactive Stream Management:** Utilizes [BehaviorSubject](https://pub.dev/documentation/rxdart/latest/rx/BehaviorSubject-class.html) from rxdart to manage a stream of bloc states.

- **Current State Access:** Easily access the current state of your bloc at any point in time.
- **Update Functionality:** Update the state of your bloc with a new one as needed, ideally within the `onChange` callback.


## Getting Started 🚀

To use the Reactive Repository brick, you need to have the rxdart package in your environment. If you haven't already, add rxdart to your project's pubspec.yaml:

With Dart:
```bash
dart pub add rxdart
```

With Flutter:
```bash
flutter pub add rxdart
```

## Setup 🧑‍💻

Ensure you have the [mason_cli](https://github.com/felangel/mason/tree/master/packages/mason_cli) installed.

 🎯 Activate from https://pub.dev

```bash
dart pub global activate mason_cli
```

🍺 Or install from https://brew.sh

```bash
brew tap felangel/mason && brew install mason
```

### Installation ☁️

Install globally

```bash
mason add -g reactive_repository
```

### Usage 🎨

Run the following command in the directory you would like to make the reactive repository.

```bash
mason make reactive_repository
```


## Variables ✨

| Variable              | Description                 | Default        | Type     |
| -----------------     | --------------------------- | -------------- | -------- |
| `bloc_state_name`     | The name of the bloc state  | `CounterState` | `string` |
| `includeDispose`      | Include a dispose method    | `true`         | `boolean`|
| `seedBehaviorSubject` | Seed the BehaviorSubject    | `true`         | `boolean`|



## Example Output 📦

`counter_state_repository.dart`

```dart
import 'package:rxdart/rxdart.dart';

/// A repository class for [CounterState].
///
/// This class provides a way to manage and update the state of [CounterState].
class CounterStateRepository {
  /// A [BehaviorSubject] to hold and stream the [CounterState].
  ///
  /// It's seeded with an initial state if seedBehaviorSubject is true.
  final BehaviorSubject<CounterState> _counterStateSubject =
      BehaviorSubject<CounterState>.seeded(const CounterState());

  /// A stream of [CounterState] updates for subscription.
  Stream<CounterState> get counterStateStream => _counterStateSubject.stream;

  /// Provides synchronous access to the current state.
  CounterState get currentCounterState => _counterStateSubject.value;

  /// Allows for the [CounterState] to be updated, notifying all
  /// stream subscribers.
  ///
  /// The [state] is the new state to be added to the stream.
  void updateCounterState(CounterState state) =>
      _counterStateSubject.add(state);

  /// Closes the [BehaviorSubject] stream to prevent memory leaks upon disposal.
  void dispose() => _counterStateSubject.close();
}
```

### Update State 🔄 

`counter_bloc.dart`

```dart
  /// Called when the state of the counter changes.
  /// 
  /// This method is called whenever there is a change in the [CounterState].
  /// It updates the counter state in the _counterStateRepository with the
  /// [change.nextState].
  @override
  void onChange(Change<CounterState> change) {
    super.onChange(change);
    _counterStateRepository.updateCounterState(change.nextState);
  }
```

### Read State 📖

`timer_bloc.dart`

```dart
    /// Handles the stream request event and updates the timer state.
    ///
    /// This method listens to the counter state stream and updates the timer state
    /// based on the received data. It emits a new [TimerState] with the updated count.
    ///
    FutureOr<void> _onStreamRequested(
      _StreamRequested event,
      Emitter<TimerState> emit,
    ) async {
      await emit.forEach<CounterState>(
        _counterStateRepository.counterStateStream,
        onData: (counterState) {
          return state.copyWith(count: counterState.value);
        },
      );
    }
```

