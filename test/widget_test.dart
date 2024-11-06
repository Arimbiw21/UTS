import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listkuliner/main.dart'; // Sesuaikan dengan path aplikasi Anda

void main() {
  testWidgets('App runs successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(KulinerApp());

    // Verifikasi bahwa halaman utama muncul
    expect(find.text("List Kuliner"), findsOneWidget); // Ubah sesuai dengan judul yang ada di appBar Anda
  });
}
