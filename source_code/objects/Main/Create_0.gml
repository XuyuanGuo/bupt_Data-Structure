/// @description Insert description here
// You can write your code in this editor
global.paused = 0;
global.timepaused = 0;

/*global.Hash = [];
global.Hash[hash_N] = new init_hashNode();*/

var buff_info = buffer_load(working_directory + "system_info.sav");
global.time = buffer_read(buff_info, buffer_s16);
global.hour = buffer_read(buff_info, buffer_s16);
global.day = buffer_read(buff_info, buffer_s16);
global.week = buffer_read(buff_info, buffer_s16);
buffer_delete(buff_info);

//学生身份为0，管理员身份为1
var buff_data = buffer_load(working_directory + "Users/" + global.student + "/data.sav");
global.access = buffer_read(buff_data, buffer_s32);
global.spd = buffer_read(buff_data, buffer_s32);
global.location = buffer_read(buff_data, buffer_s32);
buffer_delete(buff_data);

global.studentList = noone;
global.studentNum = 0;
//加载课程信息
global.courseList = noone;
global.courseTable = noone;
global.course = new init_course();

global.activityNum = 0;
global.activityList = [];
global.activityList[1024] = 0;
global.activityInfo = noone;
global.activityTable = noone;
global.activity = new init_activity();

global.clockList = [];
global.clockTable = [];

var buff_list;
if (global.access == 1){
	//加载学生列表
	var buff_stu = buffer_load(working_directory + "student_list.sav");
	global.studentNum = buffer_peek(buff_stu, 0, buffer_s32);
	for (var i = 1; i<=global.studentNum; i++){
		global.studentList[i] = buffer_peek(buff_stu, 64*i, buffer_string);
		//show_message(global.studentList[i]);
	}
	buffer_delete(buff_stu);
	
	buff_list = buffer_load(working_directory + "course_list.sav");
}else{
	//加载学生课程信息
	buff_list = buffer_load(working_directory + "Users/" + global.student + "/course.sav");
}
global.courseNum = buffer_read(buff_list, buffer_s32);

//生成课程列表
global.courseList[1024] = 0;
for (var i = 0, j = 1; i<global.courseNum; j++){
	global.courseList[j]=buffer_read(buff_list, buffer_s32);
	if (global.courseList[j]!=0) i++;
}
buffer_delete(buff_list);

global.courseInfo = buffer_load(working_directory + "course_info.sav");

//加载活动信息
global.activityInfo = buffer_load(working_directory + "Users/" + global.student + "/info.sav");
//生成活动列表
var buff_act = buffer_load(working_directory + "Users/" + global.student + "/activity.sav");
global.activityNum = buffer_peek(buff_act, 0, buffer_s32);
//show_message(global.activityNum);
for (var i = 0; i<activity_N; i++){
	global.activityList[i] = buffer_peek(buff_act, 4*i, buffer_s32);
}
buffer_delete(buff_act);
	
//加载闹钟信息
var buff_clk = buffer_load(working_directory + "Users/" + global.student + "/clock.sav");
global.clockList = file_read(buff_clk, global.clockList, buffer_s32, 12*1023, 4);
global.clockList[0] = buffer_peek(buff_clk, 0, buffer_s32);
//show_message(global.clockList[0]);
buffer_delete(buff_clk);

global.tempstuffList = [];
memset(global.tempstuffList, temp_N-1, -4);
global.tempstuffPointer = 0;
global.tempstuffHash = new init_hashmap(hash_N2);
global.tempstuff = new init_tempstuff();

global.search_hash = new init_hashmap(hash_N);

create_coursetable();
create_activitytable();
create_clocktable();
create_tempstufflist();

global.graph = instance_create_depth(0, 0, 0, Graph);
global.in_graph = 0;

button = [];
button[4] = instance_create_depth(1610, 55, -1, Setting);
button[3] = instance_create_depth(1510, 55, -1, Log);
button[2] = instance_create_depth(1410, 55, -1, Skip);
instance_create_textlabel(30, 10, 370, 180, 0.7, 2, "");
button[0] = instance_create_button(450, 20, 200, 70, 0.95, 6, "查看课表", self);
button[1] = instance_create_button(760, 20, 200, 70, 0.95, 26, "日程查询", self);

//加载地图信息
global.map = instance_create_depth(0, 0, 30, Map);
global.building_point =[];
global.navi_path = [0];
global.navipoint = [];
global.entrance = [[]];
global.mappoint_dis = [[]];
global.in_navi = 0;
map_init();

global.log_created = 0;

global.Remind_time = 0;
/*var l = new init_linklistHead();
l.insert(3);
l.insert(5);
l.insert(6);
show_message(l.next.data);
show_message(l.next.next.data);
show_message(l.next.next.next.data);
l.remove(5);
l.insert(-1);
show_message(l.next.data);
show_message(l.next.next.data);
show_message(l.next.next.next.data);
/*var h=new init_hashmap(hash_N);
h.set(12345, 2);
h.set(123, 1);
show_message(h.get(123));
show_message(h.get(12345));
h.set(123, 3);
h.set(12345, 4);
show_message(h.get(123));
show_message(h.get(12345));
h.remove(12345);
show_message(h.get(123));
show_message(h.get(12345));*/
/*var l = [0,9, 3, 5, 7, 2, 8.6, 5, 6 ,5];
qsort(l, 1, 9, 0);
for (var i=1;i<=9;i++){
	show_message(l[i]);
}*/
