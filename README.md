# Reactive Repository

This brick is designed to help you to connect your blocs through the domain layer, using the [rxdart](https://pub.dev/packages/rxdart) package in Dart. It provides a reactive repository to keep your blocs' state synchronized. More information about this pattern can be found [Connecting Blocs through Domain](https://bloclibrary.dev/architecture/#connecting-blocs-through-domain) and [Effective Bloc-to-Bloc Communication Strategies in the Domain Layer](https://henryadu.hashnode.dev/effective-bloc-to-bloc-communication-strategies-in-the-domain-layer).

## Features 🌟

- **Reactive Stream Management:** Utilizes [BehaviorSubject](https://pub.dev/documentation/rxdart/latest/rx/BehaviorSubject-class.html) from rxdart to manage a stream of bloc states.

- **Current State Access:** Easily access the current state of your bloc at any point in time.
- **Update Functionality:** Update the state of your bloc with a new one as needed, ideally within the `onChange` callback.


## Getting Started 🚀

To use the Reactive Repository brick, you need to have Dart and rxdart package in your environment. If you haven't already, add rxdart to your project's pubspec.yaml under dependencies:

```yaml
dependencies:
  rxdart: ^0.27.0
```

## Usage 🎨

```bash
mason make reactive_repository
```

## Variables ✨

| Variable          | Description                 | Default        | Type     |
| ----------------- | --------------------------- | -------------- | -------- |
| `bloc_state_name` | The name of the bloc state  | `CounterState` | `string` |


## Example Output

File `counter_state_repository.dart`

```dart
import 'package:rxdart/rxdart.dart';

class CounterStateRepository {
  final BehaviorSubject<CounterState> _counterStateSubject =
      BehaviorSubject<CounterState>.seeded(const CounterState());

  Stream<CounterState> get counterStateStream => _counterStateSubject.stream;

  CounterState get currentCounterState => _counterStateSubject.value;

  void updateCounterState(CounterState state) =>
      _counterStateSubject.add(state);
}
```


