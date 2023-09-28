/// @description Insert description here
// You can write your code in this editor
switch (state){
	//初始化状态
	case 0:
		e[0]=instance_create_depth(x-390, y+100, depth-2, Checklist);
		e[0].h-=80;
		e[0].tp = 2;
		e[0].father = self;
		e[0].len = global.activityNum;
		e[1]=instance_create_button(x+80, y+55+92*8, 160, 50, 0.8, 9, "返回", self);
		e[2]=instance_create_button(x+560, y+55+92*8, 160, 50, 0.8, 15, "保存信息", self);
		e[3]=instance_create_button(x+280, y+55+92*8, 240, 50, 0.8, 14, "保存为新活动", self);
		e[4]=instance_create_button(x+250, y+55+92*7, 300, 60, 0.8, 28, "进入导航", self);
		e[5]=instance_create_button(x-300, y+h-80, 200, 60, 0.9, 16, "删除活动", self);
		e[6]=instance_create_depth(x+640, y+47+92, depth-1, Check);
		e[6].father=self;
		textlabel[0]=instance_create_textlabel(x+41,y+56, 120, 50, 0.7, 0, "活动名称");
		textlabel[1]=instance_create_textlabel(x+41,y+55+92*4, 120, 50, 0.7, 0, "活动地点");
		textlabel[2]=instance_create_textlabel(x+455,y+55+92*4, 100, 50, 0.7, 0, "活动教室");
		textlabel[3]=instance_create_textlabel(x+41, y+55+92, 120, 50, 0.7, 0, "活动类型");
		textlabel[4]=instance_create_textlabel(x+41, y+55+92*2, 120, 50, 0.7, 0, "活动时间");
		textlabel[5]=instance_create_textlabel(x+690, y+55+92*3, 70, 50, 0.7, 0, ":00");
		textlabel[6]=instance_create_textlabel(x+51, y+55+92*6, 100, 50, 0.7, 0, "线上链接");
		textlabel[7]=instance_create_textlabel(x-300, y+30, 200, 50, 0.9, 0, "活动列表");
		textlabel[8]=instance_create_textlabel(x+506, y+55+92, 120, 50, 0.7, 0, "是否设置提醒");
		textlabel[9]=instance_create_textlabel(x+51, y+55+92*5, 100, 50, 0.7, 0, "线上平台");
		textlabel[10]=instance_create_textlabel(x+190, y+55+92*3, 40, 40, 0.7, 0, "到");
		inputbox[0]=instance_create_inputbox(x+155,y+35+92*6, 620, 60/0.6, 0.6);
		inputbox[1]=instance_create_inputbox(x+645,y+40+92*3, 40, 40/0.8, 0.8);
		inputbox[2]=instance_create_inputbox(x+570,y+40+92*4, 80, 40/0.8, 0.8);
		inputbox[3]=instance_create_inputbox(x+155,y+38+92*5, 360, 60/0.8, 0.8);
		inputbox[1].numberonly = inputbox[2].numberonly = 1;
		inputbox[0].letteronly = 1;
		chooselist[0]=instance_create_chooselist(x+170, y+37, 570, 50, 0.8, 7, self, strlist);
		chooselist[0].tp = 1;
		chooselist[0].chooselist_inputbox_create();
		chooselist[1]=instance_create_chooselist(x+170, y+43+92*1, 200, 45, 0.7, 2, self, ["个人活动","集体活动"]);
		chooselist[5]=instance_create_chooselist(x+250, y+37+92*3, 150, 45, 0.7, 16, self, global.weeks2);
		chooselist[2]=instance_create_chooselist(x+20, y+37+92*3, 150, 45, 0.7, 16, self, global.weeks2);
		chooselist[3]=instance_create_chooselist(x+430, y+37+92*3, 150, 45, 0.7, 10, self, global.days);
		chooselist[4]=instance_create_chooselist(x+150, y+40+92*4, 240, 48, 0.7, SITE_N, self, global.sites);
		state = 3;
	break;
	//读写信息状态
	case 1:
		if (e[0].chose != chose){
			chose = e[0].chose;
			state = 3;
		}else{
			global.activity._name = chooselist[0].inputbox.str2;
			global.activity.online_platform = inputbox[3].str2;
			global.activity.online_link = inputbox[0].str2;
			if (inputbox[1].str2!="") global.activity.time = clamp(6, real(inputbox[1].str2), 21);
			if (inputbox[2].str2!="") global.activity.classroom = real(inputbox[2].str2);
			global.activity.tp = !chooselist[1].chose+2;
			global.activity.week = chooselist[2].chose + 1;
			global.activity.day = chooselist[3].chose;
			global.activity.building = chooselist[4].chose;
			global.activity.edweek = chooselist[5].chose + 1;
			global.activity.isalarm = e[6].checked;
			if (global.activity.building<5){
				textlabel[2].visible = 1;
				inputbox[2].visible = 1;
			}else{
				textlabel[2].visible = 0;
				inputbox[2].visible = 0;
			}
			if (chooselist[1].prechose != chooselist[1].chose){
				chooselist[1].prechose = chooselist[1].chose;
				if (chooselist[1].chose == 0){
					chooselist[0].strlist = global.enum_individual_activity;
					chooselist[0].state = 0;
				}else{
					chooselist[0].strlist = global.enum_collective_activity;
					chooselist[0].state = 0;
				}
			}
		}
	break;
	//销毁状态
	case 2:
		for (var i=0;i<11;i++) instance_destroy(textlabel[i]);
		for (var i=0;i<4;i++) instance_destroy(inputbox[i]);
		for (var i=0;i<6;i++) chooselist[i].state = 4;
		for (var i=1;i<7;i++) instance_destroy(e[i]);
		e[0].state = 2;
		close_window();
		instance_destroy();
	break;
	//刷新信息状态
	case 3:
		if (chose!=-1) global.activity = read_activity_info(chose);
		else{
			global.activity = new init_activity();
		}
		chooselist[0].inputbox.str2 = global.activity._name;
		inputbox[3].str2 = global.activity.online_platform;
		inputbox[0].str2 = global.activity.online_link;
		inputbox[1].str2 = string(clamp(global.activity.time, 6, 22));
		inputbox[2].str2 = string(global.activity.classroom);
		chooselist[1].chose = !(global.activity.tp-2);
		chooselist[2].chose = global.activity.week-1;
		chooselist[3].chose = global.activity.day;
		chooselist[4].chose = global.activity.building;
		chooselist[5].chose = global.activity.edweek -1;
		e[6].checked = global.activity.isalarm;
		state = 1;
	break;
}