class Clock {

  PVector position;
  float radius;

  Clock(PVector _position, float _radius) {
    position = _position.copy();
    radius = _radius;
  }

  void display0() {
    // drawing settings
    stroke(255);
    strokeWeight(12);
    //fill(255);

    textureMode(NORMAL); 
    beginShape(); 
    texture(clockbg); 
    final int num_points = 200;
    for (int i = 0; i < num_points; i++) { 
      float stepFac = TWO_PI * (float(i) / num_points); 
      vertex(position.x + radius * 0.5 * cos(stepFac), position.y + radius * 0.5 * sin(stepFac), (cos(stepFac) + 1) / 2, (sin(stepFac) + 1) / 2);
    } 
    endShape(CLOSE); 

    // get the time
    float s = second();
    float m = minute() + s / 60;
    float h = hour() % 12 + m / 60;

    //    println(s);

    // play the sfx each minute
    if (s == 0 && !sfx.isPlaying()) {
      println("okay, play!");
      println(millis());
      sfx.play();
    }

    // for h, m, s, get the corresponding angle of rotation
    float h_angle = - HALF_PI + h * TWO_PI / 12;//h * TWO_PI / 12;
    float m_angle = - HALF_PI + m * TWO_PI / 60;//m * TWO_PI / 60 + HALF_PI;
    float s_angle = - HALF_PI + s * TWO_PI / 60;//s * TWO_PI / 60 - HALF_PI;

    //println(h_angle + " " + m_angle + " " + s_angle);

    // the size of each... line?
    float s_size = radius * 0.5 * 0.725;
    float m_size = s_size * 0.8;
    float h_size = m_size * 0.65;

    // and get the position of the point at the end of the line ( ish )
    PVector h_point = new PVector(h_size * cos(h_angle) + position.x, h_size * sin(h_angle) + position.y);
    PVector m_point = new PVector(m_size * cos(m_angle) + position.x, m_size * sin(m_angle) + position.y);
    PVector s_point = new PVector(s_size * cos(s_angle) + position.x, s_size * sin(s_angle) + position.y);

    textAlign(CENTER, CENTER);

    // draw these points so you don't get lost
    fill(0);
    noStroke();
    for (int i = 0; i < 60; i++) {
      // if it's divisible by 5, then it's an hour. draw a bigger ellipse.
      if (i % 5 == 0) {
        // magic
        int new_i = 12;
        if (i > 0) {
          new_i = i / 5;
        }
        textSize(18);
        stroke(0);
        fill(0);
        for (int x = -1; x <= 1; x++) {
          text(new_i, x + position.x + radius * 0.5 * 0.8 * cos(i * TWO_PI / 60 - HALF_PI), position.y + radius * 0.5 * 0.8 * sin(i * TWO_PI / 60 - HALF_PI));
          text(new_i, position.x + radius * 0.5 * 0.8 * cos(i * TWO_PI / 60 - HALF_PI), x + position.y + radius * 0.5 * 0.8 * sin(i * TWO_PI / 60 - HALF_PI));
        }
        fill(255);
        text(new_i, position.x + radius * 0.5 * 0.8 * cos(i * TWO_PI / 60 - HALF_PI), position.y + radius * 0.5 * 0.8 * sin(i * TWO_PI / 60 - HALF_PI));
        continue;
      }
      stroke(0);
      strokeWeight(1);
      ellipse(position.x + radius * 0.5 * 0.9 * cos(i * TWO_PI / 60 - HALF_PI), position.y + radius * 0.5 * 0.9 * sin(i * TWO_PI / 60 - HALF_PI), 4, 4);
    }

    // and the lines for s, m, h ( smh )
    strokeWeight(5);
    stroke(0);
    line(position.x, position.y, h_point.x, h_point.y);
    strokeWeight(3);
    stroke(0);    
    line(position.x, position.y, m_point.x, m_point.y);
    strokeWeight(2);
    stroke(255, 0, 0);
    line(position.x, position.y, s_point.x, s_point.y);
  }

  void display1() {
    // get the time
    float s = second();
    float m = minute() + s / 60;
    float h = hour() % 12 + m / 60;

    // for h, m, s, get the corresponding angle of rotation
    float h_angle = h * TWO_PI / 12;
    float m_angle = m * TWO_PI / 60;
    float s_angle = s * TWO_PI / 60;

    //println(h_angle + " " + m_angle + " " + s_angle);

    textAlign(CENTER, CENTER);

    for (int i = 0; i < 60; i++) {
      // if it's divisible by 5, then it's an hour. draw a bigger ellipse.
      if (i % 5 == 0) {
        // magic
        int new_i = 12;
        if (i > 0) {
          new_i = i / 5;
        }
        textSize(18);
        fill(random(255), random(255), random(255));
        text(new_i, position.x + radius * 0.5 * 0.75 * cos(i * TWO_PI / 60 - HALF_PI), position.y + radius * 0.5 * 0.75 * sin(i * TWO_PI / 60 - HALF_PI));
      }
      noFill();
      stroke(50, 100, 255);
      ellipse(position.x + radius * 0.5 * 0.9 * cos(i * TWO_PI / 60 - HALF_PI), position.y + radius * 0.5 * 0.9 * sin(i * TWO_PI / 60 - HALF_PI), 4, 4);
    }

    noFill();

    strokeWeight(9);
    stroke(255, 100, 50);
    arc(position.x, position.y, radius, radius, - HALF_PI, h_angle - HALF_PI);
    strokeWeight(7);
    stroke(100, 255, 50);
    arc(position.x, position.y, radius * 0.95, radius * 0.95, - HALF_PI, m_angle - HALF_PI);
    strokeWeight(6);
    stroke(50, 100, 255);
    arc(position.x, position.y, radius * 0.9, radius * 0.9, - HALF_PI, s_angle - HALF_PI);
  }
}
