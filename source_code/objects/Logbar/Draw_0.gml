draw_self();
draw_rectangle_color(x, y, x+w, y+h, c_black, c_black, c_black, c_black, 1);
draw_rectangle_color(x+60, y+200, x+w-60, y+h-30, c_black, c_black, c_black, c_black, 1);
draw_set_font(Font3);
draw_text_transformed_color(x+650, y+25,"日志", 1, 1, 0, c_black, c_black, c_black, c_black, 1);
if (surface_exists(surf)){
	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	memset(hourstamp, 24, 0);
	//i为文本段数，j为文本总高度，当窗口滑动距离在j附近时，将部分文本绘制到窗口上
	for (var i = 0, j = 0; i<len; i++){
		if (string_copy(str[i], 3, 3)==":00" && string_length(str[i])==7){
			//设置时间戳
			if (hourstamp[real(string_copy(str[i], 1, 2))]!=0) continue;
			hourstamp[real(string_copy(str[i], 1, 2))] = j;
			//绘制时间段
			draw_set_font(Font3);
			//根据滚动条位置绘制部分文本
			if (j>delta_h-100 && j<delta_h+600)
			draw_text_ext_transformed_color(0, j-delta_h, str[i], 60, 1280, 0.8, 0.8, 0, c_black, c_black, c_black, c_black, 1);
		}else{
			//绘制文本内容
			draw_set_font(Font2);
			if (j>delta_h-100 && j<delta_h+600)
			draw_text_ext_transformed_color(0, j-delta_h, "    "+str[i], 60, 1200/0.7, 0.7, 0.7, 0, c_black, c_black, c_black, c_black, 1);
		}
		j+=string_height_ext(str[i], 60, 1280)*0.7+22;
	}
	h_limit = j-560;
	surface_reset_target();
	draw_surface_part_ext(surf, 0, /*delta_h*/0, w-130, h-230, x+70, y+200, 1, 1, c_black, 1);
}