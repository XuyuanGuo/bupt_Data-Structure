/// @description Insert description here
// You can write your code in this editor
draw_self();
image_xscale = w;
image_yscale = h*wordsize;
draw_rectangle_color(x, y, x+w, y+h*wordsize, c_gray, c_gray, c_gray, c_gray, 1);
draw_set_font(font);
if (isinput == 0){
	if (str2=="") draw_text_transformed_color(x, y+(h-42)*wordsize/2, str1, wordsize, wordsize, 0, c_grey, c_grey, c_grey, c_grey, 1);
	else draw_text_transformed_color(x, y+(h-42)*wordsize/2, str2, wordsize, wordsize, 0, c_grey, c_grey, c_grey, c_grey, 1);
}else{
	if (timer<=0) timer = 40;
	if (timer>=25) draw_line_width_color(x+str_width[inputx], y+(h-52)*wordsize/2, x+str_width[inputx], y+h*wordsize-(h-52)*wordsize/2, 2, c_black, c_black);
	draw_text_transformed_color(x, y+(h-42)*wordsize/2, str2, wordsize, wordsize, 0, c_black, c_black, c_black, c_black, 1);
	timer--;
}
