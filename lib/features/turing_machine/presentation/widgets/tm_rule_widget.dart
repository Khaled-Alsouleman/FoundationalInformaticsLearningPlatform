import 'package:foundational_learning_platform/core/utils/index.dart';

class RuleWidget extends StatelessWidget {
  final int ruleNumber;
  final TextEditingController currentStateController;
  final TextEditingController readSymbolController;
  final TextEditingController writeSymbolController;
  final TextEditingController directionController;
  final TextEditingController newStateController;
  final VoidCallback onDelete;

  const RuleWidget({
    super.key,
    required this.ruleNumber,
    required this.currentStateController,
    required this.readSymbolController,
    required this.writeSymbolController,
    required this.directionController,
    required this.newStateController,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            '$ruleNumber',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 16),
        _buildTextField(controller: currentStateController, label: "Current State"),
        const SizedBox(width: 16),
        _buildTextField(controller: readSymbolController, label: "Read"),
        const SizedBox(width: 16),
        _buildTextField(controller: writeSymbolController, label: "Write"),
        const SizedBox(width: 16),
        _buildDropdownField(controller: directionController, label: "Direction"),
        const SizedBox(width: 16),
        _buildTextField(controller: newStateController, label: "New State"),
        const SizedBox(width: 16),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.orange),
          onPressed: onDelete,
        ),
      ],
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({required TextEditingController controller, required String label}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
          DropdownButtonFormField<String>(
            value: controller.text.isEmpty ? null : controller.text,
            items: const [
              DropdownMenuItem(value: 'Left', child: Text('Left')),
              DropdownMenuItem(value: 'Right', child: Text('Right')),
            ],
            onChanged: (value) {
              if (value != null) {
                controller.text = value;
              }
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
