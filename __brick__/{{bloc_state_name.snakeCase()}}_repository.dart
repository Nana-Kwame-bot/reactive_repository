import 'package:rxdart/rxdart.dart';

class {{bloc_state_name.pascalCase()}}Repository {

  final BehaviorSubject<{{bloc_state_name}}> _{{bloc_state_name.camelCase()}}Subject =
    {{#seedBehaviorSubject}}
    BehaviorSubject<{{bloc_state_name}}>.seeded(const {{bloc_state_name}}());
    {{/seedBehaviorSubject}}
    {{^seedBehaviorSubject}}BehaviorSubject<{{bloc_state_name}}>();
    {{/seedBehaviorSubject}}

  Stream<{{bloc_state_name}}> get {{bloc_state_name.camelCase()}}Stream =>
    _{{bloc_state_name.camelCase()}}Subject.stream;

  {{bloc_state_name}} get current{{bloc_state_name}} => _{{bloc_state_name.camelCase()}}Subject.value;

  void update{{bloc_state_name}}({{bloc_state_name}} state) =>
    _{{bloc_state_name.camelCase()}}Subject.add(state);

  {{#includeDispose}}
  void dispose() => _{{bloc_state_name.camelCase()}}Subject.close();
  {{/includeDispose}}
}