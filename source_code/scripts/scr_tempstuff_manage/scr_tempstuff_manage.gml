#macro temp_N 2001 //临时事务总数
#macro temp_MAX 10 //每个时段最多的临时事务数

function init_tempstuff() constructor{
	building = 0; //地点
	classroom = 101; 
	week = 1; day = 0; time = 6; edweek = 0; len = 7; //时间
	isalarm = 0; //是否提醒
	_name=""; //名称
	tp = 4;
	_id = 0;
}

function read_tempstuff(_buff, _id){
	var temp = new init_tempstuff();
	var d = 72*_id;
	temp._name = buffer_peek(_buff, d, buffer_string);
	temp.week = buffer_peek(_buff, d+48, buffer_s32);
	temp.day = buffer_peek(_buff, d+52, buffer_s32);
	temp.time = buffer_peek(_buff, d+56, buffer_s32);
	temp.building = buffer_peek(_buff, d+60, buffer_s32);
	temp.classroom = buffer_peek(_buff, d+64, buffer_s32);
	temp.isalarm = buffer_peek(_buff, d+68, buffer_s32);
	temp.edweek = temp.week;
	temp.len = temp.time+1;
	return temp;
}

function write_tempstuff_info(tlist, _filename){
	var buff = buffer_load(_filename);
	buffer_poke(buff, 0, buffer_s32, tlist[0]);
	for (var i = 1; i<=tlist[0]; i++){
		var d = 72*i;
		buffer_poke(buff, d, buffer_string, tlist[i]._name);
		buffer_poke(buff, d+48, buffer_s32, tlist[i].week);
		buffer_poke(buff, d+52, buffer_s32, tlist[i].day);
		buffer_poke(buff, d+56, buffer_s32, tlist[i].time);
		buffer_poke(buff, d+60, buffer_s32, tlist[i].building);
		buffer_poke(buff, d+64, buffer_s32, tlist[i].classroom);
		buffer_poke(buff, d+68, buffer_s32, tlist[i].isalarm);
	}
	buffer_save(buff, _filename);
	buffer_delete(buff);
}

function tempstuff_conflict_detection(_t, _tp){
	var _week = _t.week;
	var _day = _t.day;
	var _time = _t.time;
	if (_tp == 0) return global.courseTable[_week-1][_day][_time-6];
	else if (global.activityTable[_week-1][_day][_time-6]<temp_N) return global.activityTable[_week-1][_day][_time-6];
	return 0;
}

function filename_to_time(_filename){
	var l = string_length(_filename);
	var time = [];
	for (var j = 1, k = 0, p = 1; j<=l+1; j++){
		if (j>l || string_char_at(_filename,j)=="_"){
			time[k] = real(string_copy(_filename, p, j-p));
			k++;
			p=j+1;
		}
	}
	return (new init_time(time[0], time[1], time[2]));
}

function tempstuff_copy(_t){
	var p = new init_tempstuff();
	p.week = _t.week;
	p.day = _t.day;
	p.time = _t.time;
	p._name = _t._name;
	p.building = _t.building;
	p.classroom = _t.classroom;
	p._id = _t._id;
	p.isalarm = _t.isalarm;
	return p;
}

function tempstuff_list_add(_t){
	for (var i=0;i<temp_N;i++){
		global.tempstuffPointer++;
		if (global.tempstuffPointer==temp_N) global.tempstuffPointer = 0;
		if (global.tempstuffList[global.tempstuffPointer]==noone){
			_t._id = global.tempstuffPointer;
			global.tempstuffList[global.tempstuffPointer] = tempstuff_copy(_t);
			return 1;
		}
	}
	//临时事务数量达到上限，返回0
	return 0;
}

function tempstuff_list_update(_t, _id){
	_t._id = _id;
	global.tempstuffList[_id] = tempstuff_copy(_t);
}

function tempstuff_list_delete(_t){
	global.tempstuffList[_t._id] = noone;
}

function create_tempstufflist(){
	var _filename = file_find_first(working_directory + "Users/" + global.student + "/tempstuff/*.sav", 0);
	while (_filename != ""){
		_filename = string_copy(_filename, 1, string_length(_filename)-4);
		var tlist = [];
		var buff = buffer_load(working_directory + "Users/" + global.student + "/tempstuff/" + _filename + ".sav");
		var l = buffer_peek(buff, 0, buffer_s32);
		tlist[0] = l;
		var t = filename_to_time(_filename);
		var a = time_to_int(t);
		var linklist = global.tempstuffHash.get(a);
		if (linklist==noone) linklist = global.tempstuffHash.set(a, new init_linklistHead());
		for (var i = 1; i<=l; i++){
			tlist[i] = read_tempstuff(buff, i);
			tempstuff_list_add(tlist[i]);
			linklist.insert(tlist[i]._id);
			create_schedule_hash(tlist[i], tlist[i]._id);
		}
		buffer_delete(buff);
		update_activitytable(new init_time(t.week, t.day, t.time), temp_N);
		_filename = file_find_next();
	}
	file_find_close();
}

function read_tempstuff_info(_a){
	var k = time_to_int(_a);
	var linklist = global.tempstuffHash.get(k);
	if (linklist==noone) linklist = global.tempstuffHash.set(k, new init_linklistHead());
	var tlist = [0];
	while (linklist.next!=noone){
		linklist = linklist.next;
		tlist[++tlist[0]] = tempstuff_copy(global.tempstuffList[linklist.data]);
	}
	return tlist;
}

function insert_tempstuff(_t){
	if (!tempstuff_list_add(_t)) return 0;
	var a = time_to_int(_t);
	var linklist = global.tempstuffHash.get(a);
	if (linklist==noone) linklist = global.tempstuffHash.set(a, new init_linklistHead());
	if (linklist.len>=temp_MAX) return -1;
	linklist.insert(_t._id);
	update_activitytable(_t, temp_N);
	create_schedule_hash(_t, _t._id);
	var tlist = read_tempstuff_info(_t);
	//show_message(tlist);
	if (!file_exists(working_directory + "Users/" + global.student + "/tempstuff/" + time_to_filename(_t) + ".sav")){
		var _buff = buffer_create(800, buffer_grow, 4);
		for (var i = 0; i<200; i++) buffer_write(_buff, buffer_s32, 0);
		buffer_save(_buff, working_directory + "Users/" + global.student + "/tempstuff/" + time_to_filename(_t) + ".sav");
		buffer_delete(_buff);
	}
	write_tempstuff_info(tlist, working_directory + "Users/" + global.student + "/tempstuff/" + time_to_filename(_t)+".sav");
	return 1;
}

function tempstuff_delete(_filename, _i){
	var tlist = [];
	tlist = read_tempstuff_info(filename_to_time(_filename));
	var _t = tlist[_i];
	delete_schedule_hash(_t, _t._id);
	var linklist = global.tempstuffHash.get(time_to_int(filename_to_time(_filename)));
	linklist.remove(_t._id);
	tempstuff_list_delete(_t);
	var l = tlist[0];
	for (var i = _i; i<l; i++){
		tlist[i] = tlist[i+1];
	}
	tlist[0]--;
	if (l==1){
		update_activitytable(_t, 0);
		file_delete(working_directory + "Users/" + global.student + "/tempstuff/" + _filename +".sav");
	}else{
		write_tempstuff_info(tlist, working_directory + "Users/" + global.student + "/tempstuff/" + _filename +".sav");
	}
}