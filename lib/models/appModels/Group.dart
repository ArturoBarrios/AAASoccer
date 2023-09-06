import 'GroupStage.dart';
import 'TeamOrder.dart';

class Group {
  int? groupNumber;
  GroupStage? groupStage;
  List<TeamOrder>? teamOrders;

  Group({
    this.groupNumber,
    this.groupStage,
    this.teamOrders,
  });
}
