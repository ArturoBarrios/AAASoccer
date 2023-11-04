import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';
import 'package:soccermadeeasy/components/loading_circular.dart';
import '../../commands/group_command.dart';
import '../../commands/user_command.dart';
import '../../components/chats_list_widget.dart';
import '../../components/events_list_widget.dart';
import '../../components/get_join_group_widget.dart';
import '../../components/headers.dart';
import '../../components/images_list_widget.dart';
import '../../components/join_condition.dart';
import '../../components/location_search_bar.dart';
import '../../components/my_map_page.dart';
import '../../components/payment_list_widget.dart';
import '../../components/players_list_widget.dart';
import '../../components/send_players_request_widget.dart';
import '../../constants.dart';
import '../../models/enums/payment_type.dart';
import '../../models/enums/view_status.dart';
import '../../models/pageModels/app_model.dart';
import '../../models/pageModels/group_page_model.dart';

class GroupView extends StatefulWidget {
  const GroupView({Key? key, required this.groupObject}) : super(key: key);
  final Map<String, dynamic> groupObject;

  @override
  State<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  

  @override
  void initState() {
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    print("build() in GroupView");
    
    
  

    return Scaffold(
      appBar: const Headers().getBackHeader(context, widget.groupObject['name']),
      body: Container()
    );
  }
}
