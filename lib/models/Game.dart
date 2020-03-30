
class Game {

  DateTime date;
  String opponent;
  String finalScore;
  List<dynamic> allPlays = List(100);

  void setDate(DateTime date){
    this.date = date;
  }

  Game({this.date, this.opponent, this.finalScore, this.allPlays});
}