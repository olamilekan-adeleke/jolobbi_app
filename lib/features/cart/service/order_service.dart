import '../model/order_fee_model.dart';
import '../repository/order_reopsitory.dart';

class OrderService {
  static final OrderRepository _orderRepository = OrderRepository();

  Future<OrderFeeModel> getFeeData() async {
    final Map<String, dynamic> data = await _orderRepository.getFeeData();

    return OrderFeeModel.fromMap(data);
  }
}
