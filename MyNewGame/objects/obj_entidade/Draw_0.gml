/// @description Insert description here
// You can write your code in this editor


draw_self();


if(mostra_estado){
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_text(x, y - sprite_height * 1.2, estado);
draw_set_valign(-1);
draw_set_valign(-1);
}