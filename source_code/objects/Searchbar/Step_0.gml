/// @description Insert description here
// You can write your code in this editor
switch (state){
	case 0:
		if (!surface_exists(surf)) surf = surface_create(w-120, min(h_limit+6000, 16380));
		for (var i=0, j = 0;i<len;i++){
			textlabel[i].y=y+235+j-delta_h;
			textlabel[i].yy=j;
			j+=string_height_ext(textlabel[i].str, 60, 900);
		}
	break;
	case 2:
		for (var i = 0; i<len; i++) instance_destroy(textlabel[i]);
		for (var i = 0; i<6; i++) instance_destroy(e[i]);
		for (var i = 0; i<4; i++) chooselist[i].destroy();
		instance_destroy(inputbox);
		instance_destroy(searchbutton);
		surface_free(surf);
		close_window();
		instance_destroy();
	break;
}