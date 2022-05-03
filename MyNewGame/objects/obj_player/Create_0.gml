/// @description Insert description here
// You can write your code in this editor
event_inherited()

randomize();


var cam = instance_create_layer(x, y, layer, obj_camera);
cam.alvo = id;

vida_max = 10;
vida_atual = vida_max;

max_velx = 4;
max_vely = 6;

dash_vel = 6;

timer_dash_aereo = 0;
count_dash = true;

combo = 0;
dano = noone;
ataque = 1;
posso = true;
ataque_mult = 1;
ataque_buff = room_speed;

ataque_down = false;

//Controle dos powers [wall slide, airdash]
global.powers = [false, false];

invencivel_timer = room_speed * 3;
tempo_invencivel = invencivel_timer;

//Metodo iniciar ataque
inicia_ataque = function(chao){
	if (chao){
		estado = "ataque";
		velx = 0;
		image_index = 0;
	} else {
		if (keyboard_check(ord("S"))){
			estado = "ataque aereo down";
			mid_velx = 0;
			velx = 0;
			vely = 0;
		} else {
			estado = "ataque aereo";
			image_index = 0;
		}
	}
}

finaliza_ataque = function(){
	posso = true;
	if (dano){
		instance_destroy(dano, false);
		dano = noone;
	}
}

//Aplicando gravidade
gravitando = function(){
	//Gravit
	var chao = place_meeting(x, y + 1, obj_block);
	if (!chao){
		if (vely < max_vely * 3){
			vely += GRAVIDADE * massa * global.vel_mult;
		}
	}
}
