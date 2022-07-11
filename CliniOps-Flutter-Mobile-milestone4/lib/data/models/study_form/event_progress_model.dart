class EventProgressModel {
  int referenceMin;
  int referenceMax;

  EventProgressModel({
    required this.referenceMin,
    required this.referenceMax,
  });

  int get difference => referenceMax - referenceMin;
}
