//表面绘制的控制，有关表面绘制，参见官方说明文档
if (!surface_exists(surf)) surf = surface_create(w-120, 1000);
else if (surface_get_height(surf)<h_limit){
	surface_free(surf);
	surf = surface_create(w-120, 1000);
}
//检测时间选择框的变化
if (chooselist[0].chose!=week-1){
	week = chooselist[0].chose+1;
	//调用刷新函数
	refresh();
}else if (chooselist[1].chose!=day){
	day = chooselist[1].chose;
	refresh();
}else if(chooselist[2].chose!=hour){
	hour = chooselist[2].chose;
	delta_h = hourstamp[hour];
}