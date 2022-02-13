import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_example/drawer.dart';

class AnnFormSetSample extends StatefulWidget {
  // const AnnFormSetSample({Key? key}) : super(key: key);

  @override
  _AnnFormSetSampleState createState() => _AnnFormSetSampleState();
}

class _AnnFormSetSampleState extends State<AnnFormSetSample> {
  FormGroup _formGroup = fb.group(<String, Object>{
    "name": [''],
    "name2": [''],
    "date": [''],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("表单设置测试")),
      drawer: AppDrawer(),
      body: ListView(
        children: [
          ReactiveForm(
              formGroup: _formGroup,
              child: Column(
                children: [
                  ReactiveTextField<String>(
                    formControlName: "name",
                  )
                ],
              )),
          ReactiveForm(
              formGroup: _formGroup,
              child: Column(
                children: [
                  ReactiveTextField<String>(
                    formControlName: "name",
                  )
                ],
              )),
          ReactiveForm(
              formGroup: _formGroup,
              child: Column(
                children: [
                  ReactiveTextField<String>(
                    formControlName: "name2",
                  )
                ],
              )),
          ElevatedButton(onPressed: (){
            _formGroup.control("name").value = "100";
          }, child: Text("设置Name值 control方式")),
          ElevatedButton(onPressed: (){
            _formGroup.value = {
              "name2":"name2 set"
            };
          }, child: Text("设置Name值 value方式"))
        ],
      ),
    );
  }
}