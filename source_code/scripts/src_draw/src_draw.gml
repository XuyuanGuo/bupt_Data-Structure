// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_rectangle_width(_x1, _y1, _x2, _y2, _col, _d){
	for (var i=0;i<_d;i++){
		draw_rectangle_color(_x1+i, _y1+i, _x2-i, _y2-i, _col, _col, _col, _col, 1);
	}
}
function draw_roundrect_width(_x1, _y1, _x2, _y2, _col, _d){
	for (var i=0;i<_d;i++){
		draw_roundrect_color_ext(_x1+i, _y1+i, _x2-i, _y2-i, 20, 20, _col, _col, 1);
	}
}