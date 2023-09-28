tp = 0;
state = 0;
image_xscale = 800;
image_yscale = 680;
father = noone;
h = 680;
w = 800;
depth = -9;

e = [];
textlabel = [];
chooselist = [];
inputbox = [];

e[0]=instance_create_depth(x-390, y+100, depth-2, Checklist);
e[0].h-=280;
e[0].tp = 5;
e[0].father = self;
e[0].len = global.clockList[0];
e[5]=instance_create_depth(x+340, y+100, depth-2, Checklist);
e[5].h-=360;
e[5].tp = 6;
e[5].father = self;
e[5].len = 7;
e[1]=instance_create_button(x+80, y+55+92*6, 160, 50, 0.8, 9, "返回", self);
e[2]=instance_create_button(x+560, y+55+92*6, 160, 50, 0.8, 24, "保存信息", self);
e[3]=instance_create_button(x+280, y+55+92*6, 240, 50, 0.8, 23, "保存为新闹钟", self);
e[4]=instance_create_button(x-300, y+h-80, 200, 60, 0.9, 25, "删除闹钟", self);
textlabel[0]=instance_create_textlabel(x-300, y+30, 200, 50, 0.9, 0, "闹钟列表");
chooselist[0]=instance_create_chooselist(x+40, y+37+92, 200, 50, 0.8, 17, self, ["每周","第一周","第二周","第三周","第四周", "第五周", "第六周","第七周","第八周","第九周", "第十周","第十一周","第十二周","第十三周","第十四周", "第十五周","第十六周"]);
chooselist[1]=instance_create_chooselist(x+40, y+37+92*2+46, 200, 50, 0.8, 11, self, ["自定义","星期一","星期二", "星期三","星期四","星期五", "星期六", "星期日", "每天", "工作日", "双休日"]);
chooselist[2]=instance_create_chooselist(x+40, y+37+92*4, 200, 50, 0.8, 17, self, ["6:00","7:00","8:00","9:00","10:00", "11:00", "12:00", "13:00", "14:00", "15:00","16:00","17:00","18:00","19:00","20:00", "21:00", "22:00"]);

chose = -1;