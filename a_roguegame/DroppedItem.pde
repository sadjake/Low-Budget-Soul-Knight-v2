class DroppedItem extends GameObject {
  int guns;
  int typeofItem;
  Weapon w;

  DroppedItem(float x, float y, int _rx, int _ry) {
    typeofItem = (int)random(3);
    if (typeofItem == 0) typeofItem = AMMO;
    if (typeofItem == 1) typeofItem = HEALTH;
    if (typeofItem == 2) typeofItem = GUN;
    {
      guns = (int)random(4);
      if (guns == 0) w = new ShotGun();
      if (guns == 1) w = new rapidfire();
      if (guns == 2) w = new SniperRifle();
      if (guns == 3) w = new AutoPistol();
    }
    HEALTHPOINTS = 1;
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    rx = _rx;
    ry = _ry;
    size = 15;
    c  = YELLOW;
  }

  void show() {
    stroke(BLACK);
    noStroke(); //????
    if (typeofItem == HEALTH) {
      fill(RED);
    }
 if (typeofItem == GUN) {
      fill(SKY);
    }
    if (typeofItem == AMMO) {
      fill(DARKBLUE);
    }
    circle(location.x, location.y, size);
  }

  void act() {
  }
}

//class DroppedItem extends GameObject {

//  int type;
//  color c;
//  Weapon w;

//  DroppedItem(float x, float y, int _rx, int _ry) {
//    type = GUN;
//    w = new ShotGun();
//    HEALTHPOINTS = 1;
//    location = new PVector(x, y);
//    velocity = new PVector(0, 0);
//    size = 20;
//    rx= _rx;
//    ry= _ry;
//    c = YELLOW;
//  }

//  void show() {
//    stroke(BLACK);
//    strokeWeight(2);
//    fill(c);
//    circle(location.x, location.y, size);
//  }

//  void act() {
//  }
//}
