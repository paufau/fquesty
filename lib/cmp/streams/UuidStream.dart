class UuidStream {
  static int _id = -1;

  int next(){
    _id++;
    return _id;
  }
}