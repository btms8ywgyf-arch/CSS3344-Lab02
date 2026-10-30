import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const StudentInfoApp());
}

class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSS3344 Lab 02',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const StudentProfileScreen(),
    );
  }
}

// ─── 主页面：StatefulWidget（因为 Picker 需要记住选的值）───
class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedRole = 'Student';

  // ── Material Date Picker ──
  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  // ── Cupertino Date Picker（底部弹出）──
  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 240,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: _selectedDate,
          onDateTimeChanged: (DateTime newDate) {
            setState(() => _selectedDate = newDate);
          },
        ),
      ),
    );
  }

  // ── Cupertino Wheel Picker（底部弹出）──
  void _showCupertinoRolePicker(BuildContext context) {
    final List<String> roles = ['Student', 'Developer', 'Designer'];
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 200,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoPicker(
          itemExtent: 32,
          onSelectedItemChanged: (int index) {
            setState(() => _selectedRole = roles[index]);
          },
          children: roles.map((role) => Center(child: Text(role))).toList(),
        ),
      ),
    );
  }

  // ── Exercise 2.2: 竖屏布局 ──
  Widget _buildPortraitView() {
    return ListView(
      children: [
        const StudentDetailsSection(),
        const TitleSection(
          name: 'University of Technology Sarawak',
          location: 'Sibu, Sarawak, Malaysia',
          starCount: 100,
        ),
        PickersSection(
          selectedDate: _selectedDate,
          selectedRole: _selectedRole,
          onMaterialDate: () => _selectMaterialDate(context),
          onCupertinoDate: () => _showCupertinoDatePicker(context),
          onRoleChanged: (val) => setState(() => _selectedRole = val!),
          onCupertinoRole: () => _showCupertinoRolePicker(context),
        ),
      ],
    );
  }

  // ── Exercise 2.2: 横屏布局 ──
  Widget _buildLandscapeView() {
    return Row(
      children: [
        const Expanded(
          child: SingleChildScrollView(child: StudentDetailsSection()),
        ),
        Expanded(
          child: ListView(
            children: [
              const TitleSection(
                name: 'University of Technology Sarawak',
                location: 'Sibu, Sarawak, Malaysia',
                starCount: 100,
              ),
              PickersSection(
                selectedDate: _selectedDate,
                selectedRole: _selectedRole,
                onMaterialDate: () => _selectMaterialDate(context),
                onCupertinoDate: () => _showCupertinoDatePicker(context),
                onRoleChanged: (val) => setState(() => _selectedRole = val!),
                onCupertinoRole: () => _showCupertinoRolePicker(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      // ── Exercise 2.2: OrientationBuilder ──
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitView()
              : _buildLandscapeView();
        },
      ),
    );
  }
}

// ─── Widget 1: 学生资料卡 ───
class StudentDetailsSection extends StatelessWidget {
  const StudentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
              const SizedBox(height: 20),
              const Text(
                'LING YEW HAN',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Student ID: BCS24020034',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Divider(height: 32, thickness: 1),
              const Text(
                'Personal Life Goal / Quote:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                '"I hope to one day be rich enough that at a buffet, I can request à la carte instead."',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Widget 2: TitleSection (Exercise 2.1) ───
class TitleSection extends StatelessWidget {
  final String name;
  final String location;
  final int starCount;

  const TitleSection({
    super.key,
    required this.name,
    required this.location,
    required this.starCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Location Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        location,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.star, color: Colors.red[500]),
                const SizedBox(width: 4),
                Text('$starCount'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Widget 3: PickersSection (Exercise 2.3) ───
class PickersSection extends StatelessWidget {
  final DateTime selectedDate;
  final String selectedRole;
  final VoidCallback onMaterialDate;
  final VoidCallback onCupertinoDate;
  final ValueChanged<String?> onRoleChanged;
  final VoidCallback onCupertinoRole;

  const PickersSection({
    super.key,
    required this.selectedDate,
    required this.selectedRole,
    required this.onMaterialDate,
    required this.onCupertinoDate,
    required this.onRoleChanged,
    required this.onCupertinoRole,
  });

  @override
  Widget build(BuildContext context) {
    final dateStr =
        '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Pickers (Lab 2.2)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text('Selected Date: $dateStr'),
            Text('Selected Role: $selectedRole'),
            const SizedBox(height: 12),

            // 1. Material Date Picker
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onMaterialDate,
                icon: const Icon(Icons.calendar_today),
                label: const Text('Material Date Picker'),
              ),
            ),
            const SizedBox(height: 8),

            // 2. Cupertino Date Picker
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onCupertinoDate,
                icon: const Icon(CupertinoIcons.calendar),
                label: const Text('Cupertino Date Picker (Modal Sheet)'),
              ),
            ),
            const SizedBox(height: 12),

            // 3. Material Dropdown
            Row(
              children: [
                const Text('Material Dropdown: '),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: selectedRole,
                  items: ['Student', 'Developer', 'Designer']
                      .map((role) => DropdownMenuItem(
                            value: role,
                            child: Text(role),
                          ))
                      .toList(),
                  onChanged: onRoleChanged,
                ),
              ],
            ),
            const SizedBox(height: 8),

            // 4. Cupertino Wheel Picker
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onCupertinoRole,
                icon: const Icon(CupertinoIcons.list_bullet),
                label: const Text('Cupertino Role Wheel Picker'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
