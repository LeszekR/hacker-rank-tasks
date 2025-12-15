import 'dart:math';

void testInspectAllSamples() {
  List<String> genes = ['a', 'b', 'c', 'aa', 'd', 'b'];
  List<int> benefits = [1, 2, 3, 4, 5, 6];
  List<_GeneSample> samples = [_GeneSample(1, 5, 'caaab'), _GeneSample(0, 4, 'xyz'), _GeneSample(2, 4, 'bcdybc')];
  _Result result = _inspectAllSamples(samples, genes, benefits);
  print('${result.lowest} ${result.highest}');
}

_Result _inspectAllSamples(List<_GeneSample> samples, List<String> genes, List<int> benefits) {
  _Result result = _Result();
  int next;
  List<_GeneBenefit> geneBenefits = List<_GeneBenefit>.empty(growable: true);

  for (int i = 0; i < genes.length; i++) {
    geneBenefits.add(_GeneBenefit(genes[i], benefits[i]));
  }

  for (_GeneSample sample in samples) {
    next = _inspectSample(sample, geneBenefits);
    result.lowest = min(result.lowest, next);
    result.highest = max(result.highest, next);
  }
  return result;
}

int _inspectSample(_GeneSample sample, List<_GeneBenefit> geneBenefits) {
  String gene;
  int nMatches;
  RegExp regEx;
  int totalBenefit = 0;

  List<_GeneBenefit> pickedBenefits = geneBenefits.sublist(sample.start, sample.end);

  for (_GeneBenefit geneBenefit in pickedBenefits) {
    regEx = RegExp(geneBenefit.gene);
    nMatches = regEx.allMatches(sample.strand).length;
    totalBenefit += nMatches * geneBenefit.benefit;
  }
  return totalBenefit;
}

class _Result {
  int lowest = 100000000;
  int highest = 0;
}

class _GeneSample {
  final int start;
  final int end;
  final String strand;

  const _GeneSample(this.start, this.end, this.strand);
}

class _GeneBenefit {
  final String gene;
  final int benefit;

  const _GeneBenefit(this.gene, this.benefit);
}
