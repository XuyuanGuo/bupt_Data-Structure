if (position_meeting(mouse_x, mouse_y, self)){
	ready = 1;
	portion = 1.4;
}else{
	ready = 0;
	portion = 1;
}
if (father.visible == 0) visible = 0;
else if (father.h_limit>0) visible = 1;
image_xscale = scale*portion;
if (tp==0){
	x=xx-15*image_xscale;
	father.delta_h=min(father.h_limit, father.delta_h);
	father.delta_h=max(0, father.delta_h);
	y=clamp(father.y+father.y_st+(father.delta_h/father.h_limit)*(h_range-300*image_yscale), father.y+father.y_st, father.y+h_range+father.h_limit);
}else{
	father.delta_w=min(father.w_limit, father.delta_w);
	father.delta_w=max(0, father.delta_w);
	x=father.x+(father.delta_w/father.w_limit)*(father.w-300*image_yscale);
}
if (mouse_check_button_released(mb_left)){
	rolling = 0;
	if (tp==0) x=xx-15*image_xscale;
	else y=yy;
	image_alpha = 0.8;
	portion = 1;
}
if (rolling){
	if (tp==0){
		if (mouse_y<mouse_pre && father.delta_h>0){
			father.delta_h-=1.5*(mouse_pre-mouse_y)+father.h_limit/60;
		}else if(mouse_y>mouse_pre && father.delta_h<father.h_limit){
			father.delta_h+=1.5*(mouse_y-mouse_pre)+father.h_limit/60;
		}
		mouse_pre = mouse_y;
	}else{
		if (mouse_x<mouse_pre && father.delta_w>0){
			father.delta_w-=0.8*(mouse_pre-mouse_x);
		}else if(mouse_x>mouse_pre && father.delta_w<father.w_limit){
			father.delta_w+=0.8*(mouse_x-mouse_pre);
		}
		mouse_pre = mouse_x;
	}
}