//系统时间控制
if (!global.paused && !global.timepaused && !global.floor_top){
	if (global.week == 17){
		show_message("本学期已经结束，谢谢使用！");
		game_end();
	}
	global.time+=global.spd/30;
	if (global.time>60){
		var str = [];
		var f = [];
		var l = 0;
		global.time=0;
		//删除已完成的临时事务
		if (global.hour>=6 && global.hour<=22 && global.activityTable[global.week-1][global.day][global.hour-6]==temp_N){
			var _a = new init_time(global.week, global.day, global.hour);
			var tlist = read_tempstuff_info(_a);
			for (var i=1;i<=tlist[0];i++){
				delete_schedule_hash(tlist[i], tlist[i]._id);
				global.tempstuffList[tlist[i]._id] = noone;
			}
			global.tempstuffHash.remove(time_to_int(_a));
			update_activitytable(_a, 0);
			file_delete(working_directory + "/Users/" + global.student + "/tempstuff/" + time_to_filename(_a) +".sav");
			global.graph.refresh();
		}
		global.hour++;
		global.log_created = 0;
		if (global.hour>=5 && global.hour<23){
			var pl=l;
			l = create_course_message(str, l, f);
			if (pl==l)l = create_activity_message(str, l, f);
		}
		if (global.hour>23){
			global.hour=0;
			global.day++;
			if (global.day>6){
				global.day=0;
				global.week++;
			}
		}
		if (global.hour>=6 && global.hour<23 && global.clockTable[global.week-1][global.day][global.hour-6]==1){
			str[l++] = "闹钟: " + string(global.hour) + ":00";
		}
		if (global.hour == 0 && global.time == 0){
			l = create_daily_message(str, l, f);
		}
		f[l+1] = 0;
		if (l){
			create_message(str, l, f);
			log_create_message(str, l);
		}
	}
}