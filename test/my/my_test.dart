import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPerson extends Mock implements Person {}

void main() {
  late Person person;

  setUp(
    () {
      person = MockPerson();
    },
  );
  group(
    '',
    () {
      test(
        '',
        () {
          when(() => person.add(any(), any())).thenReturn(130);
          final result = person.add(1, 2);
          expect(result, 130);
        },
      );
    },
  );
}

class Person {
  const Person(this.name);
  final String name;

  int add(int a, int b) {
    final s = a + b + 10;
    debugPrint(s.toString());
    return s;
  }

  @override
  String toString() {
    return 'Person{name: $name}';
  }
}
