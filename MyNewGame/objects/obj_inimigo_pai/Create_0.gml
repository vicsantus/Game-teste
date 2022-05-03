/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

#region atacando
///@method atacando()
///@args sprite_index image_index_min image_index_max dist_x dist_y
atacando = function(_sprite_index, _image_index_min, _image_index_max, _dist_x, _dist_y){
	mid_velx = 0;
	velx = 0;
	timer_estado = 0;
	if (sprite_index != _sprite_index){
		image_index = 0;
		posso = true;
	}
	sprite_index = _sprite_index;
		
	if(image_index > image_number - 1){
		estado = "parado";
	}
		
	if (image_index >= _image_index_min and dano == noone and image_index <= _image_index_max and posso){
		dano = instance_create_layer(x + _dist_x, y + _dist_y, layer, obj_dano);
		dano.dano = ataque;
		dano.pai = id;
		posso = false;
	}
	if (dano != noone and image_index >= _image_index_max){
		instance_destroy(dano);
		dano = noone;
	}
		
}
#endregion

#region leva dano
///@method leva_dano(sprite_index, image_index_max)
///@args sprite_index image_index_max
leva_dano = function(_sprite_index, _image_index_max){
	mid_velx = 0;
	velx = 0;
	timer_estado = 0;
	delay = room_speed * 1.6;
	if (sprite_index != _sprite_index){
		image_index = 0;
	}
	sprite_index = _sprite_index;
	//Animação só ocorre apos os if posteriores
		
	//Condição para sair do estado
	if (vida_atual > 0){
		if (image_index > image_number - 1){
			estado = "parado";
		}
	}else{
		//Aqui ele não permite animação de hit ir até o final, apenas até a 4° imagem, 
		//dai ele entrar em dead
		if (image_index >= _image_index_max){
			estado = "dead";
		}
	}		
}
#endregion

#region morrendo
///@method morrendo(sprite_morrendo)
///args sprite_morrendo
morrendo = function(_sprite_dead){
	if (sprite_index != _sprite_dead){
			image_index = 0;
		}
		sprite_index = _sprite_dead;
		if (image_index > image_number - 1){
			image_speed = 0;
			image_alpha -= .01;
			
			if (image_alpha <= 0) instance_destroy();
		}
}
#endregion
