import '../model/order_data_model.dart';
import '../model/order_fee_model.dart';
import '../repository/order_repository.dart';

class OrderService {
  static final OrderRepository _orderRepository = OrderRepository();

  Future<OrderFeeModel> getFeeData() async {
    final Map<String, dynamic> data = await _orderRepository.getFeeData();

    return OrderFeeModel.fromMap(data);
  }

  Future<void> addOrder(OrderDataModel order) async {
    await _orderRepository.createOrder(order.toMapForInitOrder());
  }
}
