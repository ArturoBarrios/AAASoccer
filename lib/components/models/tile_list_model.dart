import '../../components/models/button_model.dart';

class TileListModel {
  const TileListModel({
    this.buttonList,
    this.title,
  });

  final List<ButtonModel>? buttonList;
  final String? title;
}
