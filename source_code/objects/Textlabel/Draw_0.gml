//设置绘制表面
if (tp == 3 || tp == 5 || tp == 6 || tp == 9 || tp == 10 || tp == 11 || tp == 12){
	if (surface_exists(father.surf)){
		surface_set_target(father.surf);
		if (num==father.textlabel[father.len-1].num) draw_clear_alpha(c_black, 0);
	}
}
if (tp!=5 && tp!=9 && tp!=10 && tp!=11) draw_self();
draw_set_font(font);
switch (tp){
	//日程查询结果文本框
	case 11:
		if (yy-father.delta_h>-50 && yy<father.delta_h+700){
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_roundrect_width(0, yy-father.delta_h, w-30, yy-father.delta_h+string_height_ext(str, 60, 900)*wordsize+5, global.colors[num2], 4);
		if (outline){
			draw_set_alpha(0.3);
			draw_roundrect_color_ext(0, yy-father.delta_h, w-30, yy-father.delta_h+string_height_ext(str, 60, 900)*wordsize+5, 20,20, global.colors[num2], global.colors[num2], 0);
			draw_set_alpha(1);
		}
		draw_text_ext_transformed_color(w/2, yy+11-father.delta_h, str, 60, 900, wordsize, wordsize, 0, c_black, c_black, c_black, c_black, 1);
		draw_set_halign(fa_left);
		}
	break;
	case 0: //普通文本框
		if (outline) draw_rectangle_color(x, y, x+w, y+h, c_black, c_black, c_black, c_black, 1);
		if (center) draw_text_ext_transformed_color(x+(w-string_width(str))/2, y+(h-string_height(str))/2, str, 0, 1000, wordsize, wordsize, 0, c_black, c_black, c_black, c_black, 1);
		else draw_text_ext_transformed_color(x, y+(h-string_height(str))/2, str, 0, 1000, wordsize, wordsize, 0, c_black, c_black, c_black, c_black, 1);
	break;
	case 1://横向选择框
	if (father.chose==num){
		draw_line_width_color(x+(w-string_width(father.str[num]))/2, y+(h+string_height(father.str[num]))/2.5, x+(w+string_width(father.str[num]))/2, y+(h+string_height(father.str[num]))/2.5, 2, c_black, c_black);
		draw_text_ext_transformed_color(x+(w-string_width(father.str[num]))/2*1.3, y+5+(h-string_height(father.str[num]))/2*1.3, father.str[num], 0, 1000, 0.8, 0.8, 0, c_black, c_black, c_black, c_black, 1);
	}else{
		draw_text_ext_transformed_color(x+(w-string_width(father.str[num]))/2*1.3, y+5+(h-string_height(father.str[num]))/2*1.3, father.str[num], 0, 1000, 0.8, 0.8, 0, c_grey, c_grey, c_grey, c_grey, 1);
	}
	break;
	case 2://系统状态显示文本框
		draw_text_ext_transformed_color(x+20, y+10, "当前身份："+((global.access==0)?"学生":"管理员"), 0, 1000, wordsize, wordsize, 0, c_black,c_black,c_black,c_black,1);
		draw_text_ext_transformed_color(x+20, y+50, "当前位置："+global.sites[global.location], 0, 1000, wordsize, wordsize, 0, c_black,c_black,c_black,c_black,1);
		draw_text_ext_transformed_color(x+20, y+90, "当前时间："+get_time(), 0, 1000, wordsize, wordsize, 0, c_black,c_black,c_black,c_black,1);
		draw_text_ext_transformed_color(x+20, y+130, "当前日期：第"+string(global.week)+"周 "+global.weekdays[global.day], 0, 1000, wordsize, wordsize, 0, c_black,c_black,c_black,c_black,1);
	break;
	case 5: case 10: case 12://3为普通单选框中的文本框，5为课程/活动使用的单选框，10为临时事务右侧列表的单选框，12为日志时间选择单选框中的文本框
		if (outline) draw_rectangle_color(1, 1-father.delta_h+yy, w, h-father.delta_h+yy, c_black, c_black, c_black, c_black, 1);
	case 3:
		draw_text_ext_transformed_color((w-string_width(str)*wordsize)/2, (h-string_height(str)*wordsize)/2-father.delta_h+yy+8, str, 0, 1000, wordsize, wordsize, 0, c_black, c_black, c_black, c_black, 1);
	break;
	case 9:///临时事务左侧时段单选框
		if (outline) draw_rectangle_color(1, 1-father.delta_h+yy, w, h-father.delta_h+yy, c_black, c_black, c_black, c_black, 1);
		draw_text_ext_transformed_color((w-string_width(time_to_text(filename_to_time(str)))*wordsize)/2, (h-string_height(time_to_text(filename_to_time(str)))*wordsize)/2-father.delta_h+yy+8, time_to_text(filename_to_time(str)), 0, 1000, wordsize, wordsize, 0, c_black, c_black, c_black, c_black, 1);
	break;
	case 6: //复选框中的文本框
		draw_sprite_ext(spr_check, outline, w-36, (h-32)/2-father.delta_h+yy, 1, 1, 0, c_white, 1);
		draw_text_ext_transformed_color((w-string_width(str)*wordsize)/2, (h-string_height(str)*wordsize)/2-father.delta_h+yy+8, str, 0, 1000, wordsize, wordsize, 0, c_black, c_black, c_black, c_black, 1);
	break;
}
if (tp == 3 || tp == 5 || tp == 6 || tp == 9 || tp == 10 || tp == 11 || tp == 12){
	if (surface_exists(father.surf)) surface_reset_target();
}