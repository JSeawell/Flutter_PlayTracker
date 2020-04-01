class NewPlay {

  String formation;
  String strength; 
  String ballPlacement;
  String typeOfPlay;
  String nameOfPlay;
  String kick;
  String specificType;
  String endResult;
  int netYardage;
  String typeOfTurnover;
  int points = 0;


  NewPlay({
    this.formation,
    this.strength, 
    this.ballPlacement,
    this.typeOfPlay,
    this.nameOfPlay,
    this.specificType,
    this.endResult,
    this.netYardage,
    this.typeOfTurnover,
    this.points,
  });

  NewPlay.fromJson(Map<String, dynamic> json)
      : formation = json['formation'],
        strength = json['strength'],
        ballPlacement = json['ballPlacement'],
        typeOfPlay = json['typeOfPlay'],
        nameOfPlay = json['nameOfPlay'],
        specificType = json['specificType'],
        endResult = json['endResult'],
        netYardage = json['netYardage'],
        typeOfTurnover = json['typeOfTurnover'],
        points = json['points'];
  
  Map<String, dynamic> toJson() =>
  {
    'formation': this.formation,
    'strength': this.strength, 
    'ballPlacement': this.ballPlacement,
    'typeOfPlay': this.typeOfPlay,
    'nameOfPlay': this.nameOfPlay,
    'specificType': this.specificType,
    'endResult': this.endResult,
    'netYardage': this.netYardage,
    'typeOfTurnover': this.typeOfTurnover,
    'points': this.points,
  };
}