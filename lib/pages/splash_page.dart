import 'package:clothes_store/models/auth.dart';
import 'package:clothes_store/pages/auth_page.dart';
import 'package:clothes_store/pages/products_overview_page.dart';
import 'package:clothes_store/utils/app_routes.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return auth.isAuth
        ? const ProductOverviewPage()
        : const AuthenticationPage();
  }
}
