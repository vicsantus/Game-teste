// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


function scr_inimigo_direcao(){
	if (place_meeting(x + mid_velx, y, obj_block)){
		mid_velx *= -1;
	}

}