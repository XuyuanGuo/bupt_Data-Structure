//visible = father.visible;
image_xscale = w;
image_yscale = h;
if (!surface_exists(surf) && len){
	surf = surface_create(w, h*min(5, len));
}
if (mouse_x>x && mouse_x<=x+w && mouse_y>y && mouse_y<=y+h+h*min(5, len)) ready = 1;
else ready = 0;
h_limit = max(len-5, 0)*h;
y_st = h;
if (tp == 0 && chose!=-1) str = strlist[chose];
//0 未点击  1 未点击->点击 2点击后 3点击后->未点击 4销毁
switch (state){
	case 0: 
	break;
	case 1: 
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
			textlabel[i].tp = (tp<=1)?3:12;
			textlabel[i].depth=depth-1;
			textlabel[i].y=y+h*i+h-delta_h;
			textlabel[i].yy=h*i;
			if (tp==2) textlabel[i].outline = choselist[i];
		}
		prechose = chose;
		state = 2;
	break;
	case 2:
		if (h_limit>0) e.visible = 1;
		for (var i=0; i<len; i++){
			textlabel[i].y=y+h*i+h-delta_h;
			textlabel[i].yy=h*i;
		}
	break;
	case 3:
		if (tp == 1){
			if (chose!=-1) inputbox.str2 = textlabel[chose].str;
			chose = -1;
			inputbox.isinput = 0;
		}
		choose_list_destroy();
		if (destroyed == 0) close_window();
		destroyed = 1;
		state = 0;
	break;
	//销毁
	case 4:
		if (destroyed == 0){
			choose_list_destroy();
			close_window();
		}
		if (tp == 1) instance_destroy(inputbox);
		surface_free(surf);
		instance_destroy();
	break;
}
