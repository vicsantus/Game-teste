/// @description Insert description here
// You can write your code in this editor
event_inherited()
if (mostra_estado){
	draw_text(x, y - 60, vida_atual);
	
	//Linha de distancia entre inimigo e heroi
	draw_line(x, y - sprite_height/3, x + ((dist - 15) * xscale), y - sprite_height/3);
	draw_text(x, y - 70, delay);
}




