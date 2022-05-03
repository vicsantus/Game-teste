/// @description Insert description here
// You can write your code in this editor

var chao = place_meeting(x, y + 1, obj_block);

if (!chao){
	if (vely < max_vely * 3){
		vely += GRAVIDADE * massa * global.vel_mult;
	}
}


switch(estado){
	#region parado
	case "parado":{
		timer_estado++;
		mid_velx = 0;
		if (sprite_index != spr_slime_idle){
			image_index = 0;
		}
		
		sprite_index = spr_slime_idle;
		
		//Condição de troca de estado
		if (position_meeting(mouse_x, mouse_y, self)){
			if (mouse_check_button_pressed(mb_right)){
				estado = "hit";
			}
		}
		if (irandom(timer_estado) > 50){
			estado = choose("walk", "walk", "parado");
			timer_estado = 0;
		}
		scr_ataca_player_melee(obj_player, dist, xscale);
		
		break;
	}
	#endregion
	
	#region walk
	case "walk":{
		timer_estado++;
		if (sprite_index != spr_slime_walk){
			image_index = 0;
			mid_velx = choose(.4, -.4) * global.vel_mult;
		}
		scr_inimigo_direcao();
		
		sprite_index = spr_slime_walk;
		
		if (irandom(timer_estado) > 100){
			estado = choose("walk", "parado", "parado");
			timer_estado = 0;
		}
		scr_ataca_player_melee(obj_player, dist, xscale);
		
		break;
	}
	#endregion
	
	#region ataque
	case "ataque":{
		atacando(spr_slime_ataque, 2, 4, sprite_width/2, -sprite_height/3);
		
		break;
	}
	#endregion
	
	#region hit
	case "hit":{
		leva_dano(spr_slime_hit, 3);
		
		break;
	}
	#endregion
	
	#region dead
	case "dead":{
		morrendo(spr_slime_dead);
		
		break;
	}
	#endregion
	
	//Estado padrão
	default:{
		estado = "parado";
	}
}

