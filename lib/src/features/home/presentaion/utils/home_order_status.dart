/// Sales order statuses returned by the API (`orders_statuses`).
enum HomeOrderStatus {
  submitted('Submitted'),
  loaded('Loaded'),
  onTheWay('On the way'),
  delivered('Delivered');

  const HomeOrderStatus(this.apiValue);

  final String apiValue;

  static HomeOrderStatus? fromApiValue(String value) =>
      values.where((status) => status.apiValue == value).firstOrNull;
}
