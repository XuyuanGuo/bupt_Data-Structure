state = 0; //状态 0:初始化状态 1:显示状态
map_w = 2880; //地图宽度
map_h = 3360; //地图高度
scale = 1; //地图尺寸
top = 0; //绘制的上边界
left = 0; //绘制的左边界
depth = 30; //绘制深度
tsp_list = [0]; //旅行商导航路径
tsp_step = 0; //旅行商导航步数
task = [0,""]; //导航终点的任务名称
//刷新地图信息
function refresh_mappoint(){
	for (var i=0;i<BUILDING_N;i++){
		global.building_point[i].x=(-left + global.building_point[i].xx)*scale;
		global.building_point[i].y=(-top + global.building_point[i].yy)*scale;
	}
	for (var i=1;i<=NAVI_POINT_N;i++){
		global.navipoint[i].x=(-left + global.navipoint[i].xx)*scale;
		global.navipoint[i].y=(-top + global.navipoint[i].yy)*scale;
	}
}
//开启导航
function navigation_on(){
	var l = global.navi_path[0];
	for (var i=1;i<l;i++){
		global.navipoint[global.navi_path[i]].next = global.navi_path[i+1];
	}
	global.in_navi = 1;
}
//关闭导航
function navigation_off(){
	var l = global.navi_path[0];
	for (var i=1;i<l;i++){
		global.navipoint[global.navi_path[i]].next = 0;
	}
	for (var i=0;i<=l;i++) global.navi_path[i] = 0;
	global.in_navi = 0;
}
//进行一次导航
function go_navigation(_l1, _l2){
	navigation_off();
	dijkstra(_l1, _l2);
	navigation_on();
}
//进行一次tsp导航
function go_tsp_navigation(){
	navigation_off();
	if (tsp_step<tsp_list[0]){
		dijkstra(tsp_list[tsp_step], tsp_list[tsp_step+1]);
		navigation_on();
		tsp_step++;
	}else if (tsp_step==tsp_list[0]){
		dijkstra(tsp_list[tsp_step++], tsp_list[1]);
		navigation_on();
	}else{
		tsp_step = 0;
		log_update("临时事务导航完成");
	}
}