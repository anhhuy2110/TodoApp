import 'package:interview/all_file.dart';
import 'package:interview/ui/CreateTask.dart';
import '../model/task.dart';
import 'DetailsTask.dart';

class HomeMain extends StatefulWidget {

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> with SingleTickerProviderStateMixin {

  List<Task> list = [];
  SharedPreferences? sharedPreferences;
  TabController? _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3,vsync: this);
    loadSharedPreferencesAndData();
  }

  // void clearPrefs() {
  //   sharedPreferences?.clear();
  //   setState(() {
  //     initState();
  //   });
  // }

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Tasks',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Container(
            child: IconButton(
              onPressed: () {
                  goToNewItemView();
              },
              icon: const Icon(
                Icons.add_circle_outline,
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
        bottom: list.isNotEmpty ? TabBar(
          controller: _tabController,
          unselectedLabelColor: Colors.black26,
          labelColor: Colors.black,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          tabs: [
            Tab(text: 'All'),
            Tab(text: 'Completed'),
            Tab(text: 'Pending'),
          ],
        ) : null,
      ),
      body:
      TabBarView(
        controller: _tabController,
        children: [
          list.isEmpty ? emptyList() : buildListView(),
          buildCompletedTaskList(),
          buildPendingTaskList(),
        ],
      ),
    );
  }

  void _navigateToDetails(Task task) async {
    final updatedTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsTask(task: task)),
    );
    if (updatedTask != null) {
      setState(() {
        int index = list.indexWhere((element) => element.id == updatedTask.id);
        list[index] = updatedTask;
        saveData();
      });
    }
  }


  Widget emptyList(){
    return SingleChildScrollView(
      child:  Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svg/imgmain.svg',
              ),
              SizedBox(height: 20),
              Text(
                'No tasks found?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Try to create more tasks to your employees or '
                    'create a new project and setup it from scratch',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(129, 129, 165, 1),
                ),
              ),
              SizedBox(height: 29),
              OutlinedButton(
                onPressed: () {
                  // Get.offNamed(Routes.CREATETASK);
                  goToNewItemView();
                },
                child: Text(
                  'Create',
                  style: TextStyle(color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 75,
                    vertical: 15,
                  ),
                  backgroundColor: Color.fromRGBO(94, 129, 244, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListTask(Task item, int index){
    print(item.status);
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
            margin: EdgeInsets.only(top: 0, bottom: 5, right: 10,left: 10),
            color: Colors.white,
            child: ListTile(
              onTap: () => changeItemStatus(item),
              title: Text(
                item.title,
                key: Key('item-$index'),
                style: TextStyle(
                    color: item.status ? Colors.grey : Colors.black,
                    decoration: item.status ? TextDecoration.lineThrough : null
                ),
              ),
              trailing: Icon(item.status
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
                key: Key('completed-icon-$index'),
              ),
            )
        ),
      ],
    );
  }

  Widget buildListView() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => _navigateToDetails(list[index]),
            child: Container(
              margin: EdgeInsets.only(top: 0, bottom: 10, right: 10, left: 10),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListTile(
                leading: Checkbox(
                  value: list[index].status,
                  onChanged: (bool? value) {
                    setState(() {
                      list[index].status = value!;
                      saveData();
                    });
                  },
                ),
                title: Text(list[index].title),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildCompletedTaskList() {
    List<Task> completedTasks = list.where((task) => task.status).toList();
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            if (list[index].status) {
              return InkWell(
                onTap: () => _navigateToDetails(list[index]),
                child: Container(
                    margin: EdgeInsets.only(top: 0, bottom: 10, right: 10, left: 10),
                    color: Colors.white,
                    child: ListTile(
                      title: Text(list[index].title),
                      leading: Checkbox(
                        value: list[index].status,
                        onChanged: (bool? value) {
                          if (value == true) {
                            setState(() {
                              list[index].status = value!;
                            });
                          }
                        },
                      ),
                    )
                ),
              );
            }
            else {
              return SizedBox.shrink();
            }
          }),
    );
  }

  Widget buildPendingTaskList() {
    List<Task> activeTasks = list.where((task) => !task.status).toList();
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            if (!list[index].status) {
              return InkWell(
                onTap: () => _navigateToDetails(list[index]),
                child: Container(
                    margin: EdgeInsets.only(top: 0, bottom: 10, right: 10,left: 10),
                    color: Colors.white,
                    child: ListTile(
                      title: Text(list[index].title),
                      leading: Checkbox(
                        value: list[index].status,
                        onChanged: (bool? value) {
                          if (value == true) {
                            setState(() {
                              list[index].status = value!;
                              // var status = tasks.every((task) => task.status);
                            });
                          }
                        },
                      ),
                    )
                ),
              ) ;
            } else {
              return Container();
            }
          }
      ),
    );

  }





  void goToNewItemView(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return CreateTask();
    })).then((item){
      if(item != null) {
        addItem(item);
      }
    });
  }

  void addItem(Task item){
    int id = DateTime.now().millisecondsSinceEpoch;
    item.id = id;
    list.insert(0, item);
    saveData();
    setState((){});
  }

  void changeItemStatus(Task item){
    setState(() {
      item.status = !item.status;
    });
    saveData();
  }

  void saveData() {
    List<String> stringList = list.map((item) => json.encode(item.toMap())).toList();
    print(stringList);
    sharedPreferences?.setStringList('list', stringList);
  }

  void loadData() {
    List<String>? listString = sharedPreferences?.getStringList('list');
    if(listString != null){
      list = listString.map(
              (item) => Task.fromMap(json.decode(item))
      ).toList();
      setState((){});
    }
  }

}


