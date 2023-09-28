draw_self();
draw_rectangle_color(x, y, x+w, y+h, c_black, c_black, c_black, c_black, 1);
draw_rectangle_color(x-400, y, x, y+h, c_black, c_black, c_black, c_black, 1);
draw_rectangle_color(x-400, y, x, y+h, c_white, c_white, c_white, c_white, 0);
if (tp == 1){
	draw_rectangle_color(x+800, y, x+1200, y+h, c_white, c_white, c_white, c_white, 0);
	draw_rectangle_color(x+800, y, x+1200, y+h, c_black, c_black, c_black, c_black, 1);
}