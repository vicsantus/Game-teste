/// @description Insert description here
// You can write your code in this editor

//Passando o mid velx para o velx enquanto ele for menor que o limite
if (abs(velx) <= max_velx){
	velx += mid_velx;
} else {
	velx = 0;
}



var _velx = sign(velx);
var _vely = sign(vely);

repeat(abs(velx)){
	if (place_meeting(x + _velx, y, obj_block))
	{
		velx = 0;
		break;
	}
	x += _velx;
}

repeat(abs(vely)){
	if (place_meeting(x, y + _vely, obj_block))
	{
		vely = 0;
		break;
	}
	y += _vely;
}

