import 'package:flutter_test/flutter_test.dart';
import 'package:preguntados_trivia/main.dart';

void main() {
  testWidgets('La app carga correctamente', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verifica que cargue el login o pantalla inicial
    expect(find.byType(MyApp), findsOneWidget);
  });
}

