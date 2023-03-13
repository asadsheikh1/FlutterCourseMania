import 'package:http/http.dart' as http;

import 'package:course_mania/constants/api.dart';
import 'package:course_mania/models/subscription_model.dart';

class SubscriptionService {
  Future<List<SubscriptionModel>> getSubscription() async {
    try {
      final response =
          await http.get(Uri.parse(Api().baseApi + "subscription/getall"));
      if (response.statusCode == 200) {
        final payload = payloadModelFromJson(response.body);
        return payload.subscriptions;
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}
