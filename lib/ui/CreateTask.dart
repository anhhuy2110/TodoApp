import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../all_file.dart';
import '../model/subtask.dart';
import '../model/task.dart';

class CreateTask extends StatefulWidget {

  final Task? item;
  CreateTask({this.item});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController statusController;
  late TextEditingController dateTaskController;

  int subtaskCount = 1;
  bool isAddingSubtask = false;
  List<SubTask> subtasks = [SubTask(title: '', status: false)];
  List<TextEditingController> subtaskControllers = [TextEditingController()];

//test


  //test

  @override
  void initState() {
    super.initState();
    titleController = new TextEditingController(
        text: widget.item != null ? widget.item?.title : "");
    descriptionController = new TextEditingController(
        text: widget.item != null ? widget.item?.description: ""
    );
    statusController = new TextEditingController(
        text: widget.item != null ? widget.item?.status.toString(): "false");
    dateTaskController = new TextEditingController(
        text: widget.item != null
            ? DateFormat('dd MMM yyyy').format(
            DateFormat('yyyy-MM-dd').parse(widget.item!.dateTask))
            : "");

      if (widget.item != null) {
        subtasks = List<SubTask>.from(widget.item!.subtasks);
        subtaskControllers = List<TextEditingController>.generate(
          subtasks.length,
              (index) => TextEditingController(text: subtasks[index].title),
        );
      } else {
        if (subtasks.isEmpty) {
          subtasks.add(SubTask(title: ''));
        }
        subtaskControllers = List<TextEditingController>.generate(
          subtasks.length,
              (index) => TextEditingController(text: subtasks[index].title),
        );
      }


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
        title: Text(
          'Add New Task',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Container(
          child: IconButton(
            onPressed: () {
              Get.offNamed(Routes.HOMEMAIN);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
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
          margin: EdgeInsets.fromLTRB(10, 10, 0, 12),
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
                              controller: titleController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 0, right: 0, top: 0, bottom: 5),
                                border: InputBorder.none,
                                hintText: 'Type your task',
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
                                      lastDate:
                                      DateTime(DateTime.now().year + 50),
                                    ).then((date) {
                                      if (date != null) {
                                        setState(() {
                                          dateTaskController.text =
                                              DateFormat('dd MMM yyyy').format(date);
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
                                    dateTaskController.text.isNotEmpty
                                        ? dateTaskController.text
                                        : 'Select date',
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
                            controller: descriptionController,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Start typing...',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
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
                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: subtasks.length,
                          itemBuilder: (context, index) {
                            // final subtask = subtasks[index];
                            return FocusScope(
                              child: Focus(
                                onFocusChange: (hasFocus) {
                                  if (!hasFocus) {
                                    // Khi TextField mất focus, cập nhật giá trị của SubTask tương ứng
                                    setState(() {
                                      subtasks[index].title = subtaskControllers[index].text;
                                    });
                                  }
                                },
                                child: Row(
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
                                          value: subtasks[index].status,
                                          onChanged: (value) {
                                            setState(() {
                                              subtasks[index].status = value ?? false;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Flexible(
                                      flex: 9,
                                      child: TextField(
                                        controller: subtaskControllers[index],
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
                                            subtasks[index].title = value;
                                            isAddingSubtask = false;
                                          });
                                        },
                                        onEditingComplete: () {
                                          if (subtaskControllers[index].text.isNotEmpty &&
                                              !isAddingSubtask) {
                                            setState(() {
                                              isAddingSubtask = true;
                                              var newController = TextEditingController();

                                              subtaskControllers.add(TextEditingController());
                                              subtasks.add(SubTask(title: ''));
                                            });
                                            // Di chuyển con trỏ đến TextField mới
                                            FocusScope.of(context).requestFocus(FocusNode());
                                            FocusScope.of(context).nextFocus();
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: OutlinedButton(
                onPressed: () {
                  submit();
                },
                child: Text(
                  'Create New Task',
                  style: TextStyle(color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(94, 129, 244, 1),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void submit(){
    Task task = Task(
      title: titleController.text,
      description: descriptionController.text,
      dateTask: dateTaskController.text,
      subtasks: subtaskControllers
          .map((controller) => SubTask(title: controller.text))
          .toList(),
    );
    Navigator.of(context).pop(task);
  }


}
