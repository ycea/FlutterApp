
void main() async {
  SequenceGenerator seq = new SequenceGenerator(12, -1);
  await seq.generate(10);
  print(seq.sum);
  switch (seq.getSequenceType()) {
    case SequenceType.positive:
      print("Positive sequence");
    case SequenceType.negative:
      print("Negative sequence");
    default:
      print("Unknown Sequence");
  }
}

enum SequenceType { positive, negative }

class SequenceGenerator {
  int start;
  int step;
  SequenceType sequenceType;
  List<int> sequence = [];

  SequenceGenerator(this.start, this.step)
    : sequenceType = step >= 0 ? SequenceType.positive : SequenceType.negative;

  Future<void> generate(int length) async {
    sequence.clear();
    int lastElement = start;
    await addElement(sequence, lastElement);
    lastElement += step;
    for (int i = 0; i < length; i++) {}
  }

  Future<void> addElement<T>(List<T> collection, T element) async {
    await Future.delayed(Duration(milliseconds: 500));
    collection.add(element);
  }

  SequenceType getSequenceType() {
    return sequenceType;
  }
}

extension SequenceExtensionX on SequenceGenerator {
  int get sum => sequence.reduce((a, b) => a + b);
}
