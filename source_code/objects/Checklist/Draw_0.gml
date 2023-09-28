/// @description Insert description here
// You can write your code in this editor
draw_self();
draw_rectangle_color(x, y, x+w, y+h+5, c_black, c_black, c_black, c_black, 1);
if (state == 1 && len && surface_exists(surf)){
	draw_surface_part(surf, 0, 0, w, h-7, x+15, y+10);
}