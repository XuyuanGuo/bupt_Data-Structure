depth = -30;
e1=instance_create_depth(x-170,y+30,depth-1,Button);
e1.h=60;
e1.w=160;
e1.image_xscale=160;
e1.image_yscale=60;
if (global.timepaused==0) e1.str="时钟暂停";
else e1.str = "解除暂停";
e1.tp=2;
e1.wordsize=0.8;

e2=instance_create_depth(x+15,y+30,depth-1,Button);
e2.h=60;
e2.w=160;
e2.image_xscale=160;
e2.image_yscale=60;
e2.str="退出登录";
e2.tp=3;
e2.wordsize=0.8;

e3=instance_create_depth(x-150,y+120,depth-1,Button);
e3.h=70;
e3.w=300;
e3.image_xscale=300;
e3.image_yscale=70;
e3.str="返回";
e3.tp=4;

e4=instance_create_depth(x+30,y-50,depth-1,Button);
e4.h=50;
e4.w=140;
e4.image_xscale=140;
e4.image_yscale=50;
e4.str="设置速度";
e4.tp=5;
e4.wordsize=0.75;

e5=instance_create_depth(x-85,y-35,depth-1,Inputbox);
e5.h=50;
e5.w=60;
e5.image_xscale=60;
e5.image_yscale=50;
e5.str1=string(floor(60/global.spd));
e5.str2=e5.str1;
e5.wordsize=0.6;
e5.numberonly = 1;
e4.friend=e5;

e6=instance_create_chooselist(x-20, y-135, 195, 40, 0.7, 2, self, ["提前一小时","提前两小时"]);
e6.chose = global.Remind_time;