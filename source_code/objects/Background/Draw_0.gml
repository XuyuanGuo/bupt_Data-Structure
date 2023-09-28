/// @description Insert description here
// You can write your code in this editor
/*if (!surface_exists(surf)){ surf=surface_create(WINDOW_WIDTH, WINDOW_HEIGHT);
surface_set_target(surf);
draw_clear_alpha(0, 0);*/
switch (tp){
	case 0:
		draw_rectangle_color(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, c_white, c_white, c_white, c_white, 0);
		draw_sprite_stretched_ext(spr_background, 0, 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, c_white, 0.4);
		draw_sprite_stretched(spr_bupt, 0, 180, 70, 880, 240);
		draw_set_font(Font3);
		draw_text_ext_transformed_color(700, 275, "学生日程管理系统", 0, 1000, 1.6, 1.6, 0, c_dkgrey, c_dkgray, c_dkgrey, c_dkgray, 1);
	break;
	case 1:
	break;
}
/*surface_reset_target();
}else{
	draw_surface(surf, 0, 0);
}*/