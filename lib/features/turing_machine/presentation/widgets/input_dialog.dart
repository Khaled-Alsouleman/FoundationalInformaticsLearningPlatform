import 'package:foundational_learning_platform/core/utils/index.dart';

class InputDialog extends StatefulWidget {
  final Function(String) onNext;
  final TuringMachine machine;

  const InputDialog({Key? key, required this.onNext, required this.machine}) : super(key: key);

  @override
  State<InputDialog> createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  final inputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height > 600 ? MediaQuery.of(context).size.height * 0.4 : 300,
        width: MediaQuery.of(context).size.width * 0.50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Geben Sie unten die gewünschte Zeichenfolge ein:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Gültiges Alphabet: {${widget.machine.alphabet.join(",")}}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black45,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                child: TextFormField(
                  controller: inputController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value != null) {

                      final chars = value.split("").toList();
                      for (final char in chars) {
                        if (!widget.machine.alphabet.contains(char)) {
                          return "String enthält ungültige Symbole";
                        }
                      }
                      if (value.isEmpty) {
                        //return null;
                        return "Eingabe darf nicht leer sein!!";
                      }
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    Navigator.pop(context);
                    widget.onNext(inputController.text);
                    inputController.clear();
                  }
                },
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(
                    Size(MediaQuery.of(context).size.width, 50),
                  ),
                  elevation: WidgetStateProperty.all(0),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                child: const Text(
                  "Ausführen",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
