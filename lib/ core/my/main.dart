
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

void main() {
  runApp(const BathTimeShow());
}

class BathTimeShow extends StatefulWidget {
  const BathTimeShow({super.key});

  @override
  State<BathTimeShow> createState() => _BathTimeShowState();
}

class _BathTimeShowState extends State<BathTimeShow> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              const Text(
                'Batch Time',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: list.map((batch) {
                  if (selectedList.contains(batch.batchTime)) {
                    batch.value = true;
                  }

                  return BatchWidget(
                    text: batch.batchTime,
                    color: batch.value,
                  );
                }).toList(),
              ),
              const Gap(10),
              TextButton(
                onPressed: () {
                  setState(() {
                    list.add(
                      BatchTime(batchTime: 'batchTime', value: true),
                    );
                    selectedList.add('batchTime');
                  });
                },
                child: const Text('Add Batch'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<BatchTime> list = [
  BatchTime(batchTime: '10-2', value: false),
  BatchTime(batchTime: '2-6', value: false),
  BatchTime(batchTime: '6-10', value: false),
  BatchTime(batchTime: '10-5', value: false),
];

List<String> selectedList = <String>[
  '10-2',
  '2-6',
  '6-10',
];

class BatchWidget extends HookWidget {
  const BatchWidget({
    required this.text,
    required this.color,
    super.key,
  });

  final String text;
  final bool color;

  @override
  Widget build(BuildContext context) {
    final v = useState(color);
    return GestureDetector(
      onTap: () {
        v.value = !v.value;

        if (v.value) {
          selectedList.add(text);
        } else {
          selectedList.removeWhere((element) => element == text);
        }

        print(selectedList);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: v.value ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class BatchTime {
  BatchTime({
    required this.batchTime,
    required this.value,
  });

  final String batchTime;
  bool value;
}
