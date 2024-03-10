import 'package:flutter_test/flutter_test.dart';
import 'package:global_citizen_game/app/app.dart';
import 'package:global_citizen_game/counter/counter.dart';

import '../../helpers/hydrated_bloc.dart';

void main() {
  initHydratedStorage();

  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
