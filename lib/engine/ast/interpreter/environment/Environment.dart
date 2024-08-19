class Environment {
  Environment({this.parent}) {
    // vars = parent != null ? Map.from(parent!.vars) : {};
  }

  Environment? parent;
  Map<String, dynamic> vars = {};

  Environment extend() {
    return Environment(parent: this);
  }

  Environment? lookup(String key) {
    Environment? env = this;
    while (env != null) {
      if (env.vars.containsKey(key)) {
        return env;
      }
      env = env.parent;
    }
    return null;
  }

  dynamic get(String key) {
    final scope = lookup(key) ?? this;
    if (scope.vars.containsKey(key)) return scope.vars[key];
    throw Exception('Undefined variable $key');
  }

  dynamic set(String key, dynamic value) {
    final scope = lookup(key);
    (scope ?? this).vars[key] = value;
    return value;
  }

  dynamic def(String key, dynamic value) {
    vars[key] = value;
    return value;
  }
}
