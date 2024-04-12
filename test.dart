    Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: TextEditingController(text: selectedExpertise),
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Tech stack',
                      labelStyle: AppTextStyles.headerStyle,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                    onSelected: (String value) {
                      setState(() {
                        setState(() {
                          selectedExpertise = value;
                        });
                      });
                    },
                    itemBuilder: (BuildContext context) => [
                          'Fullstack',
                          'Mobile',
                          'Backend',
                          'Frontend',
                          'DevOps',
                          'QA',
                          'Other'
                        ].map<PopupMenuItem<String>>((String value) {
                          return PopupMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    icon: Icon(Icons.edit),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
              ],
            ),
            // Skills
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: null, // Tạo một TextEditingController mới
                        enabled: false,
                        decoration: const InputDecoration(
                          labelText: 'Skill',
                          labelStyle: AppTextStyles.bodyStyle,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (String value) {
                        setState(() {
                          setState(() {
                            selectedSkills.add(value);
                          });
                        });
                      },
                      itemBuilder: (BuildContext context) =>
                          skills.map((String skill) {
                        return PopupMenuItem<String>(
                          value: skill,
                          child: Text(skill),
                        );
                      }).toList(),
                      icon: Icon(Icons.add),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ],
                ),
                // Wrap widget to display selected skills
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    ...selectedSkills.map((skill) {
                      return Chip(
                        label: Text(skill),
                        onDeleted: () {
                          setState(() {
                            selectedSkills.remove(skill);
                          });
                        },
                      );
                    }).toList(),
                  ],
                ),
              ],
            ),
            // Education history
       