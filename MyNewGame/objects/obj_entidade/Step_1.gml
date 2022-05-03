/// @description Insert description here
// You can write your code in this editor

//Direction Loocking
if (velx != 0) xscale = sign(velx);
image_xscale = xscale;

if (keyboard_check_pressed(ord("P")) and mostra_estado == false) {
	mostra_estado = true;
} else if (keyboard_check_pressed(ord("P")) and mostra_estado == true) {
	mostra_estado = false;
}

if (position_meeting(mouse_x, mouse_y, id)) {
	if (mouse_check_button_released(mb_left)){
		mostra_estado = !mostra_estado;
	}
}


image_speed = (img_spd / room_speed) * global.vel_mult;

