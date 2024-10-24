import 'package:project/all_imports.dart';

class FutureData extends StatelessWidget {
  const FutureData({super.key, required this.data, required this.fn});
  final dynamic fn;
  final Widget Function(dynamic data) data;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fn,
      builder: (context, snapshot) {
        print("snap data ::: ::: ${snapshot.data}");
        if (snapshot.hasData) {
          return data(snapshot.data);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Center(
              child: CircularProgressIndicator(color: AppColorBody.blue));
        }
      },
    );
  }
}
