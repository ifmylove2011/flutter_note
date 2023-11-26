import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sub test', () {
    var title = new RegExp(r'\d+-\d+');
    String url = 'https://tk0.es/wp-content/uploads/2023/11/0053-46-scaled.jpg';
    print(title.stringMatch(url));
    String ti = url.split("/")[7];
    print(ti);
    expect(ti, isNotNull);
  });
}
