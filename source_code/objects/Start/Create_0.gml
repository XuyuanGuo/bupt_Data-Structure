/// @description Insert description here
// You can write your code in this editor
global_init();
depth = 10;

//GUI生效的优先级
global.floor = [];
global.floor_top = 0;
global.floor[0] = 30;

instance_create_depth(0, 0, 0, Background);

var c1=instance_create_depth(590, 400, -5, Choosebox);
c1.len=2;
c1.chose=0;
c1.str=["用户登录","用户注册"];


