#macro course_N 1000 //课程总数

//数据结构：考试
function init_test(_a) constructor{
	week = _a.test_week; day = _a.test_day; time = _a.test_time; len = _a.test_len; edweek=0;
	building = _a.test_building;
	classroom = _a.test_classroom;
	_name= _a._name;
	tp = 0;
}

function init_course() constructor{
	week = 1; day = 0; time = 8; len = 9; edweek = 1; //课程时间
	building = 0; //课程地点和教师
	classroom = 101;
	test_week = 1; test_day = 0; test_time = 8; test_len = 9; //考试时间
	test_building = 0; //考试
	test_classroom = 101;
	_name=""; //课程名
    online_platform = ""; //在线平台与链接
	online_link = ""; 
	tp = 1;
}

function read_course_info(_id){
	var _course = new init_course();
	var p = _id*170;
	_course._name = buffer_peek(global.courseInfo, p, buffer_string);
	_course.week = buffer_peek(global.courseInfo, p+64, buffer_s8);
	_course.edweek = buffer_peek(global.courseInfo, p+65, buffer_s8);
	_course.day = buffer_peek(global.courseInfo, p+66, buffer_s8);
    _course.time = buffer_peek(global.courseInfo, p+67, buffer_s8);
    _course.len = buffer_peek(global.courseInfo, p+68, buffer_s8);
	_course.building = buffer_peek(global.courseInfo, p+69, buffer_s8);
	_course.classroom = buffer_peek(global.courseInfo, p+70, buffer_s16);
	_course.test_week = buffer_peek(global.courseInfo, p+72, buffer_s8);
	_course.test_day = buffer_peek(global.courseInfo, p+73, buffer_s8);
    _course.test_time = buffer_peek(global.courseInfo, p+74, buffer_s8);
    _course.test_len = buffer_peek(global.courseInfo, p+75, buffer_s8);
	_course.test_building = buffer_peek(global.courseInfo, p+76, buffer_s8);
	_course.test_classroom = buffer_peek(global.courseInfo, p+77, buffer_s16);
	_course.online_platform = buffer_peek(global.courseInfo, p+79, buffer_string);
	_course.online_link = buffer_peek(global.courseInfo, p+107, buffer_string);
	return _course;
}

function write_course_info(_course, _id){
	var p = _id*170;
	buffer_poke(global.courseInfo, p, buffer_string, _course._name);
	buffer_poke(global.courseInfo, p+64, buffer_s8, _course.week);
	buffer_poke(global.courseInfo, p+65, buffer_s8, _course.edweek);
	buffer_poke(global.courseInfo, p+66, buffer_s8, _course.day);
	buffer_poke(global.courseInfo, p+67, buffer_s8, _course.time);
	buffer_poke(global.courseInfo, p+68, buffer_s8, _course.len);
	buffer_poke(global.courseInfo, p+69, buffer_s8, _course.building);
	buffer_poke(global.courseInfo, p+70, buffer_s16, _course.classroom);
	buffer_poke(global.courseInfo, p+72, buffer_s8, _course.test_week);
	buffer_poke(global.courseInfo, p+73, buffer_s8, _course.test_day);
	buffer_poke(global.courseInfo, p+74, buffer_s8, _course.test_time);
	buffer_poke(global.courseInfo, p+75, buffer_s8, _course.test_len);
	buffer_poke(global.courseInfo, p+76, buffer_s8, _course.test_building);
	buffer_poke(global.courseInfo, p+77, buffer_s16, _course.test_classroom);
	buffer_poke(global.courseInfo, p+79, buffer_string, _course.online_platform);
	buffer_poke(global.courseInfo, p+107, buffer_string, _course.online_link);
}

function create_coursetable(){
	for (var i=15; i>=0; i--)
		for (var j=6; j>=0; j--)
			for (var k=16; k>=0; k--)
				global.courseTable[i][j][k]=0;
	for (var i=1;i<=global.courseNum;i++){
		var j = global.courseList[i];
		if (j){
			var c = read_course_info(j);
			if (c.test_week) create_schedule_hash(new init_test(c), j);
			create_schedule_hash(c, j);
			if (!global.access){
				for (var p=c.week-1; p<c.edweek; p++)
					for (var k=c.time; k<c.len; k++){
						global.courseTable[p][c.day][k-6]=j;
					}
				if (c.test_week!=0)
					for (var k=c.test_time; k<c.test_len; k++)
						global.courseTable[c.test_week-1][c.test_day][k-6]=j;
			}
		}
	}
}

function get_course_id(){
	for (var i = 1; i<=global.courseNum; i++){
		if (global.courseList[i] == 0) return i;
	}
	return global.courseNum+1;
}

function course_conflict_manage(stu_chose, c, pre){
	//遍历课程列表，检测冲突
	for (var i = 0, j = 1; i<global.courseNum; i++){
		while (global.courseList[j]==0){
			j++;
		}
		//如果有冲突时间，检测对应课程学生是否也选中该门课
		if (c!=global.courseList[j] && is_time_conflict(read_course_info(c), read_course_info(global.courseList[j]))){
			var buff = buffer_load(working_directory + "Courses/" + string(global.courseList[j]) + ".sav");
			var k = buffer_peek(buff, 0, buffer_s32);
			for (var p = 1; p <= k; p++){
				if (stu_chose[buffer_peek(buff, p*4, buffer_s32)]){
					write_course_info(pre, c);
					show_message("该课程与学生 "+ global.studentList[buffer_peek(buff, p*4, buffer_s32)] +" 所选课程 "+ buffer_peek(global.courseInfo, 170*global.courseList[j], buffer_string) +" 时间冲突");
					return 0;
				}
			}
			buffer_delete(buff);
		}
		j++;
	}
	return 1;
}

//从学生的课程列表中删除一门课
function course_delete_stu(_buff, _c){
	var l = buffer_peek(_buff, 0, buffer_s32);
	for (var i = 1; i<=l; i++){
		if (buffer_peek(_buff, i*4, buffer_s32)==_c){
			buffer_poke(_buff, i*4, buffer_s32, buffer_peek(_buff, 4*l, buffer_s32));
			buffer_poke(_buff, l*4, buffer_s32, 0);
			buffer_poke(_buff, 0, buffer_s32, l-1);
			break;
		}
	}
}

function save_courselist(){
	var buff_list=buffer_create(1024, buffer_grow, 4);
	buffer_write(buff_list, buffer_s32, global.courseNum);
	for (var i = 0, j = 1; i<global.courseNum; j++){
		buffer_write(buff_list, buffer_s32, global.courseList[j]);
		if (global.courseList[j] != 0) i++;
	}
	buffer_save(buff_list, working_directory + "course_list.sav");
	buffer_delete(buff_list);
}

function student_course_add(stu_chose, c){
	var buff = buffer_create(1000, buffer_grow, 4);
	buffer_fill(buff, 4, buffer_grow, 0, 1000);
	var s = 1;
	for (var i = 1; i<=global.studentNum; i++){
		if (stu_chose[i]){
			buffer_poke(buff, 4*s, buffer_s32, i);
			s++;
		}
	}
	buffer_poke(buff, 0, buffer_s32, s-1);
	buffer_save(buff, working_directory + "Courses/" + string(c) + ".sav");
	buffer_delete(buff);
	
	for (var i = 1; i<=global.studentNum; i++){
		if (stu_chose[i]==1){
		//读取选课学生的课程列表
			var buff = buffer_load(working_directory + "Users/" + global.studentList[i] + "/course.sav");
			var course_n = buffer_peek(buff, 0, buffer_s32);
			var j=1;
			while (buffer_peek(buff,4*j,buffer_s32)!=0){
				j++;
			}
			buffer_poke(buff, 4*j, buffer_s32, c);
			buffer_poke(buff, 0, buffer_s32, course_n+1);
			buffer_save(buff, working_directory + "Users/" + global.studentList[i] + "/course.sav");
			buffer_delete(buff);
		}
	}
}

//更新学生选课列表和课程对应的学生列表
function student_course_update(stu_chose, c){
	//更新课程的选课学生列表
	var buff = buffer_load(working_directory + "Courses/" + string(c) + ".sav");
	var l = buffer_peek(buff, 0, buffer_s32);
	var pre_chose = [];
	pre_chose[global.studentNum] = 0;
	for (var i = 1; i<=l; i++){
		pre_chose[buffer_peek(buff, 4*i, buffer_s32)] = 1;
	}
	var s = 1;
	for (var i = 1; i<=global.studentNum; i++){
		if (stu_chose[i]){
			buffer_poke(buff, 4*s, buffer_s32, i);
			s++;
		}
	}
	buffer_poke(buff, 0, buffer_s32, s-1);
	buffer_save(buff, working_directory + "Courses/" + string(c) + ".sav");
	buffer_delete(buff);
	//更新学生选课列表
	for (var i = 1; i<=global.studentNum; i++){
		//读取选课学生的课程列表
		var buff = buffer_load(working_directory + "Users/" + global.studentList[i] + "/course.sav");
		var course_n = buffer_peek(buff, 0, buffer_s32);
		if (stu_chose[i]==1 && pre_chose[i]==0){
			var j=1;
			while (buffer_peek(buff,4*j,buffer_s32)!=0){
				j++;
			}
			buffer_poke(buff, 4*j, buffer_s32, c);
			buffer_poke(buff, 0, buffer_s32, course_n+1);
		}else if(stu_chose[i]==0 && pre_chose[i]==1){
			//从学生选课列表中删除该门课程
			course_delete_stu(buff, c);
		}
		buffer_save(buff, working_directory + "Users/" + global.studentList[i] + "/course.sav");
		buffer_delete(buff);
	}
}