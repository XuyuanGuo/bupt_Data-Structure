h = 50; 
w = 300; 
wordsize = 1;
isinput = 0; //是否正在输入
str1 = ""; //未输入字符时，框中显示的文本内容
str2 = ""; //所输入字符
str3 = ""; //光标右侧的字符，用于控制光标移动
str_width = []; //存储所输入字符从左到右的各段长度，以确定光标位置
str_width[20] = 0; 
inputx = 0; //光标位置下标，表示光标在第inputx个字符的右侧
timer = 60; //光标闪烁计时器
font = Font1;
numberonly = 0; //是否只能输入数字
letteronly = 0; //是否只能输入数字、字符和符号
ready = 0; //是否在鼠标范围内
father = noone; //父对象