event_inherited();
state = 0;
scale = 1;
e = noone;
function setting_pause(){
	if (!instance_exists(Settingbar)){
		global.paused = 1;
		open_window(-30);
		with(GUI){
			if (self!=Setting) active = 0;
		}
		e=instance_create_depth(room_width/2, room_height/2, -30, Settingbar);
	}else{
		if (global.in_graph == 0) global.paused = 0;
		instance_destroy(e.e1);
		instance_destroy(e.e2);
		instance_destroy(e.e3);
		instance_destroy(e.e4);
		instance_destroy(e.e5);
		if (global.Remind_time!=e.e6.chose) log_update("设置提醒："+e.e6.strlist[!global.Remind_time]);
		global.Remind_time = e.e6.chose;
		e.e6.destroy();
		instance_destroy(e);
		close_window();
		with(GUI) active = 1;
	}
}