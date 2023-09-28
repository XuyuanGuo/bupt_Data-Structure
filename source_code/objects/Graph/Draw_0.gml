/// @description Insert description here
// You can write your code in this editor
draw_rectangle_color(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, c_white, c_white, c_white, c_white, 0);
draw_set_font(Font1);
for (var i=0; i<c_count;i++){
	draw_text_ext_transformed_color(330+grid_w*i-delta_w, 220-delta_h, global.weekdays[i], 0, 200, 0.9, 0.9, 0, c_black, c_black, c_black, c_black, 1);
	draw_line_width_color(230+grid_w*i-delta_w, 200-delta_h, 230+grid_w*i-delta_w, WINDOW_HEIGHT, 2, c_black, c_black);
}

if (global.access == 0){
	for (var i=0, s=0; i<c_count; i++){
		for (var j=1; j<r_count; j++){
			s+= grid_h[j];
			var c_id=global.courseTable[week-1][i][j-1];
			var a_id=global.activityTable[week-1][i][j-1];
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_font(Font3);
			if (c_id){
				var c = read_course_info(c_id);
				var str = c._name;
				var p = 10;
				while (p<string_length(str)){
					str = string_insert("\n", str, p);
					p+=11;
				}
				if (a_id){
					var p = 8;
					var str2;
					if (a_id<temp_N) str2=read_activity_info(a_id)._name;
					else str2 = "临时事务";
					while (p<string_length(str2)){
						str2 = string_insert("\n", str2, p);
						p+=9;
					}
					draw_rectangle_width(390+grid_w*i-grid_w/2-delta_w+2, 290+s-grid_h[j]-delta_h+2, 390+grid_w*i+grid_w/2-delta_w-2, 290+s-delta_h-2, c_grey, 10);
					draw_text_ext_transformed_color(390+grid_w*i-delta_w, 340+s-grid_h[j]/2-delta_h, str2, 50, 1000, 0.8, 0.8, 0, c_black, c_black, c_black, c_black, 1);
					draw_line_width_color(390+grid_w*i-grid_w/2-delta_w+2, 410+s-grid_h[j]-delta_h+2, 390+grid_w*i+grid_w/2-delta_w+2, 410+s-grid_h[j]-delta_h+2, 2, c_grey, c_grey);
					draw_text_ext_transformed_color(390+grid_w*i-delta_w, 250+s-grid_h[j]/2-delta_h, str, 50, 1000, 0.8, 0.8, 0, c_black, c_black, c_black, c_black, 1);
				}else{
					draw_rectangle_width(390+grid_w*i-grid_w/2-delta_w+2, 290+s-grid_h[j]-delta_h+2, 390+grid_w*i+grid_w/2-delta_w-2, 290+s-delta_h-2, (is_time_conflict(new init_time(week, i, j+5),new init_test(c)))?global.colors[0]: global.colors[1], 10);
					draw_text_ext_transformed_color(390+grid_w*i-delta_w, 290+s-grid_h[j]/2-delta_h, str, 50, 1000, 0.8, 0.8, 0, c_black, c_black, c_black, c_black, 1);
				}
			}else if (a_id){
				if (a_id<temp_N){
					var a = read_activity_info(a_id);
					var str = a._name;
					var p = 8;
					while (p<string_length(str)){
						str = string_insert("\n", str, p);
						p+=9;
					}
					draw_rectangle_width(390+grid_w*i-grid_w/2-delta_w+2, 290+s-grid_h[j]-delta_h+2, 390+grid_w*i+grid_w/2-delta_w-2, 290+s-delta_h-2, (a.tp==3)?0x00FF66: c_orange, 10);
				}else{
					var str = "临时事务";
					draw_rectangle_width(390+grid_w*i-grid_w/2-delta_w+2, 290+s-grid_h[j]-delta_h+2, 390+grid_w*i+grid_w/2-delta_w-2, 290+s-delta_h-2, 0xffff33, 10);
				}
				draw_text_ext_transformed_color(390+grid_w*i-delta_w, 290+s-grid_h[j]/2-delta_h, str, 50, 1000, 0.8, 0.8, 0, c_black, c_black, c_black, c_black, 1);
			}
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
		}
		s=0;
	}
}

draw_rectangle_color(0, 200, 230, 1000, c_white, c_white, c_white, c_white, 0);
//绘制左端时间
for (var i=1, j=60;i<r_count;i++){
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_ext_transformed_color(105, 215-delta_h+j+grid_h[i]/2, string(i+5)+":00~"+string(i+6)+":00" , 0, 2000, 0.75, 0.75, 0, c_black, c_black, c_black, c_black, 1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_line_width_color(0, 230-delta_h+j, WINDOW_WIDTH, 230-delta_h+j, 1, c_black, c_black);
	j += grid_h[i];
}
draw_line_width_color(230, 200, 230, WINDOW_WIDTH, 3, c_black, c_black);
draw_rectangle_color(0, 0, WINDOW_WIDTH, 200, c_white, c_white, c_white, c_white, 0);
draw_rectangle_color(0, 1000, WINDOW_WIDTH, WINDOW_HEIGHT, c_white, c_white, c_white, c_white, 0);
draw_line_width_color(0, 1000, WINDOW_WIDTH, 1000, 3, c_black, c_black);
draw_line_width_color(0, 200, WINDOW_WIDTH, 200, 3, c_black, c_black);
