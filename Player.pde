int north, south, west, east;											/*Direcciones del jugador*/

class Player {
	int x, y, z, pS;													/*Position, pS = player spriteSize*/
	int spriteCount = 0;												/*Sprite frame visualization control value*/
	PImage sprite = new PImage();										/*Sprite complete Image*/
	ArrayList<PImage> sp = new ArrayList<PImage>();						/*Sprite div of `PImage sprite` in an arrayList*/
	void init(int k) {													/*Initialization of the object, arg "k" = (key of keyListener)*/
	sprite = loadImage("Sprites/Sprite "+(k-(int)'0')+".png");
	sp.clear();
	for (int j = 512; j<767; j+=64)										/*Sprite movement section*/
		for (int i = 0; i<575; i+=64)
			sp.add(sprite.get(i, j, 64, 64));

		while (mapT.map.getFloat((x+mapT.mapSize/2)+"-"+(z+mapT.mapSize/2))==1) {
			x = (int)random(15-mapT.mapSize/2, mapT.mapSize/2-15);
			z = (int)random(15-mapT.mapSize/2, mapT.mapSize/2-15);
		}
	}
	void paint() {
		spriteCount++;
		if (spriteCount == 8)
			spriteCount=0;
		pushMatrix();
		imageMode(CENTER);
		rotateX(PI/2);
		translate(x*pS, z*pS);
		if      (south - north == -1) 
			image(sp.get( 0+spriteCount), 0, 0, pS, pS);
		else if (east  - west  == -1) 
			image(sp.get( 9+spriteCount), 0, 0, pS, pS);
		else if (east  - west  ==  1) 
			image(sp.get(27+spriteCount), 0, 0, pS, pS);
		else if (south - north ==  1) 
			image(sp.get(18+spriteCount), 0, 0, pS, pS);
		else
			image(sp.get(18), 0, 0, pS, pS);
		popMatrix();
	}

	/*<--Start Test-->*/
	void move(Terrain m) {
		int tx = x, tz = z;												/*Temporal values of position*/
		tx += x<m.mapSize/2 && x>-m.mapSize/2?east  - west:0;
		tz += z<m.mapSize/2 && z>-m.mapSize/2?south - north:0;
		mapC.fov = keyCode == DOWN? 2000: keyCode == UP? 1000: mapC.fov;
		/**/															/*Rewrite position values just if is permitted*/
		if (m.map.getFloat((tx+m.mapSize/2)+"-"+(tz+m.mapSize/2))!=1) {
			x = tx; 
			z = tz;
		}
		/*if (m.map.getFloat((tx+m.mapSize/2)+"-"+(tz+m.mapSize/2))==10) {
			println("dungeon");
		}*/
	}
	void move(TerrainDungeon m) {
		int tx = x, tz = z;												/*Temporal values of position*/
		tx += x<m.mapSize/2 && x>-m.mapSize/2?east  - west:0;
		tz += z<m.mapSize/2 && z>-m.mapSize/2?south - north:0;
		mapC.fov = keyCode == DOWN? 2000: keyCode == UP? 1000: mapC.fov;
		/**/															/*Rewrite position values just if is permitted*/
		if (!m.map.isNull((tx+m.mapSize/2)+"-"+(tz+m.mapSize/2))) {
			x = tx; 
			z = tz;
		}
		/*if (m.map.getFloat((tx+m.mapSize/2)+"-"+(tz+m.mapSize/2))==10) {
			println("dungeon");
		}*/
	}
	/*<--End Test-->*/

	/**/																/*k = keyListener, spd if 1 "true" direction: stop*/
	void setDirection(int k, int spd) {									
		if      (k == 'W')
			north = spd;
		else if (k == 'S')
			south = spd;
		else if (k == 'A')
			west  = spd;
		else if (k == 'D')
			east  = spd;
	}
	Player() {
		this.x = (int)random(15-mapT.mapSize/2, mapT.mapSize/2-15);
		this.y = 0;
		this.z = (int)random(15-mapT.mapSize/2, mapT.mapSize/2-15);
		this.pS = mapT.mapSquareSize;
		init((int)'1');													/*Player Initialization, arg = key*/
	}
}