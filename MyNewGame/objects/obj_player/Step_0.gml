/// @description Insert description here
// You can write your code in this editor

if (instance_exists(obj_transicao)) exit;

//Ini vars
var right, left, jump, attack, dash;
var chao = place_meeting(x, y + 1, obj_block);


if(invencivel and tempo_invencivel > 0){
	tempo_invencivel--;
	image_alpha = max(sin(get_timer()/20000), .2);
} else {
	invencivel = false;
	image_alpha = 1;
}


right = keyboard_check(ord("D"));
left = keyboard_check(ord("A"));
jump = keyboard_check(ord("W"));
attack = keyboard_check_pressed(ord("J"));
dash = keyboard_check_pressed(ord("K"));

//Cod movimentation
velx = (right - left) * max_velx * global.vel_mult;

if (ataque_buff > 0) ataque_buff -= 1.5;




//Iniciando estado
switch(estado)
{
	#region parado
	case "parado": 
	{
		if (chao) count_dash = true;
		mid_velx = 0;
		gravitando();
		//Comportamento do estado
		sprite_index = spr_player_parado1;
		
		//Condição de troca
		if (velx != 0){
			estado = "movendo";
		} else if (attack){
			inicia_ataque(chao);
		} else if (jump or !chao){
			estado = "pulando"
			vely = (-max_vely * jump);
			image_index = 0;
		} else if (dash){
			estado = "dash";
			image_index = 0;
		}
		break;
	}
	#endregion
	
	#region movendo
	case "movendo":
	{
		gravitando();
		sprite_index = spr_player_run;

		
		if (abs(velx) < 0.1){
			estado = "parado";
			velx = 0;
		} else if (attack){
			inicia_ataque(chao);
		} else if (jump or !chao){
			estado = "pulando"
			vely = (-max_vely * jump);
			image_index = 0;
		} else if (dash){
			estado = "dash";
			image_index = 0;
		}
		break;
	}
	#endregion
	
	#region ataque
	case "ataque":{
		velx = 0;
		
		if (combo == 0){
		sprite_index = spr_player_ataque1;
		} else if (combo == 1){
			sprite_index = spr_player_ataque2;
		} else if (combo == 2){
			sprite_index = spr_player_ataque3;
		}
		
		
		//Criando dano
		if (image_index >= 2 and dano == noone and posso){
			dano = instance_create_layer(x + sprite_width/3.5, y - sprite_height/2, layer, obj_dano);
			dano.dano = ataque * ataque_mult;
			dano.pai = id;
			posso = false;
		}
		
		if (attack and combo < 2){
			ataque_buff = room_speed;
		}
		
		//Destruindo dano
		if (ataque_buff and combo < 2 and image_index >= image_number - 1){
			combo++;
			image_index = 0;
			posso = true;
			ataque_mult += .3;
			finaliza_ataque();
			
			//zerar buff
			ataque_buff = 0;
		}
		
		
		if (image_index > image_number - 1){
			estado = "parado";
			combo = 0;
			posso = true;
			ataque_mult = 1;
			if (dano){
				instance_destroy(dano, false);
				dano = noone;
			}
		}
		if (dash){
			combo = 0;
			image_index = 0;
			if (dano){
				instance_destroy(dano, false);
				dano = noone;
			}
			estado = "dash";
		}
		if (vely != 0){
			estado = "pulando"
			image_index = 0;
		}
		break;
	}
	#endregion
	
	#region hit
	case "hit":{
		velx = 0;
		vely += 2;
		timer_estado = 0;
		if (sprite_index != spr_player_hit){
			image_index = 0;
			screenshake(3);
			invencivel = true;
			tempo_invencivel = invencivel_timer;
		}
		sprite_index = spr_player_hit;
		//Animação só ocorre apos os if posteriores
		
		//Condição para sair do estado
		if (vida_atual > 0){
			if (image_index > image_number - 1){
				estado = "parado";
			}
		}else{
			//Aqui ele não permite animação de hit ir até o final, apenas até a 4° imagem, 
			//dai ele entrar em dead
			//if (image_index >= 3){
				estado = "dead";
			//}
		}
		
		
		break;
	}
	#endregion
	
	#region dead
	case "dead":{
		gravitando();
		velx = 0;
		timer_estado = 0;
		if (sprite_index != spr_player_dead){
			image_index = 0;
		}
		sprite_index = spr_player_dead;
		//Animação só ocorre apos os if posteriores
		if (image_index >= image_number -1){
			image_index = image_number -1;
		}
		
		if (instance_exists(obj_game_controller)){
			with(obj_game_controller){
				game_over = true;
			}
		}
		
		if (keyboard_check(vk_enter)) game_restart();
		break;
	}
	#endregion
	
	#region pulando
	case "pulando":{
		//Caindo
		if (vely > 0){
			sprite_index = spr_player_falling;
		} else {
			sprite_index = spr_player_pulo;
			if (image_index >= image_number - 1){
				image_index = image_number - 1
			}
		}
		if (chao){
			estado = "parado";
			velx = 0;
			count_dash = true;
		}
		if (attack){
			inicia_ataque(chao);
		}
		if (dash and count_dash == true and global.powers[1]){
			estado = "dash_aereo";
		}
		//Trocando de sprite se eu tocar na parede
		
		var wall = place_meeting(x + sign(velx), y, obj_block);
		
		if (wall and vely >= 0 and global.powers[0]){
			sprite_index = spr_player_wall;
			vely = 1;
			if (jump){
				vely = -max_vely;
				mid_velx = (max_velx * 2) * sign(velx) * -1;
			}
		} else {
			gravitando();
			mid_velx = lerp(mid_velx, 0, .05);
		}
		
		break;
	}
	#endregion
	
	#region dash
	case "dash":{
		if (sprite_index != spr_player_dash){
			image_index = 0;
			invencivel = true;
			tempo_invencivel = invencivel_timer;
		}
		sprite_index = spr_player_dash;
		mid_velx = image_xscale * dash_vel;
		velx = 0;
		
		if (image_index >= image_number -1 or !chao){
			estado = "parado";
			invencivel = false;
			mid_velx = 0;
		}
		
		break;
	}
	#endregion
	
	#region dash aereo
	case "dash_aereo":{
		if(sprite_index != spr_player_dash_aereo){
			sprite_index = spr_player_dash_aereo;
			
			//Dando tempo pro dash aereo
			timer_dash_aereo = room_speed / 4;
		}
		//Diminuindo o timer
		timer_dash_aereo--;
		
		//Saindo do estado
		if (timer_dash_aereo <= 0){
			estado = "parado";
			velx = 0;
		}
		
		//Velocidade vertical
		vely = 0;
		
		//Velocidade horizontal
		velx = 0;
		mid_velx = dash_vel * image_xscale;
		
		count_dash = false;
		if (chao){
			estado = "parado";
			velx = 0;
		}
		
		break;
	}
	#endregion
	
	#region ataque aereo
	case "ataque aereo":{
		gravitando();
		if (sprite_index != spr_player_ataque_ar1){
			image_index = 0;
		}
		sprite_index = spr_player_ataque_ar1;
		
		//Criando dano
		if (image_index >= 1 and dano == noone and posso){
			dano = instance_create_layer(x + sprite_width/3.5, y - sprite_height/2, layer, obj_dano);
			dano.dano = ataque;
			dano.pai = id;
			posso = false;
			
		}
		
		if (image_index >= image_number -1 and vely != 0){
			estado = "pulando";
			combo = 0;
			posso = true;
			finaliza_ataque();
		} else if (/*image_index >= image_number -1 and */chao) {
			estado = "parado";
			combo = 0;
			posso = true;
			finaliza_ataque();
		}
		
		break;
	}
	#endregion
	
	#region ataque aereo para baixo
	case "ataque aereo down":{
		gravitando();
		mid_velx = 0;
		velx = 0;
		vely += 1.3
		if  (!ataque_down){
			sprite_index = spr_player_ataque_ar_down_ready;
			image_index = 0;
			ataque_down = true;
		}
		if (sprite_index == spr_player_ataque_ar_down_ready){
			if (image_index > .05){
				sprite_index = spr_player_ataque_ar_down_loop;
				image_index = 0;
			}
		}
		if (chao){
			if (sprite_index != spr_player_ataque_ar_down_end){
				sprite_index = spr_player_ataque_ar_down_end;
				image_index = 0;
				//Criando screenshake pra baixo
				screenshake(8, true, 270);
			} else if (image_index >= image_number - .2){
				estado = "parado";
				ataque_down = false;
				finaliza_ataque();
			}
		}
		
		//Criando dano
		if (sprite_index == spr_player_ataque_ar_down_ready and dano == noone and posso){
			dano = instance_create_layer(x + sprite_width/3.5 + velx * 2, y - sprite_height/2, layer, obj_dano);
			dano.dano = ataque + .3;
			dano.pai = id;
			dano.morrer = false;
			posso = false;
		}
		
		/*
		//Destruindo dano
		if (chao){
			estado = "parado";
			image_index = 0;
			show_message("foi");
			finaliza_ataque();
		}*/
		
		
		break;
	}
	#endregion
	
	//Estado padrão
	default:{
		estado = "parado";
	}
	
}
if (keyboard_check(vk_enter)) game_restart();
