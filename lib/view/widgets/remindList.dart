 InputField(
          title: "Remind Before",
          hint: _selectedRemindTime == 0 ? "In Time" : "$_selectedRemindTime min",
          widget: DropdownButton(
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            iconSize: 32,
            elevation: 4,
            underline: Container(height: 0),
            items: remindList.map<DropdownMenuItem<String>>((int value) {
              return DropdownMenuItem<String>(
                value: value.toString(),
                child: Text(value.toString()),
              );
            }).toList(),
            onChanged:(String? newValue){
              setState((){
                _selectedRemindTime = int.parse(newValue!);
              });
            }
          ),
        )
