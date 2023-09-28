h = 900;
w = 800;
h_limit = 0;
y_st = 120;
image_xscale = 800;
image_yscale = 900;
depth = -15;
state = 0;
father = noone;
str = [];
str[1024] = "";
font = [];
font[1024] = 0;
len = 0;
delta_h = 0;
e = instance_create_depth(x+w-60, y+65, depth-1, Scrollbar);
e.xx=x+w-60;
e.father = self;
e.image_yscale = 0.6;
e.h_range = h-275;

e2 = instance_create_button(x+300, y+790, 200, 60, 0.8, 9, "确定", self);

surf = noone;