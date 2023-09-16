import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';
import 'package:soccermadeeasy/components/loading_circular.dart';
import '../../components/SendMyEventsTeamRequestWidget.dart';
import '../../components/chats_list_widget.dart';
import '../../components/events_list_widget.dart';
import '../../components/get_join_team_widget.dart';
import '../../components/headers.dart';
import '../../components/images_list_widget.dart';
import '../../components/location_search_bar.dart';
import '../../components/my_map_page.dart';
import '../../components/payment_list_widget.dart';
import '../../components/players_list_widget.dart';
import '../../components/send_players_request_widget.dart';
import '../../constants.dart';
import '../../models/enums/payment_type.dart';
import '../../models/enums/view_status.dart';
import '../../models/pageModels/app_model.dart';
import 'team_view_controller.dart';
import '../../models/pageModels/team_page_model.dart';

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

  void addEventCallback(dynamic event) {
    setState(() {
      // widget.userObjectDetails['team']['events']['data'].add(event);
    });
  }

  List<dynamic> modifiedParticipantList(
      List userParticipants, List payments, String? price) {
    final amount = double.tryParse(price ?? '0') ?? 0;

    for (var participant in userParticipants) {
      var userId = participant['user']['_id'];

      var payment = payments.firstWhere(
        (p) => p['user']['_id'] == userId,
        orElse: () => null,
      );

      if (payment != null) {
        double paymentAmount = double.tryParse(payment['amount'] ?? '') ?? 0;

        if (paymentAmount == 0) {
          participant['paymentStatus'] = 'Free';
        } else if (paymentAmount < amount) {
          participant['paymentStatus'] = 'Partially';
        } else if (paymentAmount == amount) {
          participant['paymentStatus'] = 'Paid';
        }
      } else {
        participant['paymentStatus'] = 'Free';
      }
      participant['paymentType'] = (payment != null &&
              payment['isPlayerPayment'] != null &&
              payment['isPlayerPayment'] == true)
          ? 'Player Payment'
          : (payment != null &&
                  payment['isTeamPayment'] != null &&
                  payment['isTeamPayment'] == true)
              ? 'Team Payment'
              : 'freePayment';
    }

    return userParticipants;
  }

  Map<String, List<dynamic>> getPaidUsers(
    List userParticipants,
    List payments,
  ) {
    Set<String> paymentIds =
        payments.map((payment) => payment['user']['_id'].toString()).toSet();

    final paidUsers = userParticipants.where((participant) {
      return paymentIds.contains(participant['user']?['_id'].toString());
    }).toList();

    Map<String, List<dynamic>> categorizedPayments = {};

    for (var user in paidUsers) {
      if (user['paymentType'] != null) {
        String key = user['paymentType'];
        if (categorizedPayments.containsKey(key)) {
          categorizedPayments[key]?.add(user);
        } else {
          categorizedPayments[key] = [user];
        }
      }
    }

    return categorizedPayments;
  }

  @override
  Widget build(BuildContext context) {
    print("build() in TeamView");
    print("teamObject: ${widget.teamObject}");
    LocationSearchBar locationSearchBar = new LocationSearchBar();

    dynamic currentUser =
        context.select<AppModel, dynamic>((value) => value.currentUser);
    dynamic team =
        context.select<TeamPageModel, dynamic>((value) => value.team);
    bool isMine = context.select<TeamPageModel, bool>((value) => value.isMine);
    List players =
        context.select<TeamPageModel, List>((value) => value.players);
    List roles = context.select<TeamPageModel, List>((value) => value.roles);
    List userParticipants =
        context.select<TeamPageModel, List>((value) => value.userParticipants);
    dynamic price =
        context.select<TeamPageModel, dynamic>((value) => value.price);
    String amountRemaining =
        context.select<TeamPageModel, String>((value) => value.amountRemaining);
    List payments = context.watch<TeamPageModel>().payments;

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
                      // UpdateViewTeamForm(
                      //     userObjectDetails: _tVC.userTeamDetails),
                      //MyMapPage
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        color: Colors.amber[600],
                        width: MediaQuery.of(context).size.width -
                            (MediaQuery.of(context).size.width *
                                .1), //10% padding
                        height: 200.0,
                        child: MyMapPage(
                            latitude: team['location']['data'][0]['latitude'],
                            longitude: team['location']['data'][0]
                                ['longitude']),
                      ),
                      //search bar
                      locationSearchBar = LocationSearchBar(
                          initialValue: team['location']['data'][0]['name']),
                      //SendMyEventsTeamRequestWidget
                      SendMyEventsTeamRequestWidget(
                        team: team,
                        isMine: isMine,
                      ),
                      //SendPlayersRequestWidget
                      SendPlayersRequestWidget(
                        mainEvent: null,
                        team: team,
                        players: players,
                        isMine: isMine,
                      ),
                      EventsListWidget(
                        team: team,
                        user: null,
                        events: team['events']['data'],
                        eventUserParticipants: [],
                      ),
                      ImagesListWidget(
                          mainEvent: null,
                          team: team,
                          imageFor: Constants.TEAM),
                      GetJoinTeamWidget(
                        user: currentUser,
                        team: team,
                        roles: roles,
                        isMine: isMine,
                        price: price,
                        amountRemaining: amountRemaining,
                      ),
                      PlayerList(
                        event: null,
                        team: team,
                        userParticipants: modifiedParticipantList(
                            userParticipants, payments, price['amount']),
                      ),
                      ChatsListWidget(chats: team['chats']['data']),
                      // createTeamRequestWidget,
                      // createTeamPaymentWidget,
                      const SizedBox(height: 20),
                      PaymentListWidget(
                        categorizedPaidUsers:
                            getPaidUsers(userParticipants, payments),
                        paymentType: PaymentType.team,
                      ),
                      const SizedBox(height: 60),
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
