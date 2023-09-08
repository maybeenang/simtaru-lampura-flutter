import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateLogger extends ProviderObserver {
  const StateLogger();

  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    print('''
{
  provider: ${provider.name ?? provider.runtimeType},
  oldValue: $previousValue,
  newValue: $newValue
}
''');
  }
}
