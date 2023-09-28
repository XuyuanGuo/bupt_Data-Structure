/// @description Insert description here
// You can write your code in this editor
w = WINDOW_WIDTH;
h = WINDOW_HEIGHT;
delta_w = 0;
delta_h = 0;
w_limit = 800;
h_limit = 260;
y_st = 0;
week = global.week;
visible = 0;

e = [];
e[0]=instance_create_chooselist(1420, 120, 200, 50, 0.8, 16, self, global.weeks2);
e[0].visible = 0;
e[1]=instance_create_depth(x+w-15, y, depth-1, Scrollbar);
e[1].father = self;
e[2]=instance_create_depth(x, y+h, depth-1, Scrollbar);
e[2].father = self;
e[2].tp = 1;
e[2].image_angle = 90;
e[4]=instance_create_button(1070, 20, 200, 70, 0.95, 11, "课程管理", self);
e[5]=instance_create_button(450, 100, 200, 70, 0.95, 13, "活动管理", self);
e[6]=instance_create_button(760, 100, 200, 70, 0.95, 17, "临时事务", self);
e[7]=instance_create_button(1070, 100, 200, 70, 0.95, 22, "闹钟管理", self);

grid_w = 320;
grid_h = [];
for (var i = 17; i>0; i--) grid_h[i] = 60;
grid_h[0] = 140;

r_count = 17;
c_count = 7;

state = 0;
grid = [];
for (var i = 7; i>=0; i--)
	for (var j=17 ; j; j--)
		grid[i][j]=noone;
		
function close_graph(){
	global.paused = 0;
	global.in_graph = 0;
	close_window();
	with(Main){
		button[0].tp = 6;
		button[0].str = "查看课表";
	}
	global.map.visible = 1;
	e[0].visible = 0;
	visible = 0;
}

function open_graph(){
	global.paused = 1;
	global.in_graph = 1;
	open_window(0);
	with (Main){
		button[0].str = "返回地图";
		button[0].tp = 7;
	}
	visible = 1;
	e[0].visible = 1;
	global.map.visible = 0;
}

//刷新课表
function refresh(){
	for (var i = 17; i>0; i--) grid_h[i] = 60;
	grid_h[0] = 140;
	if (global.access == 0){
		var sum=0;
		//计算表格高度
		for (var i=0;i<c_count;i++){
			for (var j=1; j<r_count; j++){
				var c=global.courseTable[week-1][i][j-1];
				var a=global.activityTable[week-1][i][j-1];
				if (c && a) grid_h[j] = max(grid_h[j],240);
				else if (!c && !a) grid_h[j] = max(grid_h[j],60);
				else grid_h[j] = max(grid_h[j],140);
			}
		}
		for (var j=1; j<r_count; j++) sum+=grid_h[j];
		h_limit = sum-720;
			
		for (var i=0, s=60; i<c_count; i++){
			for (var j=1; j<r_count; j++){
				var c=global.courseTable[week-1][i][j-1];
				var a=global.activityTable[week-1][i][j-1];
				if (grid[i][j]!=noone) instance_destroy(grid[i][j]);
				grid[i][j]=instance_create_textlabel(250+grid_w*i, 240+s, grid_w-30, grid_h[j]-20, 0.9, 4, "");
				if(c){
					grid[i][j].num = c;
					if (a){
						grid[i][j].num2 = a;
						grid[i][j].tp = 8;
					}
				}else{ 
					grid[i][j].num = a;
					grid[i][j].tp = 7;
					if (a == temp_N){
						grid[i][j].str = time_to_filename(new init_time(week, i, j+5));
					}
				}
				grid[i][j].image_alpha = 0;
				grid[i][j].father=self;
				s+= grid_h[j];
			}
			s=60;
		}
	}
}