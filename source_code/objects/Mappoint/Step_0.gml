if (global.in_navi && _id==global.navipoint[global.navi_path[global.navi_path[0]]].building){
	image_speed = 0.12;
	image_xscale = scale+abs(image_index-1)*0.1;
	image_yscale = scale+abs(image_index-1)*0.1;
}else{
	image_index = 0;
	image_speed = 0;
	image_yscale = scale;
	image_xscale = scale;
}