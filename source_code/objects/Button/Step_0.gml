/// @description Insert description here
// You can write your code in this editor
event_inherited();
image_xscale=w*scale;
image_yscale=h*scale;
switch (state){
	case 0:
		color = c_grey;
		scale = 1;
		if (tp == 11 || tp == 13 || tp == 17 || tp == 22){
			visible = father.visible;
		}
	break;
	case 1:
		color = c_grey;
		scale = 0.95;
	break;
	case 2:
		color = c_black;
		scale = 1;
		switch(tp){
			//登录与注册按钮
			case 1:
				if (friend[2].chose==1){
					//注册
					user_register(friend[0].str2, friend[1].str2);
				}else{
					user_login(friend[0].str2, friend[1].str2);
				}
			break;
			//时钟暂停按钮
			case 2:
				global.timepaused = !global.timepaused;
				if (str == "时钟暂停"){
					str = "解除暂停";
					log_update("进入时钟暂停");
				}else{
					str = "时钟暂停";
					log_update("解除时钟暂停");
				}
			break;
			//退出登录按钮
			case 3:
				system_save();
				room_goto(room_start);
			break;
			//设置界面返回按钮
			case 4: 
				with(Setting) setting_pause();
			break;
			//设置速度按钮
			case 5:
				if (friend.str2=="") friend.str2=60/global.spd;
				global.spd = min(60,60/real(friend.str2));
				log_update("设置速度："+friend.str2+"秒为现实一小时");
			break;
			case 6:
				global.graph.open_graph();
			break;
			case 7:
				global.graph.close_graph();
			break;
			//添加课程
			case 8:
				if (global.course._name == "") {
					show_message("请输入课程名称");
				}else{
					var _id = get_course_id();
					//检测冲突
					var stu_chose = [];
					stu_chose[global.studentNum] = 0;
					for (var i = 0; i<global.studentNum; i++){
						if (father.e[5].textlabel[i].outline == 1) stu_chose[i+1] = 1;
						else stu_chose[i+1] = 0;
					}
					//更新课程信息列表
					write_course_info(global.course, _id);
					if (course_conflict_manage(stu_chose, _id, new init_course())){
						//更新课程列表
						global.courseNum++;
						global.courseList[_id]=_id;
						global.courseList[0]=global.courseNum;
						student_course_add(stu_chose, _id);
						//保存课程信息
						save_courselist();
						create_schedule_hash(global.course, _id);
						buffer_save(global.courseInfo, working_directory + "course_info.sav");
						log_create_courseadd(global.course);
						show_message("课程添加成功");
						global.graph.refresh();
						father.e[3].refresh();
						father.e[5].refresh();
					}
				}
			break;
			//取消课程添加和管理
			case 9:
				father.state = 2;
			break;
			//更新课程信息
			case 10:
				if (father.e[3].chose!=-1){
					if (global.course._name!=""){
						var c = father.e[3].chose;
						var pre = read_course_info(c);
						//更新课程信息
						write_course_info(global.course, c);
						
						//该数组下标为学生id，如果值为1说明学生选中该门课
						var stu_chose = [];
						stu_chose[global.studentNum] = 0;
						for (var i = 0; i<global.studentNum; i++){
							if (father.e[5].textlabel[i].outline == 1){
								stu_chose[i+1] = 1;
							}else{
								stu_chose[i+1] = 0;
							}
						}
						if (course_conflict_manage(stu_chose, c, pre)){
							student_course_update(stu_chose, c);
							buffer_save(global.courseInfo, working_directory + "course_info.sav");
							global.graph.refresh();
							update_schedule_hash(pre, c, global.course, c);
							log_create_courseupdate(global.course);
							show_message("课程信息更新成功");
							father.e[3].refresh();
							father.state = 3;
						}
					}else{
						show_message("请输入课程名");
					}
				}else{
					show_message("尚未选中课程");
				}
			break;
			//进入管理课程界面
			case 11:
				if (depth<get_floor()){
					open_window(-9);
					if (global.access){
						var e=instance_create_depth(840-400, 525-490, -9, CourseInfobar);
						e.father = self;
						e.tp = 1;
					}else{
						var e=instance_create_depth(840-200, 525-490, -9, CourseInfobar);
						e.father = self;
					}
				}
			break;
			//删除课程
			case 12:
				if (father.e[3].chose!=-1){
					var c_id = father.e[3].chose;
					log_create_coursedelete(read_course_info(c_id));
					delete_schedule_hash(read_course_info(c_id), c_id);
					var buff = buffer_load(working_directory + "Courses/" + string(c_id) + ".sav");
					var l = buffer_peek(buff, 0, buffer_s32);
					for (var i = 1; i<=l; i++){
						var stu = buffer_peek(buff, 4*i, buffer_s32);
						var buff_stu = buffer_load(working_directory + "Users/" + global.studentList[stu] + "/course.sav");
						course_delete_stu(buff_stu, c_id);
						buffer_save(buff_stu, working_directory + "Users/" + global.studentList[stu] + "/course.sav");
					}
					global.courseList[c_id] = 0;
					global.courseNum--;
					save_courselist();
					buffer_delete(buff);
					file_delete(working_directory + "Courses/" + string(c_id) + ".sav");
					father.e[3].refresh();
					father.e[3].chose = -1;
					global.graph.refresh();
					father.state = 3;
					show_message("成功删除课程");
				}else{
					show_message("尚未选中课程");
				}
			break;
			//进入活动管理界面
			case 13:
				if (visible && depth<get_floor()){
					open_window(-5);
					var e=instance_create_depth(840-200, 525-480, -9, ActivityInfobar);
					e.father = self;
				}
			break;
			//添加活动
			case 14:
				var _id = get_activity_id();
				if (_id == activity_N){
					show_message("添加失败，活动数量超过上限");
				}else{
					if (global.activity._name == ""){
						show_message("请输入活动名称");
					}else{
						if (activity_conflict_manage(0)){
							write_activity_info(global.activity, _id);
							update_activitylist(_id);
							update_activitytable(global.activity, _id);
							save_activityInfo();
							save_activityList();
							create_schedule_hash(global.activity, _id);
							log_create_activityadd(global.activity);
							show_message("成功添加活动");
							global.graph.refresh();
							father.e[0].refresh();
						}
					}
				}
			break;
			//编辑活动信息
			case 15:
				if (father.e[0].chose!=-1){
				var _id = father.e[0].chose;
				var pre = read_activity_info(_id);
				if (_id == -1){
					show_message("该活动未被添加");
				}else{
					if (global.activity._name == ""){
						show_message("请输入活动名称");
					}else{
						if (activity_conflict_manage(_id)){
							update_activitytable(pre, 0);
							update_activitytable(global.activity, _id);
							write_activity_info(global.activity, _id);
							save_activityInfo();
							update_schedule_hash(pre, _id, global.activity, _id);
							log_create_activityupdate(global.activity);
							show_message("成功更新活动信息");
							global.graph.refresh();
							father.e[0].refresh();
						}
					}
				}
				}else show_message("请选中一门活动");
			break;
			//删除活动
			case 16:
				var _id = father.e[0].chose;
				if (_id == -1){
					show_message("未选择要删除的活动");
				}else{
					var pre = read_activity_info(_id);
					update_activitytable(pre, 0);
					delete_schedule_hash(pre, _id);
					delete_activity(_id);
					save_activityList();
					log_create_activitydelete(pre);
					show_message("成功删除活动");
					global.graph.refresh();
					father.e[0].refresh();
				}
			break;
			//打开临时事务管理窗口
			case 17:
				if (visible && depth<get_floor()){
					open_window(-9);
					var e=instance_create_depth(840-300, 525-400, -9, TempstuffInfobar);
					e.state = 0;
					e.father = self;
				}
			break;
			//添加临时事务
			case 18:
			if (global.tempstuff._name == ""){
				show_message("请输入临时事务名称");
			}else{
				var cf = tempstuff_conflict_detection(global.tempstuff, 0);
				if (!cf){
					var af = tempstuff_conflict_detection(global.tempstuff, 1);
					if (!af){
						var flag = insert_tempstuff(global.tempstuff);
						if (flag==0){
							show_message("临时事务总数达到上限");
						}else if (flag==-1){
							show_message("该时段临时事务总数达到上限");
						}else{
							log_create_tempstuffinsert(global.tempstuff);
							show_message("添加临时事务成功");
							father.checklist[0].refresh();
							father.checklist[1].refresh();
							global.graph.refresh();
						}
					}else show_message("该临时事务与活动 " + read_activity_info(af)._name + " 冲突");
				}else show_message("该临时事务与课程 " + read_course_info(cf)._name + " 冲突");
			}
			break;
			//更改临时事务信息
			case 19:
			if (global.tempstuff._name == ""){
				show_message("请输入临时事务名称");
			}else{
				if (father.checklist[1].chose!=-1){
					var tlist = read_tempstuff_info(filename_to_time(father.filename));
					//时间不变
					if (is_time_conflict(filename_to_time(father.filename), global.tempstuff)){
						tempstuff_list_update(tempstuff_copy(global.tempstuff), tlist[father.checklist[1].chose+1]._id);
						tlist[father.checklist[1].chose+1] = tempstuff_copy(global.tempstuff);
						log_create_tempstuffupdate(tlist[father.checklist[1].chose+1]);
						write_tempstuff_info(tlist, working_directory + "/Users/" + global.student + "/tempstuff/" + father.filename +".sav");
						show_message("成功更新临时事务信息");
						var p = father.checklist[1].chose;
						father.checklist[1].refresh();
						father.checklist[1].chose = p;
					}else{
						var cf = tempstuff_conflict_detection(global.tempstuff, 0);
						if (!cf){
							var af = tempstuff_conflict_detection(global.tempstuff, 1);
							if (!af){
								//删除原有临时事务
								tempstuff_delete(father.filename, father.checklist[1].chose+1);
								father.checklist[0].chose = -1;
								father.checklist[1].chose = -1;
								//更新新的临时事务时间
								log_create_tempstuffupdate(global.tempstuff);
								insert_tempstuff(global.tempstuff);
								show_message("更新临时事务信息成功");
								father.checklist[0].refresh();
								father.checklist[1].refresh();
								global.graph.refresh();
							}else show_message("该活动与活动 " + read_activity_info(af)._name + " 冲突");
						}else show_message("该活动与课程 " + read_course_info(cf)._name + " 冲突");
					}
				}else show_message("未选中临时事务");
			}
			break;
			//删除临时事务
			case 20:
				if (father.checklist[1].chose!=-1){
					log_create_tempstuffdelete(global.tempstuffList[global.tempstuff._id]);
					tempstuff_delete(father.filename, father.checklist[1].chose+1);
					father.checklist[0].chose = -1;
					father.checklist[1].chose = -1;
					show_message("成功删除临时事务");
					father.checklist[0].refresh();
					father.checklist[1].refresh();
					global.graph.refresh();
				}else show_message("未选中临时事务");
			break;
			//删除时段
			case 21:
				if (father.checklist[0].chose!=-1){
					var tlist = read_tempstuff_info(filename_to_time(father.filename));
					for (var i=1;i<=tlist[0];i++){
						delete_schedule_hash(tlist[i], tlist[i]._id);
						global.tempstuffList[tlist[i]._id] = noone;
					}
					global.tempstuffHash.remove(time_to_int(filename_to_time(father.filename)));
					father.checklist[0].chose = -1;
					father.checklist[1].chose = -1;
					update_activitytable(filename_to_time(father.filename), 0);
					file_delete(working_directory + "/Users/" + global.student + "/tempstuff/" + father.filename +".sav");
					log_create_tempstufftimedelete(time_to_text(filename_to_time(father.filename)));
					show_message("已删除该时段所有临时事务");
					father.checklist[0].refresh();
					father.checklist[1].refresh();
					global.graph.refresh();
				}
			break;
			//开启闹钟设置
			case 22:
				if (visible && depth<get_floor()){
					open_window(-9);
					var e=instance_create_depth(840-200, 525-380, -9, Clockbar);
					e.father = self;
				}
			break;
			//添加闹钟
			case 23:
				var _day = 0;
				if (father.chooselist[1].chose == 0){
					for (var i = 0; i<7; i++){
						if (father.e[5].textlabel[i].outline){
							_day += (1<<i);
						}
					}
					_day += (1<<7);
				}else{
					_day=father.chooselist[1].chose;
				}
				if (_day!=128){
					clock_insert(father.chooselist[0].chose, _day, father.chooselist[2].chose+6);
					create_clocktable();
					save_clock_info();
					log_create_clockadd(string(father.chooselist[2].chose+6)+":00 "+global.clockdays[father.chooselist[1].chose]+" "+global.clockweeks[father.chooselist[0].chose]);
					show_message("成功添加闹钟");
					father.e[0].state = 3;
				}else{
					show_message("请输入时间");
				}
			break;
			//修改闹钟信息
			case 24:
				if (father.e[0].chose!=-1){
					clock_delete(father.e[0].chose);
					father.e[0].chose = -1;
					var _day = 0;
					if (father.chooselist[1].chose == 0){
						for (var i = 0; i<7; i++){
							if (father.e[5].textlabel[i].outline){
								_day += (1<<i);
							}
						}
						_day += (1<<7);
					}else{
						_day=father.chooselist[1].chose;
					}
					if (_day!=128){
						clock_insert(father.chooselist[0].chose, _day, father.chooselist[2].chose+6);
						show_message("成功修改闹钟信息");
						log_create_clockupdate(string(father.chooselist[2].chose+6)+":00 "+global.clockdays[father.chooselist[1].chose]+" "+global.clockweeks[father.chooselist[0].chose]);
						save_clock_info();
						father.e[0].state = 3;
						create_clocktable();
					}else{
						show_message("请输入时间");
					}
				}else{
					show_message("请选择一个闹钟");
				}
			break;
			//删除闹钟
			case 25:
				if (father.e[0].chose!=-1){
				log_create_clockdelete(string(father.chooselist[2].chose+6)+":00 "+global.clockdays[father.chooselist[1].chose]+" "+global.clockweeks[father.chooselist[0].chose]);
					clock_delete(father.e[0].chose);
					father.e[0].chose = -1;
					save_clock_info();
					show_message("成功删除闹钟");
					father.e[0].state = 3;
					create_clocktable();
				}else{
					show_message("请选择一个闹钟");
				}
			break;
			case 26:
				if (depth<get_floor()){
					open_window(-4);
					var e=instance_create_depth(840-500, 525-500, -4, Searchbar);
					e.father = self;
					global.paused = 1;
				}
			break;
			case 27:
				if (father.chose!=-1){
					open_window(-9);
					if (father.chose<2*course_N){
						if (global.access){
							var e=instance_create_depth(840-400, 525-490, -9, CourseInfobar);
							e.tp = 1;
							e.create();
							e.chose = schedule_key_to_id(father.chose);
							e.refresh();
						}else{
							var e = instance_create_depth(840-200, 525-480, -9, CourseInfobar);
							e.chose = schedule_key_to_id(father.chose);
						}
					}else if (father.chose<2*course_N+activity_N){
						var e = instance_create_depth(840-200, 525-440, -9, ActivityInfobar);
						e.chose = schedule_key_to_id(father.chose);
					}else{
						var e = instance_create_depth(840-300, 525-400, -9, TempstuffInfobar);
						e.filename = time_to_filename(key_to_schedule(father.chose));
					    e.state = 0;
						e.checklist[0].refresh();
						e.checklist[1].refresh();
					}
				}else{
					show_message("请选择一条日程");
				}
			break;
			case 28:
				if (instance_exists(CourseInfobar) && global.course._name!=""){
					if (global.course.building<5){
						if (global.course.building!=global.location){
							global.map.go_navigation(global.location, global.course.building);
							global.map.task[1] = global.course._name;
							show_message("地图上已显示导航信息");
							log_create_navigation(global.location, global.course.building);
							father.destroy();
							global.graph.close_graph();
						}else show_message("当前已经处于目标位置");
					}else show_message("该课程为线上课程");
				}else if(instance_exists(ActivityInfobar) && global.activity._name!=""){
					if (global.activity.building!=BUILDING_N){
						if (global.activity.building!=global.location){
							global.map.go_navigation(global.location, global.activity.building);
							global.map.task[1] = global.activity._name;
							show_message("地图上已显示导航信息");
							log_create_navigation(global.location, global.activity.building);
							father.destroy();
							global.graph.close_graph();
						}else show_message("当前已经处于目标位置");
					}else show_message("该活动为线上活动");
				}else if(instance_exists(TempstuffInfobar) && father.filename!=""){
					var tlist = read_tempstuff_info(filename_to_time(father.filename));
					var l = tlist[0];
					var building_list = [1, global.location];
					var b = []; b[BUILDING_N+1] = 0;
					b[global.location] = 1;
					for (var i=1;i<=l;i++){
						if (!b[tlist[i].building]){
							b[tlist[i].building] = 1;
							building_list[++building_list[0]] = tlist[i].building;
						}
					}
					//show_message(building_list);
					if(building_list[0]==1) show_message("当前已经处于目标位置");
					else {
						global.map.tsp_list = TSP(building_list);
						global.map.tsp_step = 1;
						var ll = global.map.tsp_list[0];
						memset(global.map.task, ll, "");
						for (var i=1;i<=l;i++)
							for (var j=1;j<=ll;j++)
								if (global.map.tsp_list[j]==tlist[i].building){
									if (global.map.task[j]=="") global.map.task[j] = tlist[i]._name;
									else global.map.task[j] = global.map.task[j]+"\n" + tlist[i]._name;
								}
						global.map.task[0] = ll;
						global.map.go_tsp_navigation();
						show_message("地图上已显示导航信息");
						log_create_TSP_navigation(global.map.tsp_list);
						father.destroy();
						global.graph.close_graph();
					}
				}
			break;
		}
		state = 0;
	break;
	case 3:
		color = c_black;
	break;
}