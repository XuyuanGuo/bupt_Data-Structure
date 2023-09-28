/// @description Insert description here
// You can write your code in this editor
h = 450;
w = 500;
len = 2;
str = noone;
chose = -1;
tp = 0;
var e1=instance_create_depth(640, 538, -10, Inputbox);
e1.w = 400;
e1.h = 72;
e1.str1 = "请输入学号";
e1.font = Font1;
e1.wordsize=0.9;
e1.numberonly = 1;

var e2=instance_create_depth(640, 618, -10, Inputbox);
e2.w = 400;
e2.h = 72;
e2.str1 = "请输入密码";
e2.font = Font1;
e2.wordsize = 0.9;
e2.letteronly = 1;

var e3=instance_create_depth(720, 720, -15, Button);
e3.h=60;
e3.w=240;
e3.friend[0]=e1;
e3.friend[1]=e2;
e3.friend[2]=self;
e3.str="登录";
e3.tp=1;
e3.image_xscale=e3.w;
e3.image_yscale=e3.h;
friend=e3;

for (var i=0;i<len;i++){
	var e=instance_create_depth(x+w/len*i, y+15, depth-1, Textlabel);
	e.father=self;
	e.num=i;
	e.h=60;
	e.image_yscale=60;
	e.w=w/len;
	e.image_xscale=e.w;
	e.tp=1;
}