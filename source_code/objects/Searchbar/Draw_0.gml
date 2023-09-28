draw_self();
draw_rectangle_color(x, y, x+w, y+h, c_black, c_black, c_black, c_black, 1);
draw_rectangle_color(x+60, y+230, x+w-60, y+h-130, c_black, c_black, c_black, c_black, 1);
draw_set_font(Font3);
draw_text_transformed_color(x+400, y+25, "日程查询", 1, 1, 0, c_black, c_black, c_black, c_black, 1);
if (surface_exists(surf)){
	draw_surface_part_ext(surf, 0, 0/*delta_h*/, w-130, h-380, x+70, y+240, 1, 1, noone, 1);
}