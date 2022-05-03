/// @description Insert description here
// You can write your code in this editor


//Ja mudei de room
if (mudei){
	alpha -= .02;
} else {//Ainda não mudei de room
	alpha += .02;
}

if (alpha >= 1){
	
	room_goto(destino);
	
	//Controlando o destino do player
	obj_player.x = destino_x;
	obj_player.y = destino_y;
	
}

if (mudei and alpha <= 0){
	instance_destroy();
}
