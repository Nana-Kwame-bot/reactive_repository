import 'package:rxdart/rxdart.dart';

/// A repository class for [{{bloc_state_name}}].
///
/// This class provides a way to manage and update the state of [{{bloc_state_name}}].
class {{bloc_state_name.pascalCase()}}Repository {
  /// A [BehaviorSubject] to hold and stream the [{{bloc_state_name}}].
  ///
  /// It's seeded with an initial state if seedBehaviorSubject is true.
  final BehaviorSubject<{{bloc_state_name}}> _{{bloc_state_name.camelCase()}}Subject =
    {{#seedBehaviorSubject}}
    BehaviorSubject<{{bloc_state_name}}>.seeded(const {{bloc_state_name}}());
    {{/seedBehaviorSubject}}
    {{^seedBehaviorSubject}}BehaviorSubject<{{bloc_state_name}}>();
    {{/seedBehaviorSubject}}

  /// A stream of [{{bloc_state_name}}] updates for subscription.
  Stream<{{bloc_state_name}}> get {{bloc_state_name.camelCase()}}Stream =>
    _{{bloc_state_name.camelCase()}}Subject.stream;

  /// Provides synchronous access to the current state.
  {{bloc_state_name}} get current{{bloc_state_name}} => _{{bloc_state_name.camelCase()}}Subject.value;

  /// Allows for the [{{bloc_state_name}}] to be updated, notifying all 
  /// stream subscribers.
  ///
  /// The [state] is the new state to be added to the stream.
  void update{{bloc_state_name}}({{bloc_state_name}} state) =>
    _{{bloc_state_name.camelCase()}}Subject.add(state);

  {{#includeDispose}}
  /// Closes the [BehaviorSubject] stream to prevent memory leaks upon disposal.
  void dispose() => _{{bloc_state_name.camelCase()}}Subject.close();
  {{/includeDispose}}
}