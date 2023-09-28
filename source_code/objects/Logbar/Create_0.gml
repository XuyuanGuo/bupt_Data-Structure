w = 1400;
h = 800;
image_xscale = w;
image_yscale = h;
depth = -13; //窗口深度
father = noone;
str = [];//所要显示的日志文本列表
str[1024] = ""; 
len = 0;

h_limit = 0; //最大滑动距离
y_st = 200; //滑动开始时，滑动条的初始y坐标
delta_h = 0; //当前滑动距离

surf = noone;
hourstamp = []; //时间戳，在根据当天日志时间查询日志时，可以直接跳转到时间戳所指位置
hourstamp[24] = 0;

//滚动条初始化
scroll = instance_create_depth(x+w-60, y+200, depth-1, Scrollbar);
scroll.xx=x+w-60;
scroll.father = self;
scroll.image_yscale = 0.6;
scroll.h_range = h-230;
//选择列表初始化
chooselist = [];
chooselist[0] = instance_create_chooselist(x+300, y+100, 200, 60, 0.8, 16, self, global.weeks2);
chooselist[0].chose = global.week-1;
week = global.week;

chooselist[1] = instance_create_chooselist(x+640, y+100, 200, 60, 0.8, 7, self, global.weekdays);
day = global.day;
chooselist[1].chose = global.day;

chooselist[2] = instance_create_chooselist(x+980, y+100, 200, 60, 0.8, 24, self, global.hours);
hour = global.hour;
chooselist[2].chose = global.hour;

exitbutton = instance_create_depth(x+1350, y+15, depth-1, Exit);
exitbutton.father = self;
//刷新
function refresh(){
	//读取日志文本文件
	if (file_exists(working_directory + "Users/" + global.student + "/log/" + string(week) +"_"+ string(day) +".txt")){
		var file = file_text_open_read(working_directory + "Users/" + global.student + "/log/" + string(week) +"_"+ string(day) +".txt");
		for (var i = 0; !file_text_eof(file);i++){
			str[i] = file_text_readln(file);
		}
		len = i;
		for (var i=1;i<24;i++) hourstamp[1] = max(hourstamp[0], hourstamp[i]);
		file_text_close(file);
		h_limit =len*60 - 580;
		if (h_limit<=0) scroll.visible = 0;
	}else{
		len = 0;
		h_limit = 0;
		scroll.visible = 0;
	}
	if (surface_exists(surf)){
		surface_free(surf);
		surf = surface_create(w-120, h_limit + 1000);
	}
}

function create(){
	open_window(-13);
	refresh();
}

function destroy(){
	father.state = 2;
	for (var i=0;i<3;i++)
		chooselist[i].destroy();
	instance_destroy(scroll);
	instance_destroy(exitbutton);
	if (surface_exists(surf)) surface_free(surf);
	close_window();
	instance_destroy();
}

function choose_list_change(_e){
	if (_e==chooselist[0]){
		week = chooselist[0].chose+1;
		refresh();
	}else if (_e==chooselist[1]){
		day = chooselist[1].chose;
		refresh();
	}else if(_e==chooselist[2]){
		hour = chooselist[2].chose;
		delta_h = hourstamp[hour];
		show_message("cd");
	}else return;
}