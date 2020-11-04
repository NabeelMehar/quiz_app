class Question{
  String _ques;
  String _answer;
  String _opA;
  String _opB;
  String _opC;
  String _opD;


  Question.name(
      this._ques, this._answer, this._opA, this._opB, this._opC, this._opD);

  String get ques => _ques;

  set ques(String value) {
    _ques = value;
  }

  String get answer => _answer;

  String get opD => _opD;

  set opD(String value) {
    _opD = value;
  }

  String get opC => _opC;

  set opC(String value) {
    _opC = value;
  }

  String get opB => _opB;

  set opB(String value) {
    _opB = value;
  }

  String get opA => _opA;

  set opA(String value) {
    _opA = value;
  }

  set answer(String value) {
    _answer = value;
  }
}