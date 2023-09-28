event_inherited();
xx = WINDOW_WIDTH;
yy = WINDOW_HEIGHT;
h_range = WINDOW_HEIGHT; //滑动到最大距离时，自身的y坐标
father = noone;
mouse_pre = 0; //之前的鼠标位置，用于判断拖动方向
rolling = 0; //标记是否正在滑动
scale = 1;
portion = 1;
tp = 0; //为0时竖向，1时横向
ready = 0;