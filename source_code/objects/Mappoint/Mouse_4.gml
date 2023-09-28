if (depth<get_floor() && Main.button[0].state==0 && Main.button[1].state==0 && Main.button[2].state==0 && Main.button[3].state==0 && Main.button[4].state==0){
	if (global.location!=_id && !global.in_navi) log_update("设置当前位置："+global.sites[_id]);
	global.location = _id;
	if (global.in_navi){
		if (_id==global.navipoint[global.navi_path[global.navi_path[0]]].building){
			if (global.map.tsp_step!=0) global.map.go_tsp_navigation();
			else{
				global.map.navigation_off();
				log_update("完成导航，当前位置："+global.sites[_id]);
			}
		}else{
			global.map.go_navigation(_id, global.navipoint[global.navi_path[global.navi_path[0]]].building);
		}
	}
}