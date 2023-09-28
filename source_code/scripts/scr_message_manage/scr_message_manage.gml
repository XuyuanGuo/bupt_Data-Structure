function create_message(_str, _len, _font){
	var e = instance_create_depth(840-400, 525-450, -15, Infobar);
	e.str = _str;
	e.len = _len;
	e.font = _font;
	open_window(-15);
	global.paused = 1;
}

function create_daily_message(str, l, font){
	//课程提醒
	font[l] = 1;
	str[l++] = "今日课程:";
	var t = l;
	for (var i = 0; i < 17; i++){
		var c = global.courseTable[global.week-1][global.day][i];
		if (c){
			var course = read_course_info(c);
			str[l++] = string(i+6) + ":00 " + course._name;
		}
	}
	if (l==t) str[l++] = "无";
	font[l] = 1;
	str[l++] = "今日活动:";
	t=l;
	for (var i = 0; i < 17; i++){
		var a = global.activityTable[global.week-1][global.day][i];
		if (a && a!=temp_N){
			var act = read_activity_info(a);
			str[l++] = string(i+6) + ":00 " + act._name;
		}
	}
	if (l==t) str[l++] = "无";
	return l;
}

function create_course_message(str, l, font){
	if (global.hour+global.Remind_time>=7 && global.hour+global.Remind_time<20){
		var c = global.courseTable[global.week-1][global.day][global.hour-5+global.Remind_time];
		if (c && c!=global.courseTable[global.week-1][global.day][global.hour-6+global.Remind_time]){
			var course = read_course_info(c);
			font[l] = 1;
			if (!is_time_conflict(new init_time(global.week, global.day, global.hour+1+global.Remind_time),new init_test(course))) str[l++] = "课程将要开始:";
			else str[l++] = "考试将要开始:";
			str[l++] = string(global.hour+1+global.Remind_time) + ":00 " + course._name;
			if (course.building<5){
				str[l++] = "地点: " + global.sites[course.building] + string(course.classroom);
			}
			if (course.online_platform!=""){
				str[l++] = "线上平台: " + course.online_platform;
				str[l++] = "线上链接: " + course.online_link;
			}
			if (course.building<5){
				if (course.building!=global.location){
					global.map.go_navigation(global.location, course.building);
					global.map.task[1] = course._name;
				}
			}
		}
	}
	return l;
}

function create_activity_message(str, l, font){
	if (global.hour+global.Remind_time>=5 && global.hour+global.Remind_time<22){
		var a = global.activityTable[global.week-1][global.day][global.hour-5+global.Remind_time];
		if (a){
			if (a!=temp_N){
				var act = read_activity_info(a);
				if (act.isalarm){
					font[l] = 1;
					str[l++] = "活动将要开始:";
					str[l++] = string(global.hour+1+global.Remind_time) + ":00 " + act._name;
					if (act.building<5) str[l++] = "地点: " + global.sites[act.building] + string(act.classroom);
					else str[l++] = "地点: " + global.sites[act.building];
					if (act.online_platform!=""){
						str[l++] = "线上平台: " + act.online_platform;
						str[l++] = "线上链接: " + act.online_link;
					}
					if (act.building!=BUILDING_N){
						if (act.building!=global.location){
							global.map.go_navigation(global.location, act.building);
							global.map.task[1] = act._name;
						}
					}
				}
			}else{
				//var w=global.week, d=global.day, h=global.hour+1;
				var tlist = [];
				//var ee = new init_time(w, d, h)
				tlist = read_tempstuff_info(filename_to_time(time_to_filename(new init_time(global.week,global.day,global.hour+1+global.Remind_time))));
				var q = tlist[0];
				//show_message(q);
				var flag = 0;
				for (var i = 1; i<=q; i++){
					//show_message(tlist[i]._name +"  "+ string(tlist[i].isalarm));
					if (tlist[i].isalarm==1){
						if (!flag){
							font[l] = 1;
							str[l++] = "临时事务将要开始:";
							flag = 1;
						}
						str[l++] = tlist[i]._name;
						str[l++] = "地点: " + global.sites[tlist[i].building];
					}
				}
				if (!flag) return l;
				//show_message("no");
				var building_list = [1, global.location];
				var b = []; b[BUILDING_N+1] = 0;
				b[global.location] = 1;
				for (var i=1;i<=q;i++){
					if (!b[tlist[i].building]){
						b[tlist[i].building] = 1;
						building_list[++building_list[0]] = tlist[i].building;
					}
				}
				if(building_list[0]!=1){
					global.map.tsp_list = TSP(building_list);
					global.map.tsp_step = 1;
					var ll = global.map.tsp_list[0];
					memset(global.map.task, ll, "");
					for (var i=1;i<=q;i++)
						for (var j=1;j<=ll;j++)
							if (global.map.tsp_list[j]==tlist[i].building){
								if (global.map.task[j]=="") global.map.task[j] = tlist[i]._name;
								else global.map.task[j] = global.map.task[j]+"\n" + tlist[i]._name;
							}
					global.map.task[0] = ll;
					global.map.go_tsp_navigation();
					
					var str2 = "导航：" + global.sites[global.map.tsp_list[1]];
					for (var i=2;i<=ll;i++){
						str2 = str2 + " -> " + global.sites[global.map.tsp_list[i]];
					}
					str2 = str2 + " -> " + global.sites[global.map.tsp_list[1]];
					str[l++] = str2;
				}
			}
		}
	}
	return l;
}