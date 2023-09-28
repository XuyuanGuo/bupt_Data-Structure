/// @description Insert description here
// You can write your code in this editor
if (week != e[0].chose+1){
	week = e[0].chose+1;
	state = 0;
}
switch (state){
	//初始化
	case 0:
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
						if (a >= temp_N){
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
		state = 1;
	break;
	case 1:
		if (get_floor()==0){
			if (keyboard_check(ord("A"))){
				delta_w = clamp(0, delta_w-12, w_limit);
			}else if(keyboard_check(ord("D"))){
				delta_w = clamp(0, delta_w+12, w_limit);
			}
			if (keyboard_check(ord("S"))){
				delta_h = clamp(0, delta_h+12, h_limit);
			}else if(keyboard_check(ord("W"))){
				delta_h = clamp(0, delta_h-12, h_limit);
			}
		}
	break;
}