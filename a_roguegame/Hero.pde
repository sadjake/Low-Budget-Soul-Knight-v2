class Hero extends GameObject {
  float speed;
  int immunityTimer;
  Weapon myWeapon;
  boolean immunity;
  AnimatedGIF currentAction;
  int threshold;

  Hero() {
    super();
    speed = 9;
    rx = 1;
    ry = 1;
    size = 25;
    HEALTHPOINTS = 100;
    immunity = true;
    immunityTimer = 0;
    myWeapon = new rapidfire();
    currentAction = manDown;
  }

  void show() {
    //fill(SKY);
    //strokeWeight(3);
    //stroke(BLACK);
    //circle(location.x, location.y, size);
    //fill(BLACK);
    //textSize(12);
    //text(HEALTHPOINTS, location.x, location.y);
    //currentAction.show(location.x, location.y, size/1.5, size);

    if (immunity == true) {
      //no
      //fill(WHITE);
      //strokeWeight(3);
      //stroke(BLACK);
      //circle(location.x, location.y, size);
      //outline
      strokeWeight(1);
      stroke(BLACK);
      fill(WHITE);
      circle(location.x, location.y, size + 30);

      textSize(30);
      text(HEALTHPOINTS, location.x, location.y);
      //main body
      //fill(SKY);
      //strokeWeight(3);
      //stroke(BLACK);
      //circle(location.x, location.y, size);
    } else {
      //fill(SKY);
      //strokeWeight(3);
      //stroke(BLACK);
      //circle(location.x, location.y, size);
      fill(BLACK);
      textSize(30);
      text(HEALTHPOINTS, location.x, location.y);
    }
    currentAction.show(location.x, location.y, size, size);
  }

  void act() {
    super.act();
    //move
    if (upkey) velocity.y = -speed;
    if (leftkey) velocity.x = -speed;
    if (downkey) velocity.y = speed;
    if (rightkey) velocity.x = speed;

    if (velocity.mag() > speed)
      velocity.setMag(speed);

    if (abs(velocity.y)>abs(velocity.x)) {
      if (velocity.y>=0)
        currentAction = manDown;
      else currentAction = manUp;
    } else {
      if (velocity.x>0)
        currentAction = manRight;
      else currentAction = manLeft;
    }

    if (!leftkey && !rightkey) velocity.x = velocity.x * 0.75;
    if (!downkey && !upkey) velocity.y = velocity.y * 0.75;

    if (northRoom != WHITE && location.y ==height*0.1&& location.x >= width/2-50&&location.x <= width/2+50) {
      ry--;
      location = new PVector(width/2, height*0.9-10);
    } else if (eastRoom != WHITE && location.x ==width*0.9 && location.y >= height/2-50&& location.y <= height/2+50) {
      rx++;
      location = new PVector(width*0.1+10, height/2 );
    } else if (southRoom != WHITE && location.y ==height*0.9&& location.x >= width/2-50 &&location.x <= width/2+50) {
      ry++;
      location = new PVector(width/2, height*0.1+10);
    } else if (westRoom != WHITE && location.x ==width*0.1&& location.y >= height/2-50&& location.y <= height/2+50) {
      rx--;
      location = new PVector(width*0.9-10, height/2);
    }

    myWeapon.update();
    if (spacekey) {
      print("is this even working lol");
      myWeapon.shoot();
    }

    //immunity
    if (immunity == true) {
      immunityTimer++;
    }
    if (immunityTimer > 100) {
      immunity = false;
      immunityTimer = 0;
    }
    print("is this even working lol");


    //        if (immunity == false) {
    //          myHero.HEALTHPOINTS--;
    //          immunityTimer = 0;
    //          immunity = true;
    //        }
    //      }
    //      i++;
    //    }
    //    if (myHero.HEALTHPOINTS == 0) mode = GAMEOVER;
    //  }
    //}

    //lose hp
    int i = 0;
    while (i < myObjects.size()) {
      GameObject obj = myObjects.get(i);
      if (obj instanceof Enemy && isCollidingWith(obj) && inRoomWith(obj)) {
        if (dist(myHero.location.x, myHero.location.y, obj.location.x, obj.location.y) <= size/2 + obj.size/2) {
          if (immunity == false) {
            myHero.HEALTHPOINTS--;
            //immunityTimer = 0;
            explode(200, 100, BLACK);
            immunity = true;
          }
        }
      }
          if (obj instanceof TurretBullet && isCollidingWith(obj) && immunityTimer >= threshold) {
            HEALTHPOINTS -= 1;
            obj.HEALTHPOINTS = 0;
            //((EnemyBullet) obj).Particles();
          }
          if (obj instanceof DroppedItem && isCollidingWith(obj)) {
            DroppedItem item = (DroppedItem)obj;
            if (item.typeofItem == GUN) {
              myWeapon = item.w;
              item.HEALTHPOINTS = 0;
            }
            if (item.typeofItem == AMMO) {
              myWeapon = item.w;
              item.HEALTHPOINTS = 0;
            }
            if (item.typeofItem == HEALTH) {
              myHero.HEALTHPOINTS = myHero.HEALTHPOINTS + 1;
              item.HEALTHPOINTS = 0;
              if (HEALTHPOINTS > 100) {
                HEALTHPOINTS = 100;
              }
            }
          
        }

        i++;
        //}
        if (myHero.HEALTHPOINTS == 0) mode = GAMEOVER;
      }
    }
  }

  //lose lives
  //int i = 0;
  //  while (i < myObjects.size()) {
  //    GameObject obj = myObjects.get(i);
  //    if (obj instanceof Enemy && isCollidingWith(obj)){//|| obj instanceof Bullet && obj.Enemybullet) {
  //      if (dist(myHero.location.x, myHero.location.y, obj.location.x, obj.location.y) <= size/2 + obj.size/2) {
  //        if (immunity == false) {
  //          myHero.hp--;
  //          explode(500,110,white);
  //          immunity = true;
  //          }
  //       }
  //    }
  //    if (obj instanceof DroppedItem && isCollidingWith(obj)){
  //      DroppedItem item = (DroppedItem) obj;
  //      if(item.type == GUN){
  //        myWeapon = item.w;
  //        item.hp = 0;
  //    }
  //      if(item.type == AMMO){
  //        //myWeapon = item.w;
  //        //item.hp = 0;
  //      }
  //      if(item.type == HEALTH){
  //        myHero.hp = myHero.hp + 1;
  //        item.hp = 0;
  //      }
  //    }
  //   i++;
  //  if (myHero.hp == 0) mode = gameover;
  //  }
  //}
  //}


  //if (immunity >= immunityTimer) {
  //  stroke(255);
  //  textSize(20);
  //  text("IMMUNITY: ON", 400, 125);
  //}


  //immunity
  //if (immunity == true){
  //  immunitytimer++;
  //    }
  //    if (immunitytimer > 100){
  //      immunity = false;
  //      immunitytimer = 0;
  //    }

  //  //
  //  int i = 0;
  //    while (i < myObjects.size()) {
  //      GameObject obj = myObjects.get(i);
  //      if (obj instanceof Enemy && isCollidingWith(obj) && inRoomWith(obj)){
  //          if (immunity == false) {
  //
  //      }
  //      i++;
  //    }
  //    if (myHero.hp == 0) mode = gameover;
  //  }
  //}
