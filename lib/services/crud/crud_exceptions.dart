class EntityNotFoundException {
  final _message;

  EntityNotFoundException(this._message);

  @override
  String toString() {
    // TODO: implement toString
    return "EntityNotFoundException: $_message";
  }
}

class DeleteException implements Exception {
  final _message;

  DeleteException(this._message);

  @override
  String toString() {
    // TODO: implement toString
    return "DeleteException: $_message";
  }
}

class UserAlreadyExistsException implements Exception {
  final _message;

  UserAlreadyExistsException(this._message);

  @override
  String toString() {
    // TODO: implement toString
    return "DeleteException: $_message";
  }
}

class DatabaseClosedException implements Exception {}

class DatabaseAlreadyOpenException implements Exception {}

class UnableToGetDocumentsDirectory implements Exception {}

