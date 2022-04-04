import 'package:farmerce_client/graphql/farmerce.schema.schema.gql.dart';
import 'package:farmerce_client/l10n/l10n.dart';
import 'package:farmerce_client/main.dart';
import 'package:farmerce_client/modules/nursery/create_nursery_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfire_ui/src/auth/validators.dart';
import 'package:get/get.dart';

class CreateNurseryPage extends StatefulWidget {
  const CreateNurseryPage({Key? key}) : super(key: key);

  @override
  State<CreateNurseryPage> createState() => _CreateNurseryPageState();
}

class _CreateNurseryPageState extends State<CreateNurseryPage> {
  late GlobalKey<FormState> _formKey;
  late GInfrastructureEnum _currentInfrastructureValue;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(CreateNurseryController());
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Nursery"),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: GetBuilder<CreateNurseryController>(builder: (logic) {
              return Column(
                children: [
                  if (logic.status.isLoading) LinearProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: logic.nurseryNameController,
                      // onSaved: (value) => logic.phoneNoController.text,
                      validator: Validator.validateAll([
                        NotEmpty(lo(context).cantBeEmpty),
                      ]),
                      decoration: InputDecoration(
                        hintText: lo(context).nameOfNursery,
                        // suffixIcon: IconButton(
                        //   onPressed: () {
                        //     logic.phoneNoController.clear();
                        //     formKey.currentState?.reset();
                        //   },
                        //   icon: const Icon(
                        //     CupertinoIcons.clear,
                        //     color: Colors.grey,
                        //   ),
                        // ),
                      ),
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        hintText: "Type",
                      ),
                      validator: (GInfrastructureEnum? value) {
                        if (value == null) return lo(context).cantBeEmpty;
                      },
                      items: GInfrastructureEnum.values
                          .map((GInfrastructureEnum value) {
                        return DropdownMenuItem<GInfrastructureEnum>(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                      onChanged: (GInfrastructureEnum? newValue) {
                        if (newValue == null) return;
                        _currentInfrastructureValue = newValue;
                        // state.didChange(newValue);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState!.validate()) {
                          //Note infrastructure will be assigned coz validate wont non assignment pass it.
                          logic.nurseryCreate(_currentInfrastructureValue);
                          // Process data.
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              );
            }),
          ),
        ));
  }
}
