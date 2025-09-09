/// @description Update

depth = -y;

spd.x = lerp(spd.x, 0, .2);
spd.y = lerp(spd.y, 0, .2);

x += spd.x;
y += spd.y;