/// @description Insert description here
// You can write your code in this editor

//Checar colisão com o player
var player = place_meeting(x, y, obj_player);

var espaco = keyboard_check(vk_space);

if (player and espaco){
	//Codigo de transição de tela
	var tran = instance_create_layer(0, 0, layer, obj_transicao);
	tran.destino = destino;
	tran.destino_x = destino_x;
	tran.destino_y = destino_y;
	//show_message("Foi");
	
}

