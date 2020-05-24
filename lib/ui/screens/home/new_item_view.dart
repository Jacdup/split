import 'package:flutter/material.dart';
import 'package:twofortwo/shared/loading.dart';
import 'package:twofortwo/utils/routing_constants.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/utils/screen_size.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/shared/constants.dart';
import 'package:twofortwo/shared/widgets.dart';

class NewItem extends StatefulWidget {

//  final String uid;
//  final bool isTab1;
  final List<Object> uidTab;

  NewItem({this.uidTab});

  @override
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  bool loading = false;

//  static String uid = widget.uidTab[0];

  DateTime selectedDate = DateTime.now();
  DateTime selectedStartDate;
  DateTime selectedEndDate;

  String itemName;
  String description;
  String date;
  final category = TextEditingController();
  String error = '';
  bool _doesntMatter;
//  bool _isButtonDisabled;
//  String text = "Availability";

  @override
  void initState() {
    super.initState();
    _doesntMatter = false;
//    _isButtonDisabled = false;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
//    itemName.dispose();
//    description.dispose();
//    date.dispose();
    category.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

//    (widget. == _formKey1) ? text = "Availability" : text = "When do you need it?";


    return loading
        ? Loading()
        : DefaultTabController(
            length: 2,
            initialIndex: widget.uidTab[1] ? 1 : 0,
            child: Scaffold(
                backgroundColor: customBlue5,
                appBar: PreferredSize(
                  preferredSize:
                      Size.fromHeight(screenHeight(context, dividedBy: 5)),
                  child: AppBar(
                    automaticallyImplyLeading: false,
                    elevation: 0.0,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsets.all(8.0),
                      centerTitle: true,
                      title: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Add item',
                              style: titleFont,
                            ),
                          ],
                        ),
                      ),
                    ),
                    bottom: TabBar(
                      indicatorColor: customYellow2,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 4.0,
                      labelColor: Colors.black87,
                      unselectedLabelColor: Colors.black38,
                      tabs: [
                        new Tab(text: "Post an item"),
                        new Tab(text: "Request an item"),
                      ],
                    ),
                  ),
                ),
                body: new TabBarView(
                  children: <Widget>[
                    _createFields('Dates available', _formKey2),
                    _createFields('Requested usage date', _formKey1),
                  ],
                )),
          );
  }

  Widget _createFields(String dateDescription, GlobalKey type) {
    return Form(
      key: type, // Keep track of form
      child: SingleChildScrollView(
        child: Container(
          width: screenWidth(context, dividedBy: 4),
          margin: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
//              SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Item Name", style: titleDescriptionFont),
                  SizedBox(height: 8.0,),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) {
                      setState(() {
                        itemName = val;
                      });
                    },
                    decoration: textInputDecoration.copyWith(hintText: 'e.g. "Mountain bike"', hintStyle: itemBodyFont),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Description", style:titleDescriptionFont,),
                    SizedBox(height: 8.0,),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Please provide a description' : null,
                      keyboardType: TextInputType.multiline,
                      onChanged: (val) {
                        setState(() {
                          description = val;
                        });
                      },
                      textAlignVertical: TextAlignVertical.top,
                      minLines: 5,
                      maxLines: 10,
                      decoration: textInputDecoration.copyWith(hintText: 'e.g. "Giant 29inch wheels"', hintStyle: itemBodyFont),
//                      maxLines: null,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(dateDescription, style: titleDescriptionFont,),
                  SizedBox(height: 8.0,),
                  Container(
                    decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(16.0)),
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),

                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            RaisedButton(
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                              color: _doesntMatter == true ? Colors.grey : Colors.white70,
                              onPressed: () => _doesntMatter == true ? null : _datePicker(context, true),
                              child: Text(selectedStartDate == null ? "Start Date" : "${selectedStartDate.toString().split(' ')[0]}",style: textFont,),
                            ),
                            SizedBox(width: 8.0,),
                            Text("to", style: textFont,),
                            SizedBox(width: 8.0,),
                            RaisedButton(
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                              color: _doesntMatter == true ? Colors.grey : Colors.white70,
                              onPressed: () => _doesntMatter == true ? null : _datePicker(context, false),
                              child: Text(selectedEndDate == null ? "End Date": "${selectedEndDate.toString().split(' ')[0]}" ,style: textFont,),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(" Doesn't matter", style: textFont,),
                            Checkbox(
                              value: _doesntMatter,

                              tristate: false,onChanged: (bool newValue) {
                              setState(() {
                                _doesntMatter = newValue;
//                                _isButtonDisabled = !_isButtonDisabled;
//                                print(_isButtonDisabled);
                              });
                            },),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
//              Container(
//                child: IconButton(onPressed: (){print(widget.uidTab[1]);},icon: Icon(Icons.add_photo_alternate),iconSize: 40.0,color: Colors.black87,),
//              ),

              (type == _formKey1) ? ButtonWidget(icon: Icons.navigate_next, onPressed: onPressedBtn1)
                  : ButtonWidget(icon: Icons.navigate_next, onPressed: onPressedBtn2),

            ], // Children
          ),
        ),
      ),
    );
  }

  Future<Null>_datePicker(BuildContext context, bool start) async{
    DateTime endVal;
    DateTime startVal;
    // This does the job of validation for startDate < endDate
    if (start == false){
      endVal = DateTime(2101);
       selectedStartDate == null ? startVal = DateTime.now() : startVal = selectedStartDate; // Value can't be smaller than selectedStartDate
    }else{
      startVal = DateTime.now();
//        selectedEndDate == null ? startVal = DateTime.now() : startVal = selectedEndDate;
        selectedEndDate == null ? endVal = DateTime(2101) : endVal = selectedEndDate; // Value can't be larger than selectedEndDate
      }
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: startVal,
        firstDate: startVal ,
        lastDate: endVal,
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        (start == true) ? selectedStartDate = picked : selectedEndDate = picked;
//        selectedDate = picked;
      });
  }


  onPressedBtn1() async {
    if (_formKey1.currentState.validate()) {
      Item newItem = new Item(null, itemName, selectedStartDate.toString().split(' ')[0], selectedEndDate.toString().split(' ')[0] , description, widget.uidTab[0], '1', DateTime.now());
      Navigator.pushReplacementNamed(context,CategoryRoute, arguments: newItem);
    }

  }


  onPressedBtn2() async {
    if (_formKey2.currentState.validate()) {
      ItemAvailable newItem = new ItemAvailable(null, itemName, selectedStartDate.toString().split(' ')[0], selectedEndDate.toString().split(' ')[0] ,description, widget.uidTab[0], '2',DateTime.now());
      Navigator.pushReplacementNamed(context,CategoryRoute, arguments: newItem);
    }

  }





}
