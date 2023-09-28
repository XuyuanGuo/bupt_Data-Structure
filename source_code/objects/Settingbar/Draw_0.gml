/// @description Insert description here
// You can write your code in this editor
draw_sprite_ext(spr_mask, 0, x-200,y-250, 400, 500, 0, c_white, 1);
draw_rectangle_width(x-200, y-250, x+200, y+250, c_grey, 10);
draw_set_font(Font3);
draw_text_ext_transformed_color(x-40,y-220,"设置",1000,1000,1,1,0,c_black,c_black,c_black,c_black,1);
draw_set_font(Font1);
draw_text_ext_transformed_color(x-155,y-75,"一小时=\n现实"+"           "+"秒",60,1000,0.7,0.7,0,c_black,c_black,c_black,c_black,1);
draw_text_ext_transformed_color(x-160,y-135,"日程提醒",60,1000,0.75,0.75,0,c_black,c_black,c_black,c_black,1);
