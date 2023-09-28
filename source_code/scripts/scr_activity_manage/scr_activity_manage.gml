#macro activity_N 2000 //活动总数

function init_activity() constructor{
	week = 1; day = 0; time = 6; len = 7; edweek = 1; 
	building = 0;  
	classroom = 101; 
	isalarm = 0; 
	tp = 3; //3为个人活动 2为集体活动
	_name=""; 
    online_platform = ""; 
	online_link = ""; 
}

function read_activity_info(_id){
	var _act = new init_activity();
	var p = _id*180;
	_act._name = buffer_peek(global.activityInfo, p, buffer_string);
	_act.week = buffer_peek(global.activityInfo, p+48, buffer_s16);
	_act.edweek = buffer_peek(global.activityInfo, p+50, buffer_s16);
	_act.day = buffer_peek(global.activityInfo, p+52, buffer_s32);
    _act.time = buffer_peek(global.activityInfo, p+56, buffer_s32);
    _act.building = buffer_peek(global.activityInfo, p+60, buffer_s32);
	_act.classroom = buffer_peek(global.activityInfo, p+64, buffer_s32);
	_act.isalarm = buffer_peek(global.activityInfo, p+68, buffer_s32);
	_act.tp = buffer_peek(global.activityInfo, p+72, buffer_s32);
    _act.online_platform = buffer_peek(global.activityInfo, p+76, buffer_string);
    _act.online_link = buffer_peek(global.activityInfo, p+108, buffer_string);
	_act.len = _act.time+1;
	return _act;
}

function write_activity_info(_act, _id){
	var p = _id*180;
	buffer_poke(global.activityInfo, p, buffer_string, _act._name);
	buffer_poke(global.activityInfo, p+48, buffer_s16, _act.week);
	buffer_poke(global.activityInfo, p+50, buffer_s16, _act.edweek);
	buffer_poke(global.activityInfo, p+52, buffer_s32, _act.day);
	buffer_poke(global.activityInfo, p+56, buffer_s32, _act.time);
	buffer_poke(global.activityInfo, p+60, buffer_s32, _act.building);
	buffer_poke(global.activityInfo, p+64, buffer_s32, _act.classroom);
	buffer_poke(global.activityInfo, p+68, buffer_s32, _act.isalarm);
	buffer_poke(global.activityInfo, p+72, buffer_s32, _act.tp);
	buffer_poke(global.activityInfo, p+76, buffer_string, _act.online_platform);
	buffer_poke(global.activityInfo, p+108, buffer_string, _act.online_link);
}

function update_activitytable(_a, _v){
	var _day=_a.day, _time=_a.time;
	for (var p=_a.week-1; p<_a.edweek; p++){
		if (_day<7) global.activityTable[p][_day][_time-6]=_v;
		else if (_day==7){
			for (var t=0; t<7; t++) global.activityTable[p][t][_time-6]=_v;
		}else if (_day==8){
			for (var t=0; t<5; t++) global.activityTable[p][t][_time-6]=_v;
		}else if (_day==9){
			for (var t=5; t<7; t++) global.activityTable[p][t][_time-6]=_v;
		}
	}
}

//将活动信息加载到课表
function create_activitytable(){
	for (var i=15; i>=0; i--)
		for (var j=6; j>=0; j--)
			for (var k=16; k>=0; k--)
				global.activityTable[i][j][k]=0;
	for (var i=1;i<activity_N;i++){
		var j = global.activityList[i];
		if (j){
			var a = read_activity_info(j);
			create_schedule_hash(a, j);
			update_activitytable(a, j);
		}
	}
}

function save_activityInfo(){
	buffer_save(global.activityInfo, working_directory + "Users/" + global.student + "/info.sav");
}

function get_activity_id(){
	for (var i = 1; i<=global.activityNum; i++){
		if (global.activityList[i] == 0) return i;
	}
	return global.activityNum+1;
}

function update_activitylist(_id){
	global.activityList[0]++;
	global.activityList[_id] = _id;
	global.activityNum++;
}

function save_activityList(){
	file_write(activity_N*4, global.activityList, buffer_s32, activity_N, 4, working_directory + "Users/" + global.student + "/activity.sav");
}

function delete_activity(_id){
	global.activityList[_id] = 0;
	global.activityList[0] --;
	global.activityNum--;
}

function activity_conflict_detection(_a, _tp, _self){
	var _week = _a.week;
	var _day = _a.day;
	var _time = _a.time;
	var _table;
	if (_tp == 0) _table = global.courseTable;
	else _table = global.activityTable;
	for (var p=_week-1; p<_a.edweek; p++){
		if (_day<7){
			if (_table[p][_day][_time-6]  && _table[p][_day][_time-6]!=_self) return _table[p][_day][_time-6];
		}else if (_day==7){
			for (var t=0; t<7; t++) if (_table[p][t][_time-6] && _table[p][t][_time-6]!=_self) return _table[p][t][_time-6];
		}else if (_day==8){
			for (var t=0; t<5; t++) if (_table[p][t][_time-6] && _table[p][t][_time-6]!=_self) return _table[p][t][_time-6];
		}else if (_day==9){
			for (var t=5; t<7; t++) if (_table[p][t][_time-6] && _table[p][t][_time-6]!=_self) return _table[p][t][_time-6];
		}
	}
	return 0;
}

//集体活动自动排期
function activity_conflict_solution(_a, _self){
	var count = []; //下标为小时，为当小时的冲突数
	for (var i = 15; i>=0; i--) count[i] = 0;
	var _day = _a.day;
	for (var _time = 6; _time<22; _time++){
		for (var p=_a.week-1; p<_a.edweek; p++){
			if (_day<7){
				if (global.courseTable[p][_day][_time-6]) count[_time-6]++;
			}else if (_day==7){
				for (var t=0; t<7; t++) if (global.courseTable[p][t][_time-6]) count[_time-6]++;
			}else if (_day==8){
				for (var t=0; t<5; t++) if (global.courseTable[p][t][_time-6]) count[_time-6]++;
			}else if (_day==9){
				for (var t=5; t<7; t++) if (global.courseTable[p][t][_time-6]) count[_time-6]++;
			}
		}
		for (var p=_a.week-1; p<_a.edweek; p++){
			if (_day<7){
				if (global.activityTable[p][_day][_time-6] && global.activityTable[p][_day][_time-6]!=_self) count[_time-6]++;
			}else if (_day==7){
				for (var t=0; t<7; t++) if (global.activityTable[p][t][_time-6] && global.activityTable[p][t][_time-6]!=_self) count[_time-6]++;
			}else if (_day==8){
				for (var t=0; t<5; t++) if (global.activityTable[p][t][_time-6] && global.activityTable[p][t][_time-6]!=_self) count[_time-6]++;
			}else if (_day==9){
				for (var t=5; t<7; t++) if (global.activityTable[p][t][_time-6] && global.activityTable[p][t][_time-6]!=_self) count[_time-6]++;
			}
		}
	}
	//寻找冲突最少的三个时间
	var minn = 17;
	var an = []; //返回的时间列表
	for (var i = 17; i>=0; i--) an[i] = 0;
	for (var i = 0; i<16; i++){
		if (count[i]<minn){
			minn = count[i];
			an[0] = 1;
			an[1] = i + 6;
		}else if(count[i]==minn){
			an[++an[0]] = i + 6;
		}
	}
	//min为最小冲突数
	an[an[0]+1] = minn;
	return an;
}

function activity_conflict_manage(_self){
	var cf = activity_conflict_detection(global.activity, 0, 0);
	var af = activity_conflict_detection(global.activity, 1, _self);
	if (cf){
		var solution = [];
		solution = activity_conflict_solution(global.activity, 0);
		var busy = solution[solution[0]+1];
		if (!busy){
			if (solution[0]>=3){
				show_message("该活动与课程 " + read_course_info(cf)._name + " 冲突，\n推荐以下时间段：\n" + string(solution[1]) + ":00\n" + string(solution[real((solution[0]+1)/2)]) + ":00\n" + string(solution[solution[0]]) + ":00\n");
					}else if (solution[0]==2){
				show_message("该活动与课程 " + read_course_info(cf)._name + " 冲突，\n推荐以下时间段：\n" + string(solution[1]) + ":00\n" + string(solution[2]) + ":00\n");
			}else{
				show_message("该活动与课程 " + read_course_info(cf)._name + " 冲突，\n推荐以下时间段：\n" + string(solution[1]) + ":00\n");
			}
		}else{
			if (global.activity.tp == 3){
				show_message("该日无可用时间段");
			}else{
				if (solution[0]>=3){
					show_message("该日无可用时间，冲突最少的时间段：\n" + string(solution[1]) + ":00\n" + string(solution[real((solution[0]+1)/2)]) + ":00\n" + string(solution[solution[0]]) + ":00\n");
				}else if (solution[0]==2){
					show_message("该日无可用时间，冲突最少的时间段：\n" + string(solution[1]) + ":00\n" + string(solution[2]) + ":00\n");
				}else{
					show_message("该日无可用时间，冲突最少的时间段：\n" + string(solution[1]) + ":00\n");
				}
			}
		}
	}else if(af){
		var solution = activity_conflict_solution(global.activity, 0);
		var busy = solution[solution[0]+1];
		if (!busy){
			var name;
			if (af!=temp_N) name = "活动 " + read_activity_info(af)._name;
			else name = "临时事务";
			if (solution[0]>=3){
				show_message("该活动与" + name + " 冲突，\n推荐以下时间段：\n" + string(solution[1]) + ":00\n" + string(solution[real((solution[0]+1)/2)]) + ":00\n" + string(solution[solution[0]]) + ":00\n");
			}else if (solution[0]==2){
				show_message("该活动与" + name + " 冲突，\n推荐以下时间段：\n" + string(solution[1]) + ":00\n" + string(solution[2]) + ":00\n");
			}else{
				show_message("该活动与" + name + " 冲突，\n推荐以下时间段：\n" + string(solution[1]) + ":00\n");
			}
		}else{
			if (global.activity.tp == 3){
				show_message("该日无可用时间段");
			}else{
				if (solution[0]>=3){
					show_message("该日无可用时间，冲突最少的时间段：\n" + string(solution[1]) + ":00\n" + string(solution[real((solution[0]+1)/2)]) + ":00\n" + string(solution[solution[0]]) + ":00\n");
				}else if (solution[0]==2){
					show_message("该日无可用时间，冲突最少的时间段：\n" + string(solution[1]) + ":00\n" + string(solution[2]) + ":00\n");
				}else{
					show_message("该日无可用时间，冲突最少的时间段：\n" + string(solution[1]) + ":00\n");
				}
			}
		}
	}else{
		return 1;
	}
	return 0;
}