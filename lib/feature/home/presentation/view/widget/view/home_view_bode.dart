import 'package:flutter/material.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  List<Map<String, dynamic>> children = [];
  List<String> relationShip = ['father', 'mother', 'sibling', 'other'];

  List<DropdownMenuItem<String>> get relationShipItems {
    return relationShip.map((rel) {
      return DropdownMenuItem(value: rel, child: Text(rel));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                children.add({
                  "name": "",
                  "dateBirth": "",
                  "phone": [
                    {"value": "", "relationShip": relationShip.first},
                  ],
                });
              });
            },
            child: Text('أضف "'),
          ),

          Expanded(
            child: ListView(
              children: List.generate(children.length, (index) {
                final child = children[index];
                final phones = child['phone'] as List;

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.all(16),
                  color: Colors.blue[100],
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'عنصر ${index + 1}',
                            style: TextStyle(fontSize: 18),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                children.removeAt(index);
                              });
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: "الاسم"),
                        onChanged: (val) {
                          child['name'] = val;
                        },
                      ),
                      SizedBox(height: 9),
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(labelText: "تاريخ الميلاد"),
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() {
                              child['dateBirth'] = picked;
                            });
                          }
                        },
                      ),
                      SizedBox(height: 16),
                      ...phones.asMap().entries.map((e) {
                        int phoneIndex = e.key;
                        Map<String, dynamic> phoneValue = e.value;

                        return Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: "رقم الهاتف",
                                ),
                                onChanged: (val) {
                                  phoneValue["value"] = val;
                                },
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              flex: 2,
                              child: DropdownButtonFormField(
                                value: phoneValue["relationShip"],
                                items: relationShipItems,
                                onChanged: (val) {
                                  setState(() {
                                    phoneValue["relationShip"] = val;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: "العلاقة",
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  phones.removeAt(phoneIndex);
                                });
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        );
                      }),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: () {
                            setState(() {
                              phones.add({
                                "value": "",
                                "relationShip": relationShip.first,
                              });
                            });
                          },
                          icon: Icon(Icons.add),
                          label: Text("أضف رقم هاتف"),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
