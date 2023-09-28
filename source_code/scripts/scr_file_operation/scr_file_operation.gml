//从一个缓冲区把数据读到数组中
//参数 1 buffer 缓冲区  2 list 返回的数组  3 缓冲区数据类型  4 real 缓冲区长度，字节为单位  5 real 数组间隔，以字节为单位
function file_read(_buff, _des, _tp, _n, _d){
	_des[_n] = noone;
	_des[0] = _n;
	for (var i = 1; i<=_n; i++){
		_des[i] = buffer_peek(_buff, i*_d, _tp);
	}
	return _des;
}
//吧一个数组的数据写入缓冲区中，并将缓冲区写入文件
//参数 1 real 缓冲区大小  2 list 数据源数组  3 缓冲区数据类型  4 real 缓冲区长度，字节为单位  5 real 数组间隔，以字节为单位  6 string 文件地址
function file_write(_size, _res, _tp, _n, _d, _ad){
	var _buff = buffer_create(_size, buffer_fixed, (_tp==buffer_string)?(1):(4));
	for (var i = 0; i<=_n; i++){
		 buffer_poke(_buff, i*_d, _tp, _res[i]);
	}
	buffer_save(_buff, _ad);
	buffer_delete(_buff);
}
//用户注册
//参数：1 string 用户名  2 string 密码
function user_register(str1, str2){
	if (directory_exists(working_directory + "Users/" + str1)){
		show_message("该用户已存在，请重新输入学号");
	}else{
		directory_create(working_directory + "Users/" + str1);
		directory_create(working_directory + "Users/" + str1 + "/log");
		directory_create(working_directory + "Users/" + str1 + "/tempstuff");
						
		var buff_pass = buffer_create(128, buffer_fixed, 1);
		buffer_write(buff_pass, buffer_string, str2);	
		buffer_save(buff_pass, working_directory + "Users/" + str1 + "/password.sav");
		buffer_delete(buff_pass);
						
		var buff_data = buffer_create(256, buffer_fixed, 4);
		buffer_write(buff_data, buffer_s32, 0);	
		buffer_write(buff_data, buffer_s32, 6);
		buffer_write(buff_data, buffer_s32, 0);
		buffer_save(buff_data, working_directory + "Users/" + str1 + "/data.sav");
		buffer_delete(buff_data);
						
		var buff_course = buffer_create(1024, buffer_fixed, 4);
		for (var i=0;i<7620;i++) buffer_write(buff_course, buffer_s32, 0);	
		buffer_save(buff_course, working_directory + "Users/" + str1 + "/course.sav");
		buffer_delete(buff_course);
			
		var buff_activity = buffer_create(7620, buffer_fixed, 4);
		for (var i=0;i<7620;i++) buffer_write(buff_activity, buffer_s32, 0);	
		buffer_save(buff_activity, working_directory + "Users/" + str1 + "/activity.sav");
		buffer_delete(buff_activity);
						
		var buff_info = buffer_create(160*1024, buffer_grow, 4);
		buffer_fill(buff_info, 0, buffer_s32, 0, 160*1024);	
		buffer_save(buff_info, working_directory + "Users/" + str1 + "/info.sav");
		buffer_delete(buff_info);
						
		var buff_clk = buffer_create(12*1024, buffer_grow, 4);
		buffer_fill(buff_clk, 0, buffer_s32, 0, 12*1024);	
		buffer_save(buff_clk, working_directory + "Users/" + str1 + "/clock.sav");
		buffer_delete(buff_clk);
						
		var buff_stu = buffer_load(working_directory + "student_list.sav");
		var student_n = buffer_peek(buff_stu, 0, buffer_s32);
		buffer_poke(buff_stu, 0, buffer_s32, student_n+1);
		buffer_poke(buff_stu, 64*(student_n+1), buffer_string, str1);
		buffer_save(buff_stu, working_directory + "student_list.sav");
		buffer_delete(buff_stu);
		
		show_message("注册成功！");
	}
}
//用户登录 
//参数：1 string 用户名  2 string 密码
function user_login(str1, str2){
	if (!directory_exists(working_directory + "Users/" + str1)){
		show_message("该用户不存在，请重新输入学号");
	}else{
		var buff_pass = buffer_load(working_directory + "Users/" + str1 + "/password.sav");
		buffer_seek(buff_pass, buffer_seek_start, 0);
		var password = buffer_read(buff_pass, buffer_string);
		if (password == str2){
			global.student = str1;
			show_message("登录成功！");
			room_goto(room_map);
			buffer_delete(buff_pass);
		}else{
			show_message("用户名或密码错误，请重新输入");
			buffer_delete(buff_pass);
		}
	}
}
//保存系统和用户信息
function system_save(){
	//写入当前时间
	var buff_info = buffer_load(working_directory + "system_info.sav");
	buffer_write(buff_info, buffer_s16, global.time);
	buffer_write(buff_info, buffer_s16, global.hour);
	buffer_write(buff_info, buffer_s16, global.day);
	buffer_write(buff_info, buffer_s16, global.week);
	buffer_save(buff_info, working_directory + "system_info.sav");
	buffer_delete(buff_info);
				
	//写入用户信息
	var buff_data = buffer_load(working_directory + "Users/" + global.student + "/data.sav");
	buffer_write(buff_data, buffer_s32, global.access);
	buffer_write(buff_data, buffer_s32, global.spd);
	buffer_write(buff_data, buffer_s32, global.location);
	buffer_save(buff_data, working_directory + "Users/" + global.student + "/data.sav");
	buffer_delete(buff_data);
}