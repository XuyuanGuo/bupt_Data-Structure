if (next!=0){
	draw_set_color(0x00FF66);
	draw_circle(x, y, 5, 0);
	draw_line_width_color(x, y, global.navipoint[next].x, global.navipoint[next].y, 10, 0x00FF66, 0x00FF66);
}else if(_id==global.navi_path[global.navi_path[0]]){
	draw_set_color(0x00FF66);
	draw_circle(x, y, 5, 0);
	draw_sprite(spr_endpoint, 0, x, y);
}