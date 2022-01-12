import 'package:tflite_flutter/tflite_flutter.dart';

class MachineLearningAgent1 {
  final _369Size = 5;
  final _modelFile = '369_14d_300e_300b.tflite';

  late Interpreter _interpreter;

  MachineLearningAgent1() {
    _loadModel();
  }

  void _loadModel() async {
    _interpreter = await Interpreter.fromAsset(_modelFile);
    assert(_interpreter != null);
  }

  int predict(List<List<int>> State369) {
    var input = State369;
    var output = List.filled(_369Size, 0.0).reshape([1, _369Size]);

    _interpreter.run(input, output);

    double max = output[0][0];
    int maxIdx = 0;
    for (int i = 1; i < _369Size; i++) {
      if (max < output[0][i]) {
        maxIdx = i;
        max = output[0][i];
      }
    }

    return maxIdx;
  }
}

