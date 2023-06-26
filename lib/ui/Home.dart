import 'package:get/get.dart';
import 'package:interview/all_file.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'homeMain.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _pin = '';
  bool _isPinSet = false;
  @override
  void initState() {
    super.initState();
    _getPinStatus();
  }

  Future<void> _getPinStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isPinSet = prefs.containsKey('pin');
    });
  }
  void _removePin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('pin')) {
      await prefs.remove('pin');
      setState(() {
        _isPinSet = false;
        _pin = '';
      });
      Get.snackbar(
        'Success',
        'Passcode has been removed.',
        backgroundColor: Colors.greenAccent,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        'No PIN is set.',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void _changePin() {
    TextEditingController _oldPasswordController = TextEditingController();
    TextEditingController _newPasswordController = TextEditingController();

    Get.defaultDialog(
      title: 'Change Passcode',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Enter your old passcode'),
          SizedBox(height: 20),
          PinCodeTextField(
            appContext: context,
            obscureText: true,
            length: 4,
            onChanged: (pin) {
              setState(() {
                _pin = pin;
              });
            },
            controller: _oldPasswordController,
          ),
          SizedBox(height: 20),
          Text('Enter a new passcode'),
          SizedBox(height: 20),
          PinCodeTextField(
            appContext: context,
            obscureText: true,
            length: 4,
            onChanged: (pin) {
              setState(() {
                _pin = pin;
              });
            },
            controller: _newPasswordController,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            if (_pin == prefs.getString('pin')) {
              if (_newPasswordController.text.length == 4) {
                prefs.setString('pin', _newPasswordController.text);
                Navigator.pop(context);
                Get.snackbar(
                  'Success',
                  'Passcode has been updated.',
                  backgroundColor: Colors.greenAccent,
                  colorText: Colors.white,
                );
                _newPasswordController.clear();
                _oldPasswordController.clear();
                _updatePinStatus();
              } else {
                Get.snackbar(
                  'Error',
                  'Please enter a 4-digit passcode.',
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                );
              }
            } else {
              Get.snackbar(
                'Error',
                'Incorrect old passcode. Please try again.',
                backgroundColor: Colors.redAccent,
                colorText: Colors.white,
              );
            }
          },
          child: Text('Update'),
        ),
      ],
    );
  }



  void _updatePinStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isPinSet = prefs.containsKey('pin');
    });
  }

  void _checkPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_isPinSet) {
      if (_pin == prefs.getString('pin')) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeMain(),
          ),
        );
      } else {
        Get.snackbar(
          'Error',
          'Incorrect PIN. Please try again.',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } else {
      Get.defaultDialog(
        title: 'Create Passcode',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Create a 4 digit passcode'),
            SizedBox(height: 20),
            PinCodeTextField(
              appContext: context,
              obscureText: true,
              length: 4,
              onChanged: (pin) {
                setState(() {
                  _pin = pin;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              prefs.setString('pin', _pin);
              _updatePinStatus(); // Update pin status after pin is created
              Navigator.pop(context);
              Get.snackbar(
                'Success',
                'Passcode has been set.',
                backgroundColor: Colors.greenAccent,
                colorText: Colors.white,
              );
              setState(() {
              });
            },
            child: Text('Save'),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _isPinSet ? EnterPin() : CreatePin(),
    );
  }

  Widget CreatePin() {
    return Center(
        child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Text(
            'Create Passcode',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
            SizedBox(height: 20),
            PinCodeTextField(
              appContext: context,
              obscureText: true,
              length: 4,
              onChanged: (pin) {
              setState(() {
                _pin = pin;
              });
            },
          ),
            SizedBox(height: 20),
            ElevatedButton(
            onPressed: () async {
              if (_pin.length == 4) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('pin', _pin);
                setState(() {
                  _isPinSet = true;
                  _pin = '';
                });
                Get.snackbar(
                  'Success',
                  'Passcode has been set.',
                  backgroundColor: Colors.greenAccent,
                  colorText: Colors.white,
                );
              } else {
                Get.snackbar(
                  'Error',
                  'Please enter a 4-digit passcode.',
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                );
              }
            },
            child: Text('Save'),
          ),
        ],
      )
    )
    );
  }

  Widget EnterPin(){
    return Center(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 100),
                  Text(
                    'Enter Passcode',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 50),
                  PinCodeTextField(
                    appContext: context,
                    obscureText: true,
                    length: 4,
                    onChanged: (pin) {
                      setState(() {
                        _pin = pin;
                        if (pin.length == 4) {
                          _checkPin();
                        }
                      });
                    },
                  ),
                  SizedBox(height: 50),
                  InkWell(
                    onTap: () {
                        _removePin();
                    },
                    child: Text(
                      'Forgot Passcode',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  InkWell(
                    onTap: () {
                      _changePin();
                    },
                    child: Text(
                      'Change Passcode',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ]
            )
        )
    );
  }

}