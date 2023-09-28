/// @description Insert description here
// You can write your code in this editor
if (!surface_exists(surf)){
	surf = surface_create(w-8, h);
}
switch (state){
	case 0:
		image_xscale=w;
		image_yscale=h;
		h_limit = gap*len-h;
		var delta_i = 0;
		for (var i=0, j=1;i<len;i++){
			switch (tp){
				//建立课程列表
				case 0:
					while (global.courseList[j]==0){
						j++;
					}
					textlabel[i] = instance_create_textlabel(x+15, y+i*gap+10-delta_h, w-40, gap-5, wordsize, 5, string_cut(buffer_peek(global.courseInfo, 170*global.courseList[j], buffer_string)));
					textlabel[i].num = global.courseList[j];
					textlabel[i].father = self;
					if (textlabel[i].num==father.chose){
						//global.course = read_course_info(global.courseList[j]);
						textlabel[i].outline = 1;
						chose = textlabel[i].num;
						delta_i = i;
						//global.course = read_course_info(father.chose);
						//father.e[5].state = 3;
					}
				break;
				//建立学生选课列表
				case 1:
					textlabel[i] = instance_create_textlabel(x+15, y+i*gap+10-delta_h, w-40, gap-5, wordsize, 6, string_cut(global.studentList[j]));
					textlabel[i].num = j;
					textlabel[i].father = self;
				break;
				//建立活动列表
				case 2:
					while (global.activityList[j]==0){
						j++;
					}
					textlabel[i] = instance_create_textlabel(x+15, y+i*gap+10-delta_h, w-40, gap-5, wordsize, 5, string_cut(buffer_peek(global.activityInfo, 180*j, buffer_string)));
					textlabel[i].num = global.activityList[j];
					textlabel[i].father = self;
					if (textlabel[i].num==father.chose){
						textlabel[i].outline = 1;
						chose = textlabel[i].num;
						delta_i = i;
					}
				break;
				case 5:
					textlabel[i] = instance_create_textlabel(x+15, y+i*gap+10, w-40, gap-5, wordsize, 5, string(global.clockList[1+i*3])+":00 "+global.clockdays[(global.clockList[2+i*3]-127)?0: global.clockList[2+i*3]]+" "+global.clockweeks[global.clockList[3+i*3]]);
					textlabel[i].num = i;
					textlabel[i].father = self;
				break;
				case 6:
					textlabel[i] = instance_create_textlabel(x+15, y+i*gap+10, w-40, gap-5, wordsize, 6, global.weekdays[i]);
					textlabel[i].num = i;
					textlabel[i].father = self;
				break;
			}
			j++;
		}
		//刷新选课学生列表
		if (tp == 1){
			if (father.chose!=-1){
				var buff = buffer_load(working_directory + "Courses/" + string(father.chose) +".sav");
				var l = buffer_read(buff, buffer_s32);
				for (var i = 0;i<l;i++){
					textlabel[buffer_read(buff, buffer_s32)-1].outline = 1;
				}
				buffer_delete(buff);
			}
		}else if (tp == 3){//建立临时事务时段列表
			var i = 0;
			var _filename = file_find_first(working_directory + "/Users/" + global.student + "/tempstuff/*.sav", 0);
			while (_filename != ""){
				textlabel[i] = instance_create_textlabel(x+15, y+i*gap+10-delta_h, w-40, gap-5, wordsize, 9, string_copy(_filename, 1, string_length(_filename)-4));
				textlabel[i].num = i;
				textlabel[i].father = self;
				if (textlabel[i].str==father.filename){
					textlabel[i].outline = 1;
					chose = textlabel[i].num;
					delta_i = i;
				}
				_filename = file_find_next();
				i++;
			}
			file_find_close();
			len = i;
		}else if (tp == 4){//建立临时事务列表
			if (father.checklist[0].chose != -1){
				var tlist = read_tempstuff_info(filename_to_time(father.filename));
				//show_message(tlist[0]);
				for (var i = 0; i<tlist[0]; i++){
					//show_message(tlist[i+1]._name);
					textlabel[i] = instance_create_textlabel(x+15, y+i*gap+10-delta_h, w-40, gap-5, wordsize, 10, string_cut(tlist[i+1]._name));
					textlabel[i].num = i;
					textlabel[i].father = self;
				}
				chose = -1;
				len = tlist[0];
			}else{
				//空表
				len = 0;
				chose = -1;
			}
		}
		//创建下拉条
		e = instance_create_depth(x+w, y+h, depth-1, Scrollbar);
		e.xx=x+w;
		e.father = self;
		e.image_yscale = 0.5;
		e.h_range = h;
		if (h_limit<=0) e.visible = 0;
		//if (len>8 && tp==3) e.visible = 1;
		//show_message(len);
		//show_message(h_limit);
		//自动调整相应下拉位置
		if (delta_i*gap+10-delta_h>h) delta_h = (delta_i+1)*gap+5-delta_h-h;
		for (var i=0;i<len;i++){
			textlabel[i].y=y+gap*i+10-delta_h;
			textlabel[i].yy=gap*i;
		}
		state = 1;
	break;
	case 1:
		for (var i=0;i<len;i++){
			textlabel[i].y=y+gap*i+10-delta_h;
			textlabel[i].yy=gap*i;
		}
		if (len*gap-h>0){
			e.visible = 1;
			h_limit = len*gap-h;
		}
	break;
	case 2:
		for (var i=0;i<len;i++){
			instance_destroy(textlabel[i]);
		}
		instance_destroy(e);
		instance_destroy();
	break;
	//刷新
	case 3:
		for (var i=0;i<len;i++){
			instance_destroy(textlabel[i]);
		}
		if (tp == 0) len = global.courseNum;
		else if (tp == 2) len = global.activityNum;
		else if (tp == 5) len = global.clockList[0];
		instance_destroy(e);
		//surface_free(surf);
		state = 0;
	break;
}