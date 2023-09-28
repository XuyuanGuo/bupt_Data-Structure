if (state == 2){
	draw_rectangle_color(x+1, y+h-10, x+w, y+h+min(len, 5)*h, c_black, c_black, c_black, c_black, 1);
	draw_rectangle_color(x+1, y+h-10, x+w, y+h+min(len, 5)*h, c_white, c_white, c_white, c_white, 0);
	if (surface_exists(surf)) draw_surface_part(surf, 0, 0, w, h*min(len,5)-3, x+(tp==2)*8, y+h+3);
}
draw_self();
draw_set_font(Font1);
if (tp != 1) draw_text_transformed_color(x, y+(h-42)*wordsize/2, str, wordsize, wordsize, 0, c_black, c_black, c_black, c_black, 1);
draw_sprite_ext(spr_chooselist, 0, x+min(4*w/5, w-30), y+h/4+h/16, h/128, h/128, 0, 0, 1);
if (tp != 1) draw_roundrect_color_ext(x, y, x+w, y+h, 10, 10, c_black, c_black, 1);