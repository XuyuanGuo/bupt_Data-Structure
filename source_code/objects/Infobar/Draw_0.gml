draw_self();
draw_rectangle_color(x, y, x+w, y+h, c_black, c_black, c_black, c_black, 1);
draw_roundrect_color_ext(x+60, y+120, x+w-60, y+h-150, 50, 50, c_black, c_black, 1);
draw_set_font(Font3);
draw_text_transformed_color(x+350, y+25, "提醒", 1, 1, 0, c_black, c_black, c_black, c_black, 1);
if (state == 1 && surface_exists(surf)){
	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	for (var i = 0, j=7; i<len; i++){
		if (font[i]){
			draw_set_font(Font1);
			draw_text_ext_transformed_color(10, j, str[i], 70, 630, 0.8, 0.8, 0, c_black, c_black, c_black, c_black, 1);
		}else{
			draw_set_font(Font2);
			draw_text_ext_transformed_color(60, j, str[i], 70, 630, 0.8, 0.8, 0, c_black, c_black, c_black, c_black, 1);
		}
		j+= string_height_ext(str[i], 70, 610) + 10;
	}
	surface_reset_target();
	draw_surface_part_ext(surf, 0, delta_h, w-130, h-290, x+70, y+130, 1, 1, c_black, 1);
}