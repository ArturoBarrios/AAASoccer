import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/components/loading_circular.dart';
import '../../components/headers.dart';
import '../../components/update_view_team_form.dart';
import '../../models/enums/view_status.dart';
import 'team_view_controller.dart';

class TeamView extends StatefulWidget {
  const TeamView({Key? key, required this.teamObject}) : super(key: key);
  final Map<String, dynamic> teamObject;

  @override
  State<TeamView> createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  ViewStatus _viewStatus = ViewStatus.loading;
  final TeamViewController _tVC = TeamViewController();

  @override
  void initState() {
    super.initState();
    print("initState()");
    print("loadIinitialData() in initState()");
    loadInitialData();
    print("initState finished!");
  }

  Future<void> loadInitialData() async {
    await _tVC.loadInitialData(widget.teamObject);
    changeViewStatus(ViewStatus.completed);
  }

  changeViewStatus(final ViewStatus status) {
    setState(() {
      _viewStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build() in TeamView");
    print("teamObject: ${widget.teamObject}");

    return Scaffold(
      appBar: const Headers().getBackHeader(context, widget.teamObject['name']),
      body: _viewStatus == ViewStatus.completed
          ? SingleChildScrollView(
              child: Center(
                child: Expanded(
                  child: Column(
                    children: [
                      // userTeamDetails['isMine']
                      //     ?
                      SizedBox(
                        height: 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: GestureDetector(
                              onTap: () async {
                                print("onTap: ");

                                List<int>? playerIndexes =
                                    await showAnimatedDialog<dynamic>(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return ClassicListDialogWidget<dynamic>(
                                        selectedIndexes:
                                            _tVC.selectedPlayerIndexes,
                                        titleText: 'Choose Players',
                                        listType: ListType.multiSelect,
                                        positiveText: "Next",
                                        activeColor: Colors.green,
                                        dataList: _tVC.playerList);
                                  },
                                  animationType: DialogTransitionType.size,
                                  curve: Curves.linear,
                                );
                                _tVC.selectedPlayerIndexes =
                                    playerIndexes ?? _tVC.selectedPlayerIndexes;
                                print(
                                    'selectedIndex:${_tVC.selectedPlayerIndexes?.toString()}');
                                _tVC.playersSelected(
                                    _tVC.selectedPlayerIndexes!);

                                if (_tVC.playersSelectedList.isNotEmpty &&
                                    context.mounted) {
                                  List<int>? requestIndexes =
                                      await showAnimatedDialog<dynamic>(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return ClassicListDialogWidget<dynamic>(
                                          selectedIndexes:
                                              _tVC.selectedRequestTypeIndexes,
                                          titleText: 'Choose User Type',
                                          positiveText: "Send Request",
                                          listType: ListType.multiSelect,
                                          activeColor: Colors.green,
                                          dataList: _tVC.requestUserTypes);
                                    },
                                    animationType: DialogTransitionType.size,
                                    curve: Curves.linear,
                                  );

                                  _tVC.selectedRequestTypeIndexes =
                                      requestIndexes ??
                                          _tVC.selectedRequestTypeIndexes;
                                  print(
                                      'selectedIndex:${_tVC.selectedRequestTypeIndexes?.toString()}');
                                  await _tVC.requestTypeSelected(
                                      _tVC.selectedRequestTypeIndexes);
                                  // await sendPlayersTeamRequest();
                                }
                              },
                              child: const Text("Invite Players")),
                        ),
                      ),
                      UpdateViewTeamForm(
                          userObjectDetails: _tVC.userTeamDetails),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _tVC.getPriceWidget(_tVC.userTeamDetails),
                          _tVC.userTeamDetails['isMine']
                              ? ElevatedButton(
                                  onPressed: () {
                                    // Add button onPressed logic here
                                  },
                                  child: const Text('Update Payment'),
                                )
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const LoadingCircular(height: double.infinity),
    );
  }
}
