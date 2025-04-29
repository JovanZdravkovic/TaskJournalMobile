import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/models/task_history.dart';
import 'package:task_journal_mobile/services/tasks_history_service.dart';
import 'package:task_journal_mobile/widgets/drawer.dart';
import 'package:task_journal_mobile/widgets/label_divider.dart';
import 'package:task_journal_mobile/widgets/rating_input.dart';
import 'package:task_journal_mobile/widgets/reset_filters_button.dart';
import 'package:task_journal_mobile/widgets/search_bar.dart';
import 'package:task_journal_mobile/widgets/task_history_row.dart';
import 'package:task_journal_mobile/widgets/task_icon_select.dart';

class TasksHistoryPage extends StatefulWidget {
  const TasksHistoryPage({ super.key });

  @override
  State<TasksHistoryPage> createState() => _TasksHistoryPageState();
}

class _TasksHistoryPageState extends State<TasksHistoryPage> {

  int? searchRating;
  List<TaskHistory> tasksHistory = [];
  final searchNameController = TextEditingController();
  MultiSelectController<String> iconSelectController = MultiSelectController<String>();

  Map<String, dynamic> createPayload() {
    var icons = iconSelectController.selectedItems.map((valueItemIcon) => valueItemIcon.value).toList();
    return {
      'searchName': searchNameController.text,
      'searchIcons': icons,
      'searchRating': searchRating,
    };
  }

  Future<void> loadTasksHistory() async {
    final loadedTasksHistory = await Provider.of<TasksHistoryService>(context, listen: false).getTasksHistory(createPayload());
    setState(() {
      tasksHistory = loadedTasksHistory;
    });
  }

  void setStarRating(int rating){
    setState(() {
      searchRating = rating;
    });
    loadTasksHistory();
  }

  void resetFilters() {
    setState(() {
      searchNameController.text = '';
      searchRating = null;
      iconSelectController.clearAll();
      loadTasksHistory();
    });
  }

  @override
  void dispose() {
    searchNameController.dispose();
    iconSelectController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadTasksHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks history'),
      ),
      drawer: const NavigationDrawerWidget(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(kSmallPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: kMediumInputWidth,
                child: SearchBarWidget(controller: searchNameController, onChangeCallback: loadTasksHistory,),
              ),
              const SizedBox(
                height: kSmallSpacingBoxSize,
                width: kSmallSpacingBoxSize,
              ),
              IconSelectWidget(multipleIconsChangeCallback: loadTasksHistory, initMultipleValue: true, initMultipleController: iconSelectController,),
              const SizedBox(
                height: kSmallSpacingBoxSize,
                width: kSmallSpacingBoxSize,
              ),
              Row(
                children: [
                  RatingInputWidget(setRatingCallback: setStarRating, rating: searchRating,),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  ResetFiltersButtonWidget(resetFiltersCallback: resetFilters),
                ],
              ),
              labelDivider('Tasks History'),
              Expanded(
              child: switch (tasksHistory.length) {
                0 => const Text('No tasks history.'), 
                _ => ListView(children: [
                        for(var i = 0; i < tasksHistory.length; i++) 
                          TaskHistoryRow(taskHistory: tasksHistory[i]),
                      ],
                    ),
              },
            ),
            ],
          ),
        ),
      ),
    );
  }
}