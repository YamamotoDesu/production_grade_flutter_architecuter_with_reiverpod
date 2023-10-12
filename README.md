# [Production grade Flutter Architecture with Riverpod](https://youtu.be/uX2I19r_6NY?si=MFMU5Lhsig3notyo)

```
.
├── main.dart
└── src
    ├── app.dart
    ├── commons
    │   ├── controller
    │   ├── providers
    │   │   └── common_providers.dart
    │   ├── repository
    │   └── views
    │       └── splash.dart
    ├── core
    │   ├── api.dart
    │   ├── core.dart
    │   ├── failure.dart
    │   └── type_def.dart
    ├── feature
    │   ├── home
    │   │   ├── controller
    │   │   ├── repository
    │   │   └── view
    │   │       └── home.dart
    │   └── product
    │       ├── controller
    │       │   └── product.dart
    │       ├── repository
    │       │   └── product.dart
    │       └── view
    │           ├── products.dart
    │           └── widgets
    │               └── product_list_item.dart
    ├── models
    │   └── product.dart
    ├── res
    │   ├── assets.dart
    │   ├── base.dart
    │   ├── endpoints.dart
    │   └── strings.dart
    └── utils
        ├── alert.dart
        ├── config.dart
        ├── router.dart
        └── snackbar_service.dart
```

<img width="300" alt="image" src="https://github.com/YamamotoDesu/production_grade_flutter_architecuter_with_reiverpod/assets/47273077/3e06e226-781c-4720-92e2-4029f57b7a25">


lib/src/core/api.dart
```dart
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';
import 'package:production_grade_flutter_architecuter_with_reiverpod/src/providers/common_providers.dart';
import 'package:production_grade_flutter_architecuter_with_reiverpod/src/res/string.dart';
import 'package:production_grade_flutter_architecuter_with_reiverpod/src/utills/config.dart';

import 'core.dart';

/// Watch apiProvider to make sure to have the latest authToken passed.

final apiProvider = StateProvider((ref) {
  final authToken = ref.watch(authTokenProvider);
  return API(authToken: authToken);
});

/// Contains common methods required for client side APIs [GET, POST, PUT, DELETE].
/// Pass the [url] from endpoints using [Endpoints] class.
/// Every method has an optional parameter [requireAuth] default [true].
/// Set [requireAuth] to [false] if [authToken] is Empty.
class API {
  final String? _authToken;

  API({required String? authToken}) : _authToken = authToken;

  FutureEither<Response> getRequest(
      {required String url, bool requireAuth = true}) async {
    final Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Authorization": "token=$_authToken"
    };
    if (requireAuth) {
      if ((_authToken ?? '').isEmpty) {
        return Left(Failure(message: FailureMessage.authTokenEmpty));
      }
    }
    if (AppConfig.logHttp) {
      log('REQUEST TO : $url', name: LogLabel.httpGet);
      log('requireAuth : $requireAuth', name: LogLabel.httpGet);
    }
    try {
      final response = await get(Uri.parse(url), headers: requestHeaders);
      log('RESPONSE : ${response.body}', name: LogLabel.httpGet);
      return Right(response);
    } catch (e, stktrc) {
      return Left(Failure(
          message: FailureMessage.getRequestMessage, stackTrace: stktrc));
    }
  }

  FutureEither<Response> postRequest(
      {required String url, dynamic body, bool requireAuth = true}) async {
    final Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Authorization": "token=$_authToken"
    };
    if (requireAuth) {
      if ((_authToken ?? '').isEmpty) {
        return Left(Failure(message: FailureMessage.authTokenEmpty));
      }
    }
    if (AppConfig.logHttp) {
      log('REQUEST TO : $url', name: LogLabel.httpPost);
      log('requireAuth : $requireAuth', name: LogLabel.httpPost);
      log('BODY : $body', name: LogLabel.httpPost);
    }
    try {
      final response = await post(Uri.parse(url),
          body: jsonEncode(body), headers: requestHeaders);
      log('RESPONSE : ${response.body}', name: LogLabel.httpPost);
      return Right(response);
    } catch (e, stktrc) {
      return Left(Failure(
          message: FailureMessage.postRequestMessage, stackTrace: stktrc));
    }
  }

  FutureEither<Response> putRequest(
      {required String url, dynamic body, bool requireAuth = true}) async {
    final Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Authorization": "token=$_authToken"
    };
    if (requireAuth) {
      if ((_authToken ?? '').isEmpty) {
        return Left(Failure(message: FailureMessage.authTokenEmpty));
      }
    }
    if (AppConfig.logHttp) {
      log('REQUEST TO : $url', name: LogLabel.httpPut);
      log(
        'requireAuth : $requireAuth',
        name: LogLabel.httpPut,
      );
      log('BODY : $body', name: LogLabel.httpPut);
    }
    try {
      final response = await put(Uri.parse(url),
          body: jsonEncode(body), headers: requestHeaders);
      log('RESPONSE : ${response.body}', name: LogLabel.httpPut);
      return Right(response);
    } catch (e, stktrc) {
      return Left(Failure(
          message: FailureMessage.putRequestMessage, stackTrace: stktrc));
    }
  }

  FutureEither<Response> deleteRequest(
      {required String url, dynamic body, bool requireAuth = true}) async {
    final Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Authorization": "token=$_authToken"
    };
    if (requireAuth) {
      if ((_authToken ?? '').isEmpty) {
        return Left(Failure(message: FailureMessage.authTokenEmpty));
      }
    }
    if (AppConfig.logHttp) {
      log('REQUEST TO : $url', name: LogLabel.httpDelete);
      log('requireAuth : $requireAuth', name: LogLabel.httpDelete);
      log('BODY : $body', name: LogLabel.httpDelete);
    }
    try {
      final response = await put(Uri.parse(url),
          body: jsonEncode(body), headers: requestHeaders);
      log('RESPONSE : ${response.body}', name: LogLabel.httpDelete);
      return Right(response);
    } catch (e, stktrc) {
      return Left(Failure(
          message: FailureMessage.deleteRequestMessage, stackTrace: stktrc));
    }
  }
}
```

lib/src/feature/home/view/product/view/wigets/products.dart
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:production_grade_flutter_architecuter_with_reiverpod/src/feature/home/view/product/controller/product.dart';
import 'package:production_grade_flutter_architecuter_with_reiverpod/src/feature/home/view/product/view/wigets/product_list_item.dart';

class ProductsList extends ConsumerWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productController = ref.watch(productControllerProvider);
    return FutureBuilder(
      future: productController.getProducts(context: context),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error Loading Data"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (data != null) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ProductListItem(product: data[index]);
              },
            );
          } else {
            return const Center(
              child: Text("Error Loading Data"),
            );
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
```
