draw_self();
draw_set_halign(fa_center);
draw_set_font(Font3);
if (_id<6) draw_text_transformed_color(x,y-52, global.sites[_id], 0.7, 0.7, 0, c_white, c_white, c_white, c_white, 1);
else draw_text_transformed_color(x,y-52, global.sites[_id], 0.7, 0.7, 0, c_grey, c_grey, c_grey, c_grey, 1);
if (global.in_navi && in_message && _id==global.navipoint[global.navi_path[global.navi_path[0]]].building){
	var str;
	if (global.map.tsp_step!=0) str = global.map.task[(global.map.tsp_step>global.map.tsp_list[0])?1:global.map.tsp_step];
	else str = global.map.task[1];
	draw_roundrect_color_ext(mouse_x-5, mouse_y-10, mouse_x+string_width(str)*0.7+5, mouse_y+string_height(str)*0.7+5, 40, 40, c_white, c_white, 0);
	draw_set_font(Font3);
	draw_text_transformed_color(mouse_x+string_width(str)*0.7/2, mouse_y, str, 0.7, 0.7, 0, c_black, c_black, c_black, c_black, 0.8)
}
draw_set_halign(fa_left);