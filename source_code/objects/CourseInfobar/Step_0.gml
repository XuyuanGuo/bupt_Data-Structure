/// @description Insert description here
// You can write your code in this editor
switch (state){
	//初始化状态
	case 0:
		if (tp == 1){
			e[0]=instance_create_button(x+280, y+55+92*9, 240, 50, 0.8, 8, "添加为新课程", self);
			e[2]=instance_create_button(x+570, y+55+92*9, 160, 50, 0.8, 10, "保存", self);
			e[4]=instance_create_button(x-300, y+h-80, 200, 60, 0.9, 12, "删除该课", self);
			e[5]=instance_create_depth(x+810, y+100, depth-2, Checklist);
			e[5].tp = 1;
			e[5].father = self;
			e[5].len = global.studentNum;
			textlabel[13]=instance_create_textlabel(x+495, y+55+92*2, 70, 50, 0.7, 0, ":00~");
			textlabel[10]=instance_create_textlabel(x+630, y+55+92*2, 50, 50, 0.7, 0, ":00");
			textlabel[11]=instance_create_textlabel(x+545, y+55+92*5, 70, 50, 0.7, 0, ":00~");
			textlabel[12]=instance_create_textlabel(x+695, y+55+92*5, 50, 50, 0.7, 0, ":00");
			textlabel[14]=instance_create_textlabel(x+900, y+30, 200, 50, 0.9, 0, "学生选课列表");
			textlabel[15]=instance_create_textlabel(x+420, y+41+92+35, 20, 20, 0.7, 0, "到");
				
			inputbox[0]=instance_create_inputbox(x+165,y+40, 620, 60/0.8, 0.8);
			inputbox[1]=instance_create_inputbox(x+165,y+40+92*7, 320, 60/0.8, 0.8);
			inputbox[2]=instance_create_inputbox(x+165,y+40+92*8, 620, 60/0.6, 0.6);
			inputbox[3]=instance_create_inputbox(x+435,y+41+92*2, 40, 40/0.8, 0.8);
			inputbox[4]=instance_create_inputbox(x+570,y+41+92*2, 40, 40/0.8, 0.8);
			inputbox[5]=instance_create_inputbox(x+485,y+41+92*5, 40, 40/0.8, 0.8);
			inputbox[6]=instance_create_inputbox(x+635,y+41+92*5, 40, 40/0.8, 0.8);
			inputbox[7]=instance_create_inputbox(x+545,y+40+92*3, 80, 40/0.8, 0.8);
			inputbox[8]=instance_create_inputbox(x+545,y+40+92*6, 80, 40/0.8, 0.8);
			inputbox[3].str2="8";
			inputbox[4].str2="9";
			inputbox[5].str2="8";
			inputbox[6].str2="9";
			inputbox[8].str2="101";
			for (var i=3;i<9;i++) inputbox[i].numberonly = 1;
			chooselist[0]=instance_create_chooselist(x+230, y+47+92*1, 150, 50, 0.7, 16, self, global.weeks2);
			chooselist[6]=instance_create_chooselist(x+465, y+47+92*1, 150, 50, 0.7, 16, self, global.weeks2);
			chooselist[1]=instance_create_chooselist(x+230, y+37+92*2, 150, 50, 0.7, 7, self, global.weekdays);
			chooselist[2]=instance_create_chooselist(x+170, y+42+92*3, 150, 45, 0.7, 6, self, ["主楼","教学楼一", "教学楼二","教学楼三","教学楼四","线上"]);
			chooselist[3]=instance_create_chooselist(x+40, y+37+92*5, 150, 50, 0.7, 17, self, global.weeks);
			chooselist[4]=instance_create_chooselist(x+230, y+37+92*5, 150, 50, 0.7, 7, self, global.weekdays);
			chooselist[5]=instance_create_chooselist(x+170, y+42+92*6, 150, 45, 0.7, 5, self, ["主楼","教学楼一", "教学楼二","教学楼三","教学楼四"]);
			state = 1;
		}else{
			if (chose!=-1) global.course = read_course_info(chose);
			e[2]=instance_create_button(x+550, y+55+92*9, 200, 50, 0.8, 28, "开启导航", self);
			textlabel2[0]=instance_create_textlabel(x+205, y+42, 570, 60, 0.8, 0, global.course._name);
			textlabel2[1]=instance_create_textlabel(x+175,y+44+92*7, 320, 60, 0.8, 0, global.course.online_platform);
			textlabel2[2]=instance_create_textlabel(x+175,y+47+92*8, 620, 60, 0.6, 0, global.course.online_link);
			textlabel2[3]=instance_create_textlabel(x+458,y+51+92*2, 40, 40, 0.8, 0, time_to_text(global.course));
			textlabel2[4]=instance_create_textlabel(x+205,y+51+92*3, 40, 40, 0.8, 0, (global.course.building<5)?place_to_text2(global.course):"线上");
			textlabel2[5]=instance_create_textlabel(x+205,y+51+92*4, 40, 40, 0.8, 0, (global.course.test_week!=0)?time_to_text(new init_test(global.course)):"无考试");
			textlabel2[6]=instance_create_textlabel(x+205,y+51+92*5, 40, 40, 0.8, 0, place_to_text(new init_test(global.course)));
			for (var i = 0; i<7; i++){
				textlabel2[i].font = Font2;
				if (i!=3) textlabel2[i].center = 0;
			}
			textlabel[3].y-=92;
			textlabel[2].visible = 0;
			textlabel[4].visible = 0;
			if (chose==-1){
				for (var i=0;i<7;i++) textlabel2[i].visible = 0;
			}
			state = 1;
		}
	break;
	//读写信息状态
	case 1:
		if (e[3].chose != chose){
			chose = e[3].chose;
			state = 3;
		}else if (tp == 1){
			global.course._name = inputbox[0].str2;
			global.course.online_platform = inputbox[1].str2;
			global.course.online_link = inputbox[2].str2;
			if (inputbox[3].str2!="") global.course.time = clamp(real(inputbox[3].str2), 8, global.course.len-1);
			if (inputbox[4].str2!="") global.course.len = clamp(real(inputbox[4].str2), global.course.time+1, 22);
			if (inputbox[5].str2!="") global.course.test_time = clamp(real(inputbox[5].str2), 8, global.course.test_len-1);
			if (inputbox[6].str2!="") global.course.test_len = clamp(real(inputbox[6].str2), global.course.test_time+1, 22);
			if (inputbox[7].str2!="") global.course.classroom = real(inputbox[7].str2);
			if (inputbox[8].str2!="") global.course.test_classroom = real(inputbox[8].str2);
			global.course.week = chooselist[0].chose + 1;
			global.course.day = chooselist[1].chose;
			global.course.building = chooselist[2].chose;
			global.course.test_week = chooselist[3].chose;
			global.course.test_day = chooselist[4].chose;
			global.course.test_building = chooselist[5].chose;
			global.course.edweek = chooselist[6].chose + 1;
			if (chooselist[2].chose>4){
				inputbox[7].visible = 0;
				textlabel[2].visible = 0;
			}else{
				inputbox[7].visible = 1;
				textlabel[2].visible =1;
			}
			if (chooselist[3].chose==0){
				textlabel[3].visible = 0;
				textlabel[4].visible = 0;
				textlabel[11].visible = 0;
				textlabel[12].visible = 0;
				inputbox[5].visible = 0;
				inputbox[6].visible = 0;
				inputbox[8].visible = 0;
				chooselist[4].visible = 0;
				chooselist[5].visible = 0;
			}else{
				textlabel[3].visible = 1;
				textlabel[4].visible = 1;
				textlabel[11].visible = 1;
				textlabel[12].visible = 1;
				inputbox[5].visible = 1;
				inputbox[6].visible = 1;
				inputbox[8].visible = 1;
				chooselist[4].visible = 1;
				chooselist[5].visible = 1;
			}
		}
	break;
	//销毁状态
	case 2:
		for (var i=0;i<=9;i++) instance_destroy(textlabel[i]);
		if (tp == 1){
			for (var i = 10;i<16;i++) instance_destroy(textlabel[i]);
			for (var i=0;i<9;i++) instance_destroy(inputbox[i]);
			for (var i=0;i<7;i++) chooselist[i].state = 4;
			instance_destroy(e[0]);
			e[5].destroy();
			instance_destroy(e[4]);
		}else{
			for (var i=0;i<7;i++) instance_destroy(textlabel2[i]);
		}
		e[3].destroy();
		instance_destroy(e[1]);
		instance_destroy(e[2]);
		close_window();
		instance_destroy();
	break;
	//刷新信息状态
	case 3:
		if (chose!=-1) global.course = read_course_info(chose);
		else{
			global.course = new init_course();
		}
		if (tp == 1){
			inputbox[0].str2 = global.course._name;
			inputbox[1].str2 = global.course.online_platform;
			inputbox[2].str2 = global.course.online_link;
			inputbox[3].str2 = string(clamp(global.course.time, 8, 21));
			inputbox[4].str2 = string(clamp(global.course.len, 9, 22));
			inputbox[5].str2 = string(clamp(global.course.test_time, 8, 21));
			inputbox[6].str2 = string(clamp(global.course.test_len, 9, 22));
			inputbox[7].str2 = global.course.classroom;
			inputbox[8].str2 = global.course.test_classroom;
			chooselist[0].chose = global.course.week - 1;
			chooselist[1].chose = global.course.day;
			chooselist[2].chose = global.course.building;
			chooselist[3].chose = global.course.test_week;
			chooselist[4].chose = global.course.test_day;	
			chooselist[5].chose = global.course.test_building;
			chooselist[6].chose = global.course.edweek - 1;
			//载入选课学生信息
			e[5].state = 3;
		}else{
			textlabel2[0].str=global.course._name;
			textlabel2[1].str=global.course.online_platform;
			textlabel2[2].str=global.course.online_link;
			textlabel2[3].str=time_to_text(global.course);
			textlabel2[4].str=(global.course.building<5)?place_to_text2(global.course):"线上";
			textlabel2[5].str=(global.course.test_week!=0)?time_to_text(new init_test(global.course)):"无考试";
			textlabel2[6].str=place_to_text(new init_test(global.course));
			if (chose==-1){
				for (var i=0;i<7;i++) textlabel2[i].visible = 0;
			}else{
				for (var i=0;i<7;i++) textlabel2[i].visible = 1;
					if (global.course.test_week==0){
					textlabel[3].visible = 0;
					textlabel2[6].visible = 0;
				}else{
					textlabel[3].visible = 1;
					textlabel2[6].visible = 1;
				}
			}
		}
		state = 1;
	break;
}