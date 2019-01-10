lst = []
lines = []
x = 0
c = C = g = s = p = t = b = 0
with open("stage1.txt", "r") as f:
    lines = f.readlines()
temple = """`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:12:03 12/24/2018 
// Design Name: 
// Module Name:    StageGenerator 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
// Initial game stage.
module StageGenerator(
	output [12:0] mario_x, 
	output [12:0] mario_y, 
	output [12:0] map_width, 
	output [13*8-1:0] goomba_x, // disable when {x, y} = 00
	output [13*8-1:0] goomba_y, 
	output [13*8-1:0] turtle_x, 
	output [13*8-1:0] turtle_y, 
	output [13*64-1:0] box_x, 
	output [13*64-1:0] box_y, 
	output [2*64-1:0] box_state, // 0: coin, 1: pilz, 2: box, 3: stone
	output [13*8-1:0] pipe_x, 
	output [13*8-1:0] pipe_y, 
	output [12:0] castle_x, 
	output [12:0] castle_y, 
	output [13*16-1:0] coin_x, 
	output [13*16-1:0] coin_y
    );
	%s
endmodule

"""

for s in lines:
    y = 439
    for c in s:
        if c == 'b':
            b += 1
            lst.append("assign box_x[%d:%d] = 13'd%d" % (13*b-1,13*(b-1),x))
            lst.append("assign box_y[%d:%d] = 13'd%d" % (13*b-1,13*(b-1),y))
            lst.append("assign box_state[%d:%d] = 2'b%s" % (2*b-1,2*(b-1),'10'))
        elif c == 's':
            b += 1
            lst.append("assign box_x[%d:%d] = 13'd%d" % (13*b-1,13*(b-1),x))
            lst.append("assign box_y[%d:%d] = 13'd%d" % (13*b-1,13*(b-1),y))
            lst.append("assign box_state[%d:%d] = 2'b%s" % (2*b-1,2*(b-1),'11'))
        elif c == 'm':
            b += 1
            lst.append("assign box_x[%d:%d] = 13'd%d" % (13*b-1,13*(b-1),x))
            lst.append("assign box_y[%d:%d] = 13'd%d" % (13*b-1,13*(b-1),y))
            lst.append("assign box_state[%d:%d] = 2'b%s" % (2*b-1,2*(b-1),'01'))
        elif c == 'c':
            b += 1
            lst.append("assign box_x[%d:%d] = 13'd%d" % (13*b-1,13*(b-1),x))
            lst.append("assign box_y[%d:%d] = 13'd%d" % (13*b-1,13*(b-1),y))
            lst.append("assign box_state[%d:%d] = 2'b%s" % (2*b-1,2*(b-1),'00'))
        elif c == 'C':
            C += 1
            lst.append("assign coin_x[%d:%d] = 13'd%d" % (13*C-1,13*(C-1),x))
            lst.append("assign coin_y[%d:%d] = 13'd%d" % (13*C-1,13*(C-1),y))
        elif c == 'g':
            g += 1
            lst.append("assign goomba_x[%d:%d] = 13'd%d" % (13*g-1,13*(g-1),x))
            lst.append("assign goomba_y[%d:%d] = 13'd%d" % (13*g-1,13*(g-1),y))
        elif c == 't':
            t += 1
            lst.append("assign turtle_x[%d:%d] = 13'd%d" % (13*t-1,13*(t-1),x))
            lst.append("assign turtle_y[%d:%d] = 13'd%d" % (13*t-1,13*(t-1),y))
        elif c == 'p':
            p += 1
            lst.append("assign pipe_x[%d:%d] = 13'd%d" % (13*p-1,13*(p-1),x))
            lst.append("assign pipe_y[%d:%d] = 13'd%d" % (13*p-1,13*(p-1),y))
        elif c == 'E':
            lst.append("assign castle_x[12:0] = 13'd%d" % (x))
            lst.append("assign castle_y[12:0] = 13'd%d" % (y))
        elif c == 'M':
            lst.append("assign mario_x[12:0] = 13'd%d" % (x))
            lst.append("assign mario_y[12:0] = 13'd%d" % (y))
        elif c == '.':
            y -= 10
        y -= 40
    x += 40
# p+=1
# C+=1
# b+=1
# g+=1
# t+=1
print(p, C, b, g, t)
lst.append("assign pipe_x[%d:%d] = %d'd0" % (13*8-1, 13*p, (13*8 - 13*p)))
lst.append("assign pipe_y[%d:%d] = %d'd0" % (13*8-1, 13*p, (13*8 - 13*p)))
lst.append("assign box_x[%d:%d] = %d'd0" % (13*64-1, 13*b, (13*64 - 13*b)))
lst.append("assign box_y[%d:%d] = %d'd0" % (13*64-1, 13*b, (13*64 - 13*b)))
lst.append("assign box_state[%d:%d] = %d'd0" % (2*64-1, 2*b, (2*64 - 2*b)))
lst.append("assign coin_x[%d:%d] = %d'd0" % (13*16-1, 13*C, (13*16 - 13*C)))
lst.append("assign coin_y[%d:%d] = %d'd0" % (13*16-1, 13*C, (13*16 - 13*C)))
lst.append("assign goomba_x[%d:%d] = %d'd0" % (13*8-1,13*g, (13*8 - 13*g)))
lst.append("assign goomba_y[%d:%d] = %d'd0" % (13*8-1,13*g, (13*8 - 13*g)))
lst.append("assign turtle_x[%d:%d] = %d'd0" % (13*8-1,13*t, (13*8 - 13*t)))
lst.append("assign turtle_y[%d:%d] = %d'd0" % (13*8-1,13*t, (13*8 - 13*t)))
lst.append("assign map_width = 13'd%d" % (x + 480))
with open("StageGenerator.v", "w") as ff:
    ff.write(temple % (";\n	".join(lst) + ";"))
