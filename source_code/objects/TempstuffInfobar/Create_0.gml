state = 0;
image_xscale = 600;
image_yscale = 800;
father = noone;
w = 600;
h = 800;
chose = -1;
depth = -9;
filename = "";

button = [];
button[0]=instance_create_button(x+20, y+90*8, 120, 50, 0.8, 9, "返回", self);
button[1]=instance_create_button(x+420, y+90*8, 160, 50, 0.8, 19, "保存信息", self);
button[2]=instance_create_button(x+160, y+90*8, 240, 50, 0.8, 18, "保存为新事务", self);
button[3]=instance_create_button(x+150, y+5+90*7, 300, 60, 0.8, 28, "进入导航", self);
button[4]=instance_create_button(x-300, y+h-80, 200, 60, 0.9, 21, "删除时段", self);
button[5]=instance_create_button(x+700, y+h-80, 200, 60, 0.9, 20, "删除事务", self);

textlabel = [];
textlabel[0]=instance_create_textlabel(x-300, y+30, 200, 50, 0.9, 0, "时段列表");
textlabel[1]=instance_create_textlabel(x+87,y+15+92*5, 120, 50, 0.7, 0, "临时事务地点");
textlabel[2]=instance_create_textlabel(x+116,y+10+92*6, 120, 50, 0.7, 0, "教室");
textlabel[3]=instance_create_textlabel(x+87, y+15+92*2, 120, 50, 0.7, 0, "是否设置提醒");
textlabel[4]=instance_create_textlabel(x+87, y+15+92*3, 120, 50, 0.7, 0, "临时事务时间");
textlabel[5]=instance_create_textlabel(x+515, y+16+92*4, 60, 40, 0.75, 0, ":00");
textlabel[6]=instance_create_textlabel(x+715, y+20, 200, 50, 0.9, 0, "临时事务列表");
textlabel[7]=instance_create_textlabel(x+87, y+38, 120, 50, 0.7, 0, "临时事务类型");

chooselist = [];
chooselist[0]=instance_create_chooselist(x+20, y+10+92, 550, 50, 0.8, 7, self, global.enum_tempstuff);
chooselist[0].tp = 1;
chooselist[0].chooselist_inputbox_create();
chooselist[1]=instance_create_chooselist(x+210, y+3+92*2, 70, 45, 0.7, 2, self, ["否","是"]);
chooselist[2]=instance_create_chooselist(x+20, y-5+92*4, 200, 50, 0.8, 16, self, ["第一周","第二周","第三周","第四周", "第五周", "第六周","第七周","第八周","第九周", "第十周","第十一周","第十二周","第十三周","第十四周", "第十五周","第十六周"]);
chooselist[3]=instance_create_chooselist(x+240, y-5+92*4, 200, 50, 0.8, 7, self, ["星期一","星期二", "星期三","星期四","星期五", "星期六", "星期日"]);
chooselist[4]=instance_create_chooselist(x+240, y-3+92*5, 200, 50, 0.7, SITE_N-1, self, global.sites);

inputbox = [];
inputbox[0]=instance_create_inputbox(x+465,y+92*4, 40, 40/0.8, 0.8);
inputbox[1]=instance_create_inputbox(x+241,y+92*6, 80, 40/0.8, 0.8);
inputbox[0].numberonly = 1;
inputbox[1].numberonly = 1;

checklist[0]=instance_create_depth(x-390, y+100, depth-2, Checklist);
checklist[0].h-=160;
checklist[0].tp = 3;
checklist[0].father = self;
checklist[0].create();
checklist[1]=instance_create_depth(x+610, y+100, depth-2, Checklist);
checklist[1].h-=160;
checklist[1].tp = 4;
checklist[1].father = self;
checklist[1].create();

function destroy(){
	for (var i=0; i<6; i++) instance_destroy(button[i]);
	for (var i=0; i<8; i++) instance_destroy(textlabel[i]);
	for (var i=0; i<2; i++) instance_destroy(inputbox[i]);
	for (var i=0; i<5; i++) chooselist[i].destroy();
	checklist[0].destroy();
	checklist[1].destroy();
	close_window();
	instance_destroy();
}