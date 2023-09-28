// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function instance_create_textlabel(_x, _y, _w, _h, _wordsize, _tp, _str){
	var e = instance_create_depth(_x, _y, depth-1, Textlabel);
	e.w=_w;
	e.h=_h;
	e.image_xscale=_w;
	e.image_yscale=_h;
	e.wordsize=_wordsize;
	e.tp=_tp;
	e.str = _str;
	return e;
}
function instance_create_button(_x, _y, _w, _h, _wordsize, _tp, _str, _father){
	var e = instance_create_depth(_x, _y, depth-1, Button);
	e.w=_w;
	e.h=_h;
	e.image_xscale=_w;
	e.image_yscale=_h;
	e.wordsize=_wordsize;
	e.tp=_tp;
	e.str = _str;
	e.father = _father;
	return e;
}

function instance_create_inputbox(_x, _y, _w, _h, _wordsize){
	var e = instance_create_depth(_x, _y, depth-1, Inputbox);
	e.w=_w;
	e.h=_h;
	e.image_xscale=_w;
	e.image_yscale=_h;
	e.wordsize=_wordsize;
	return e;
}

function instance_create_chooselist(_x, _y, _w, _h, _wordsize, _len, _father, _strlist){
	var e = instance_create_depth(_x, _y, depth-3, Chooselist);
	e.w=_w;
	e.h=_h;
	e.wordsize = _wordsize;
	e.len = _len;
	e.father = _father;
	e.strlist = _strlist;
	return e;
}

function open_window(_dep){
	global.floor[++global.floor_top]=_dep;
}

function close_window(){
	global.floor_top--;
	if (global.floor_top==0) global.paused=0;
}

function get_floor(){
	return global.floor[global.floor_top];
}