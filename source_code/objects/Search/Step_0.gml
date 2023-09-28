image_xscale=scale;
image_yscale=scale;
switch (state){
	case 0:
		scale = 1;
	break;
	case 1:
		scale = 0.95;
	break;
	case 2:
		scale = 1.1;
	break;
	case 3:
		father.go_search();
		state = 0;
	break;
}