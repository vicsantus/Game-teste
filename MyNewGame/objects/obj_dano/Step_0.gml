/// @description Insert description here
// You can write your code in this editor
var outro;// = instance_place(x, y, obj_entidade);
//var outro2 = instance_place(x, y, obj_entidade);
//var pai_outro = object_get_parent(outro2.object_index);
//var meu_pai = object_get_parent(pai.object_index);
var outro_lista = ds_list_create();
var quantidade = instance_place_list(x, y, obj_entidade, outro_lista, 0);

/*if (pai_outro == meu_pai and quantidade == 1){
	quantidade = true;
}*/

for (var i = 0; i < quantidade; i++){
	//Checando atual
	var atual = outro_lista[| i];
	
	//Verificando invencibilidade
	if (atual.invencivel){
		continue;
	}
	//Checando se a colisão não é com o filho do meu pai

	if (object_get_parent(atual.object_index) != object_get_parent(pai.object_index)){
		
		//Isso somente ira rodar se eu puder dar dano no outro
		//Checando se eu realmente posso dar dano
		
		//Checar se atual esta na lista
		var pos = ds_list_find_index(aplicar_dano, atual);
		if (pos == -1){
			//Atual ainda nao esta na lista de dano
			//Add atual a lista
			ds_list_add(aplicar_dano, atual);
			
		}
	}
}

//Aplicando dano
var tam = ds_list_size(aplicar_dano);
//var tam = ds_list_find_index(aplicar_dano, atual);
for (var i = 0; i < tam; i++){
	//if (aplicar_dano[| i].id != pai.id){
		outro = aplicar_dano[| i].id;
		if (outro.vida_atual > 0){
			if (outro.delay <= 0){
				outro.estado = "hit";
				outro.image_index = 0;
			}
			outro.vida_atual -= dano;
			
			//Preciso checar se estou acertando o inimigo
			//Checando se sou filho do pai
			if (object_get_parent(outro.object_index) == obj_inimigo_pai){
				screenshake(2);
			}
		} else if (outro.vida_atual <= 0){
			//show_message("ok");
			outro.estado = "dead";
		}
	//}
}
//}

//Limpar lista
ds_list_destroy(aplicar_dano);
ds_list_destroy(outro_lista);

if (morrer){
	instance_destroy();
} else {
	y = pai.y - pai.sprite_height/4;
	if (quantidade > 1){
		instance_destroy();
	} else if (quantidade == 1){
		aplicar_dano = ds_list_create();
	}
}
/*/Caso tocando em alguem
if (outro){
	show_debug_message("AA" + string(id));
	//Caso não tocando no meu pai
	if (outro.id != pai){
		show_debug_message("ZZ" + string(id));
		if (outro.vida_atual > 0 and pai_outro != meu_pai){
			outro.estado = "hit";
			outro.image_index = 0;
			outro.vida_atual -= dano;
			instance_destroy();
		}
	}
}

