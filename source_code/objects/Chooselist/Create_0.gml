event_inherited();
w = 100;
h = 50;
tp = 0; //tp=0普通选择框 1可输入文本的选择框 2复选框
destroyed = 1; //为1时表示选择列表未展开，为0时已展开
delta_h = 0; 
y_st = 50;
h_limit = 0;
state = 0;
wordsize = 1;
str = ""; //表头显示的文本
strlist = []; //选择列表的文本
len = 1; //选择列表的长度
textlabel = []; //选择列表中的文本框，生成时需要导入strlist中的文本
inputbox = noone; //文本框
e = noone; //滚动条
chose = 0; //选择列表中被选中一项的编号
choselist = []; //复选框列表，用于记录选择列表中哪几项被选中
choselist[5] = 0; 
prechose = 0; //选择列表中选中的前一项，用于检测选择是否发生变化
surf = noone; //绘制表面
ready = 0; //是否在鼠标范围内
friend = noone;
function chooselist_inputbox_create(){
	inputbox = instance_create_inputbox(x, y+7, w, h, 0.9);
	inputbox.father = self;
}
function choose_list_open(){
	open_window(depth);
	if (tp == 2 && str!=inputbox.str2){
		str = inputbox.str2;
		state = 5;
	}
	destroyed = 0;
	e = instance_create_depth(x+w, y+h, depth-1, Scrollbar);
	e.xx=x+w;
	e.father = self;
	e.image_yscale = 0.5;
	e.h_range= min(len, 5)*h;
	e.visible = 0;
	for (var i=0; i<len; i++){
		textlabel[i]=instance_create_textlabel(x, y+h*i+h, w-20, h, wordsize, 0, strlist[i]);
		textlabel[i].father = self;
		textlabel[i].num = i;
		textlabel[i].tp = 3;
		textlabel[i].depth=depth-1;
		textlabel[i].y=y+h*i+h-delta_h;
		textlabel[i].yy=h*i;
	}
	state = 2;
}
function choose_list_chose(){
	if (tp == 1){
		if (chose!=-1) inputbox.str2 = textlabel[chose].str;
		chose = -1;
		inputbox.isinput = 0;
	}
	choose_list_destroy();
	if (destroyed == 0) close_window();
	destroyed = 1;
	state = 0;
}
function refresh(){
	if (h_limit>0) e.visible = 1;
	for (var i=0; i<len; i++){
		textlabel[i].y=y+h*i+h-delta_h;
		textlabel[i].yy=h*i;
	}
}
function choose_list_destroy(){
	for (var i=0; i<len; i++){
		instance_destroy(textlabel[i]);
	}
	instance_destroy(e);
}
function destroy(){
	if (destroyed == 0){
		choose_list_destroy();
		close_window();
	}
	if (tp == 1) instance_destroy(inputbox);
	surface_free(surf);
	instance_destroy();
}
