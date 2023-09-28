tp = 0;
state = 0;
image_xscale = 800;
image_yscale = 880;
father = noone;
h = 880;
w = 800;
depth = -9;

e = [];
textlabel = [];
strlist = global.enum_individual_activity;
chooselist = [];
inputbox = [];

chose = -1;

function destroy(){
	for (var i=0;i<11;i++) instance_destroy(textlabel[i]);
	for (var i=0;i<4;i++) instance_destroy(inputbox[i]);
	for (var i=0;i<6;i++) chooselist[i].destroy();
	for (var i=1;i<7;i++) instance_destroy(e[i]);
	e[0].destroy();
	close_window();
	instance_destroy();
}