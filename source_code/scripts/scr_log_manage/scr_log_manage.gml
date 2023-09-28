// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
//0 系统提醒  1 添加课程 2 删除课程 3 更改课程信息 4 添加活动 5 更改活动信息 6 删除活动 7 添加临时事务 8 更改临时事务信息 9 删除临时事务 10 设置闹钟 11 删除闹钟 12 查询结果 13 导航信息

function log_update(_str){
	var file = file_text_open_append(working_directory + "Users/" + global.student + "/log/" + string(global.week) + "_" + string(global.day) +".txt");
	if (!global.log_created){
		var str;
		if (global.hour<10) str = "0"+string(global.hour)+":00";
		else str = string(global.hour)+":00";
		file_text_write_string(file, str);
		file_text_writeln(file);
		global.log_created = 1;
	}
    file_text_write_string(file, _str);
	file_text_writeln(file);
	file_text_close(file);
}

function log_create_courseadd(_a){
	var str = "添加课程："+ _a._name + " " + time_to_text(_a) + " " + place_to_text(_a);
	log_update(str);
}

function log_create_coursedelete(_a){
	var str = "删除课程："+ _a._name + " " + time_to_text(_a) + " " + place_to_text(_a);
	log_update(str);
}

function log_create_courseupdate(_a){
	var str = "更新课程信息："+ _a._name + " " + time_to_text(_a) + " " + place_to_text(_a);
	log_update(str);
}

function log_create_activityadd(_a){
	var str = "添加活动："+ _a._name + " " + time_to_text(_a) + " " + place_to_text(_a);
	log_update(str);
}

function log_create_activitydelete(_a){
	var str = "删除活动："+ _a._name + " " + time_to_text(_a) + " " + place_to_text(_a);
	log_update(str);
}

function log_create_activityupdate(_a){
	var str = "更新活动信息："+ _a._name + " " + time_to_text(_a) + " " + place_to_text(_a);
	log_update(str);
}

function log_create_tempstuffinsert(_a){
	var str = "添加临时事务："+ _a._name + " " + time_to_text(_a) + " " + place_to_text(_a);
	log_update(str);
}

function log_create_tempstuffdelete(_a){
	var str = "删除临时事务："+ _a._name + " " + time_to_text(_a) + " " + place_to_text(_a);
	log_update(str);
}

function log_create_tempstuffupdate(_a){
	var str = "更新临时事务信息："+ _a._name + " " + time_to_text(_a) + " " + place_to_text(_a);
	log_update(str);
}

function log_create_tempstufftimedelete(_str){
	var str = "删除了 "+ _str + " 的所有临时事务";
	log_update(str);
}
function log_create_clockadd(_str){
	var str = "添加闹钟："+ _str;
	log_update(str);
}

function log_create_clockdelete(_str){
	var str = "删除闹钟："+ _str;
	log_update(str);
}

function log_create_clockupdate(_str){
	var str = "更新闹钟信息："+ _str;
	log_update(str);
}

function log_create_message(_str, l){
	var str = "\"";
	for (var i=0;i<l;i++){
		str = str + " " + _str[i];
	}
	str = str + " \"";
	log_update(str);
}

function log_create_search(_str, _str2, l){
	var str = "日程搜索：\"" + _str2 + "\", 结果：\n";
	for (var i=0;i<l;i++){
		if (i!=0) str = str + ",\n " + _str[i];
		else str = str + " " + _str[i];
	}
	log_update(str);
}

function log_create_navigation(_a, _b){
	var str = "导航：" + global.sites[_a] + " -> " + global.sites[_b];
	log_update(str);
}

function log_create_TSP_navigation(_a){
	var l = _a[0];
	var str = "导航：" + global.sites[_a[1]];
	for (var i=2;i<=l;i++){
		str = str + " -> " + global.sites[_a[i]];
	}
	str = str + " -> " + global.sites[_a[1]];
	log_update(str);
}
