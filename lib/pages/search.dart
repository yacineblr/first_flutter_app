import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class SearchPage extends StatefulWidget {
  
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}


class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formFieldDepartureKey = GlobalKey<FormFieldState>();
  final _formFieldArrivalKey = GlobalKey<FormFieldState>();
  final _formFieldDatetimeKey = GlobalKey<FormFieldState>();
  final _formDatetimeTextEditingController = TextEditingController(text: '01/01/2000');

  ///Page Controller for the PageView
  final controller = PageController(initialPage: 0);
  Map<String, Map<FormFieldState, Widget>> step;

  @override
  void initState() { 
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    List<Widget> list = [];

    var generateButton = (GlobalKey<FormFieldState> key, Widget nextTarget) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Center(child: RaisedButton(
          onPressed: () async {
            // Validate will return true if the form is valid, or false if
            // the form is invalid.
            if (key.currentState.validate()) {
              // Process data.
              if (nextTarget != null) {
                list.add(nextTarget);
                await controller.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut
                );
              }
            }
          },
          child: Text('Submit'),
        ),)
      );
    };
    
    var departure = ({Widget nextTarget}) {
      return Container(margin: EdgeInsets.all(25), child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Departure'),
          TextFormField(
            key: _formFieldDepartureKey,
            initialValue: '16 rue Baraban, Villeurbanne, 69100',
            decoration: const InputDecoration(
              hintText: 'Departure address',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your departure address';
              }
              return null;
            },
          ),
          generateButton(_formFieldDepartureKey, nextTarget)
        ]
      ));
    };

    var arrival = ({Widget nextTarget}) {
      return Container(margin: EdgeInsets.all(25), child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Arrival'),
          TextFormField(
            key: _formFieldArrivalKey,
            initialValue: '16 rue Baraban, Villeurbanne, 69100',
            decoration: const InputDecoration(
              hintText: 'Arrival address',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your arrival address';
              }
              return null;
            },
          ),
          generateButton(_formFieldArrivalKey, nextTarget)
        ]
      ));
    };

    var datetime = () {
      return Container(margin: EdgeInsets.all(25), child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Departure datetime'),
          GestureDetector(
            onTap: () {
              print('click');
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                minTime: DateTime(2018, 3, 5),
                maxTime: DateTime(2019, 6, 7),
                onChanged: (date) {
                  print('change $date');
                },
                onConfirm: (date) {
                  print('confirm $date');
                  _formDatetimeTextEditingController.text = date.toString();
                },
                currentTime: DateTime.now(),
                locale: LocaleType.fr
              );
            },
            child: AbsorbPointer(child:
              Container(child: 
                TextFormField(
                  key: _formFieldDatetimeKey,
                  controller: _formDatetimeTextEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Datetime',
                  ),
                  enabled: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your departure datetime';
                    }
                    return null;
                  },
                )
              )
            )
          ) 
        ]
      ));
    };

    list.add(
      departure(nextTarget:
        arrival(nextTarget: datetime())
      )
    );


    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actionsIconTheme: IconThemeData(color: Colors.black),
        leading: Padding( // --> Custom Back Button
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            hoverElevation: 0,
            hoverColor: Colors.transparent,
            elevation: 0,
            mini: true,
            onPressed: () => Navigator.of(context).pop(),
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        // title: Text('Search', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.transparent,
        elevation: 0
      ),
      extendBodyBehindAppBar: true,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: PageView(
            controller: controller,
            scrollDirection: Axis.vertical,
            pageSnapping: true,
            children: list,
          )
        )
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _formDatetimeTextEditingController.dispose();
    super.dispose();
  }

}
