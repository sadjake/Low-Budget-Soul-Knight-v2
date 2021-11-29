class Turret extends Enemy {

  int shotTimer, threshold;
  float x;

  Turret(int x, int y) {
    super(400, 25, x, y);
  }

  void show() {
    fill(RED);
    circle(location.x, location.y, 100);
    fill(0);
    textSize(20);
    text(HEALTHPOINTS, location.x, location.y);
  }

  void act() {
    super.act();
    shotTimer++;
    if (shotTimer >= threshold) {
      PVector aimVector = new PVector (myHero.location.x - location.x, myHero.location.y - location.y);
      aimVector.setMag(1);
      myObjects.add(new TurretBullet(aimVector, BLACK, 10, 20, location.x, location.y));
      shotTimer = 0;
    }
  }
}
