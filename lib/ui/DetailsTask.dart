import 'package:intl/intl.dart';
import '../all_file.dart';
import '../model/subtask.dart';
import '../model/task.dart';

class DetailsTask extends StatefulWidget {
  final Task task;

  DetailsTask({Key? key, required this.task}) : super(key: key);

  int CountCompleteSub() {
    int count = 0;
    for (int i = 0; i < task.subtasks.length; i++) {
      if (task.subtasks[i].status == true)
        count++;
    }
    return count;
  }

  //test

  @override
  State<DetailsTask> createState() => _DetailsTaskState();
}

class _DetailsTaskState extends State<DetailsTask> {
  bool _newStatus = false;

  late TextEditingController _titleController;
  String _newTitle = "";


  late TextEditingController _descriptionController;
  String _newDescription = "";

  late TextEditingController _dateController;
  String _newDate = "";

  List<SubTask> _subtasks = [SubTask(title: '')];
  List<TextEditingController> _subtaskControllers = [TextEditingController()];

  bool isAddingSubtask = false;





  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
    _dateController = TextEditingController(text: widget.task.dateTask);

    _newStatus = widget.task.status;


    if (widget.task != null) {
      _subtasks = List<SubTask>.from(widget.task.subtasks);
      _subtaskControllers = List<TextEditingController>.generate(
        _subtasks.length,
            (index) => TextEditingController(text: _subtasks[index].title),
      );
    } else {
      if (_subtasks.isEmpty) {
        // Nếu danh sách subtasks rỗng, tạo một subtask mặc định
        _subtasks.add(SubTask(title: ''));
      }
      _subtaskControllers = List<TextEditingController>.generate(
        _subtasks.length,
            (index) => TextEditingController(text: _subtasks[index].title),
      );
    }

    // test
    // if (widget.task != null) {
    //   _subtasks = List<SubTask>.from(widget.task.subtasks);
    //   _subtaskControllers = List<TextEditingController>.generate(
    //     _subtasks.length,
    //         (index) => TextEditingController(text: _subtasks[index].title),
    //   );
    // } else {
    //   _subtaskControllers.add(TextEditingController());
    // }


    /////////////////////
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode _focusNode = FocusNode();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromRGBO(245, 245, 250, 1),
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        actions: <Widget>[
          Container(
            child: IconButton(
              onPressed: () {
                setState(() {
                  _newTitle = _titleController.text;
                  widget.task.title = _newTitle.isNotEmpty ? _newTitle : widget.task.title;

                  _newDescription = _descriptionController.text;
                  widget.task.description = _newDescription.isNotEmpty ? _newDescription : widget.task.description;

                  _newDate = _dateController.text;
                  widget.task.dateTask = _newDate.isNotEmpty ? _newDate : widget.task.dateTask;

                  // bool allSubtasksCompleted = widget.task.subtasks
                  //     .where((subtask) => subtask.title.isNotEmpty)
                  //     .where((subtask) => subtask.status)
                  //     .length == widget.task.subtasks.where((subtask) => subtask.title.isNotEmpty).length;
                  // widget.task.status = allSubtasksCompleted;

                  // _newStatus = widget.task.status;
                  widget.task.status = _newStatus;

                  _subtasks = _subtasks
                      .where((subtask) => subtask.title.isNotEmpty)
                      .toList();
                  widget.task.subtasks = _subtasks;
                  _subtasks.add(SubTask(title: ''));



                });
                Navigator.pop(context, widget.task);

              },
              icon: const Icon(
                Icons.save_as_rounded,
                color: Color.fromRGBO(129, 129, 165, 1),
                size: 20,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Color.fromRGBO(129, 129, 165, 0.1),
            ),
            width: 50,
            height: 50,
            margin: EdgeInsets.fromLTRB(0, 10, 12, 12),
          ),
        ],
        title: Text(
          'Tasks Details',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 70,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: _titleController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 0, right: 0, top: 0, bottom: 5),
                                border: InputBorder.none,
                                // hintText: widget.task.title,
                              ),
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Task created on ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(129, 129, 165, 1),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                              activeColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                              // value: status,
                              onChanged: (inputValue) {
                                setState(() {
                                  // widget.task.status = inputValue!;
                                  _newStatus = inputValue!;
                                });
                              }, value: _newStatus,
                              // value: widget.task.subtasks.where((subtask) => subtask.title != '' && subtask.status).length == widget.task.subtasks.where((subtask) => subtask.title != '').length,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Due to',
                                  style: TextStyle(
                                    color: Color.fromRGBO(129, 129, 165, 1),
                                  ),
                                ),
                                SizedBox(height: 5),
                                OutlinedButton(
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(DateTime.now().year + 50),
                                    ).then((date) {
                                      if (date != null) {
                                        setState(() {
                                          _newDate = DateFormat('dd MMM yyyy').format(date);
                                          _dateController.text = _newDate;
                                        });
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/calendar_outline.svg',
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        _newDate.isNotEmpty ? _dateController.text :
                                        widget.task.dateTask,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                )

                              ],
                            ),
                          ],
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, left: 15, right: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                              color: Color.fromRGBO(129, 129, 165, 1),
                            ),
                          ),
                          TextField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              isDense: true,
                              // hintText: widget.task.description,
                              // hintStyle: TextStyle(
                              //   fontWeight: FontWeight.w600,
                              //   fontSize: 14,
                              // ),
                            ),
                            maxLines: 4,
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, left: 15, right: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Subtasks',
                            style: TextStyle(
                              color: Color.fromRGBO(129, 129, 165, 1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Checklist',
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        DetailsTask(task: widget.task).CountCompleteSub().toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(width: 2),
                                      Text('/'),
                                      SizedBox(width: 2),
                                      Text(widget.task.subtasks.where((subtask) => subtask.title != '').length.toString()),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              LinearProgressIndicator(
                                color: Color.fromRGBO(244, 190, 94, 1),
                                backgroundColor: Color.fromRGBO(240, 240, 243, 1),
                                value: (widget.task.subtasks.where((subtask) => subtask.title != '').length == 0)
                                    ? 0
                                    : (DetailsTask(task: widget.task).CountCompleteSub().toDouble()/
                                    widget.task.subtasks.where((subtask) => subtask.title != '').length),
                              ),

                              SizedBox(height: 20),
                            ],
                          ),
                          Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _subtasks.length,
                                itemBuilder: (context, index) {
                                  // final subtask = _subtasks[index];
                                  if(_subtasks.isNotEmpty)
                                    return Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Transform.scale(
                                            scale: 1.3,
                                            child: Checkbox(
                                              activeColor: Colors.blue,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(4),
                                                ),
                                              ),
                                              value: _subtasks[index].status,
                                              onChanged: (value) {
                                                setState(() {
                                                  _subtasks[index].status = value ?? false;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Flexible(
                                          flex: 9,
                                          child: TextField(
                                              controller: _subtaskControllers[index],
                                              textInputAction: TextInputAction.done,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Type to add more ...',
                                                hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromRGBO(129, 129, 165, 1),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color.fromRGBO(129, 129, 165, 1),
                                                fontWeight: FontWeight.w600,
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  _subtasks[index].title = value;
                                                  isAddingSubtask = false;
                                                });
                                              },
                                            onEditingComplete: () {
                                              if (_subtaskControllers[index].text.isNotEmpty &&
                                                  !isAddingSubtask) {
                                                setState(() {
                                                  isAddingSubtask = true;
                                                  var newController = TextEditingController();

                                                  _subtaskControllers.add(TextEditingController());
                                                  _subtasks.add(SubTask(title: ''));
                                                });
                                                // Di chuyển con trỏ đến TextField mới
                                                FocusScope.of(context).requestFocus(FocusNode());
                                                FocusScope.of(context).nextFocus();
                                                isAddingSubtask = false;
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                );
                              },
                            )
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
