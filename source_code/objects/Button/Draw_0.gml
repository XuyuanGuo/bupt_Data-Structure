/// @description Insert description here
// You can write your code in this editor
draw_set_font(font);
if (outline) draw_roundrect_color_ext(x+w*(1-scale)/2, y+h*(1-scale)/2, x+w-w*(1-scale)/2, y+h-h*(1-scale)/2, 1, 1, c_gray, c_gray,  1);
draw_roundrect_color_ext(x+w*(1-scale)/2, y+h*(1-scale)/2, x+w-w*(1-scale)/2, y+h-h*(1-scale)/2, 1, 1, c_white, c_white,  0);
draw_text_transformed_color(x+(w-string_width(str)*wordsize*scale)/2, y+7+(h-string_height(str)*wordsize*scale)/2, str, wordsize*scale, wordsize*scale, 0, color, color, color, color, 1);