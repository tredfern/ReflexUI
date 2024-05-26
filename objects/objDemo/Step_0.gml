/// @description Insert description here
// You can write your code in this editor

counter++;

if(gameOn) {
	if(random(1) > 0.98) {
		instance_create_depth(random_range(0, room_width), random_range(0, room_height), 0, objCoin);	
	}
	
	if(xp > xpNextLevel) {
		level++;
		xp = 0;
	}
}