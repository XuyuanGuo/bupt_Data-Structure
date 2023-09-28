/// @description Insert description here
// You can write your code in this editor
with(Inputbox){
	if (ready==0 || depth>=get_floor()){
		isinput = 0;
	}
}
with(Chooselist){
	if (active && state == 2 && ready == 0) state =3;
}