// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
global.started = 0;
function global_init(){
	if (global.started == 0){
		global.started = 1;
		//加载字体
		globalvar Font1, Font2, Font3, Font4;
		Font1 = font_add("font1.otf", 32, 0, 0, 0, 30888);
		Font2 = font_add("font2.ttf", 32, 1, 0, 0, 30888);
		Font3 = font_add("font3.otf", 32, 0, 0, 0, 30888);
		Font4 = font_add("font4.ttf", 32, 1, 0, 0, 30888);
		//加载内置课程信息
		if (!directory_exists(working_directory + "Users/")){
			directory_create(working_directory + "Users/19260817");
			directory_create(working_directory + "Users/19260817/log");
			directory_create(working_directory + "Users/19260817/tempstuff");
			var buff_pass = buffer_create(128, buffer_fixed, 1);
			buffer_seek(buff_pass, buffer_seek_start, 0);
			buffer_write(buff_pass, buffer_string, "19260817");	
			buffer_save(buff_pass, working_directory + "Users/19260817/password.sav");
			buffer_delete(buff_pass);
			
			var buff_data = buffer_create(256, buffer_fixed, 4);
			buffer_seek(buff_data, buffer_seek_start, 0);
			buffer_write(buff_data, buffer_s32, 1);	
			buffer_write(buff_data, buffer_s32, 6);	
			buffer_write(buff_data, buffer_s32, 0);	
			buffer_save(buff_data, working_directory + "Users/19260817/data.sav");
			buffer_delete(buff_data);

			var buff_course = buffer_create(18000, buffer_grow, 1);
			for (var i=0;i<18000;i++) buffer_write(buff_course, buffer_s32, 0);	
			buffer_save(buff_course, working_directory + "course_info.sav");
			buffer_delete(buff_course);
			
			var buff_course = buffer_create(1024, buffer_grow, 4);
			buffer_write(buff_course, buffer_s32, 0);	
			buffer_save(buff_course, working_directory + "course_list.sav");
			buffer_delete(buff_course);
			
			var buff_activity = buffer_create(7620, buffer_fixed, 4);
			for (var i=0;i<7620;i++) buffer_write(buff_activity, buffer_s32, 0);	
			buffer_save(buff_activity, working_directory + "Users/19260817/activity.sav");
			buffer_delete(buff_activity);
						
			var buff_info = buffer_create(160*1024, buffer_grow, 4);
			buffer_fill(buff_info, 0, buffer_s32, 0, 160*1024);	
			buffer_save(buff_info, working_directory + "Users/19260817/info.sav");
			buffer_delete(buff_info);
						
			var buff_clk = buffer_create(12*1024, buffer_grow, 4);
			buffer_fill(buff_clk, 0, buffer_s32, 0, 12*1024);	
			buffer_save(buff_clk, working_directory + "Users/19260817/clock.sav");
			buffer_delete(buff_clk);
			
			var buff_stu = buffer_create(65024, buffer_grow, 1);
			buffer_write(buff_stu, buffer_s32, 0);	
			for (var i=1;i<=1000;i++) buffer_poke(buff_stu, 64*i, buffer_string, "");
			buffer_save(buff_stu, working_directory + "student_list.sav");
			buffer_delete(buff_stu);
			
			//存储时间信息，类型为16位无符号整数
			var buff_info = buffer_create(128, buffer_fixed, 2);
			buffer_seek(buff_info, buffer_seek_start, 0);
			buffer_write(buff_info, buffer_s16, 0);	
			buffer_write(buff_info, buffer_s16, 0);	
			buffer_write(buff_info, buffer_s16, 0);	
			buffer_write(buff_info, buffer_s16, 1);	
			buffer_save(buff_info, working_directory + "system_info.sav");
			buffer_delete(buff_info);
			
			directory_create(working_directory + "Courses/");
		}

		global.student = "";
	}
/*var buff_st = buffer_load(working_directory + "student_list.sav");
buffer_write(buff_st, buffer_s32, 0);
buffer_save(buff_st, working_directory + "student_list.sav");
buffer_delete(buff_st);
for (var k=1;k<=100;k++){
	var str1 = string(k);
		directory_create(working_directory + "Users/" + str1);
		directory_create(working_directory + "Users/" + str1 + "/log");
		directory_create(working_directory + "Users/" + str1 + "/tempstuff");
						//show_message(str1);
						var buff_pass = buffer_create(128, buffer_fixed, 1);
						buffer_write(buff_pass, buffer_string, str1);	
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
}*/
}