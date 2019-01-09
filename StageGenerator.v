`timescale 1ns / 1ps
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
	input stage, 
	output [12:0] mario_x, 
	output [12:0] mario_y, 
	output [12:0] map_width, 
	output [13*16-1:0] goomba_x, // disable when {x, y} = 00
	output [13*16-1:0] goomba_y, 
	output [13*16-1:0] turtle_x, 
	output [13*16-1:0] turtle_y, 
	output [13*64-1:0] box_x, 
	output [13*64-1:0] box_y, 
	output [2*64-1:0] box_state, // 0: coin, 1: pilz, 2: box, 3: stone
	output [13*16-1:0] pipe_x, 
	output [13*16-1:0] pipe_y, 
	output [12:0] castle_x, 
	output [12:0] castle_y, 
	output [13*64-1:0] coin_x, 
	output [13*64-1:0] coin_y
    );

	assign mario_x[12:0] = 13'd80;
	assign mario_y[12:0] = 13'd439;
	assign box_x[12:0] = 13'd320;
	assign box_y[12:0] = 13'd359;
	assign box_state[1:0] = 2'b11;
	assign box_x[25:13] = 13'd360;
	assign box_y[25:13] = 13'd359;
	assign box_state[3:2] = 2'b00;
	assign box_x[38:26] = 13'd360;
	assign box_y[38:26] = 13'd269;
	assign box_state[5:4] = 2'b11;
	assign box_x[51:39] = 13'd400;
	assign box_y[51:39] = 13'd359;
	assign box_state[7:6] = 2'b11;
	assign box_x[64:52] = 13'd400;
	assign box_y[64:52] = 13'd269;
	assign box_state[9:8] = 2'b00;
	assign box_x[77:65] = 13'd440;
	assign box_y[77:65] = 13'd359;
	assign box_state[11:10] = 2'b01;
	assign box_x[90:78] = 13'd440;
	assign box_y[90:78] = 13'd269;
	assign box_state[13:12] = 2'b11;
	assign box_x[103:91] = 13'd480;
	assign box_y[103:91] = 13'd359;
	assign box_state[15:14] = 2'b11;
	assign goomba_x[12:0] = 13'd720;
	assign goomba_y[12:0] = 13'd439;
	assign box_x[116:104] = 13'd760;
	assign box_y[116:104] = 13'd439;
	assign box_state[17:16] = 2'b10;
	assign goomba_x[25:13] = 13'd840;
	assign goomba_y[25:13] = 13'd439;
	assign box_x[129:117] = 13'd920;
	assign box_y[129:117] = 13'd439;
	assign box_state[19:18] = 2'b10;
	assign pipe_x[12:0] = 13'd1080;
	assign pipe_y[12:0] = 13'd439;
	assign coin_x[12:0] = 13'd1080;
	assign coin_y[12:0] = 13'd279;
	assign coin_x[25:13] = 13'd1120;
	assign coin_y[25:13] = 13'd279;
	assign turtle_x[12:0] = 13'd1240;
	assign turtle_y[12:0] = 13'd439;
	assign pipe_x[25:13] = 13'd1360;
	assign pipe_y[25:13] = 13'd439;
	assign coin_x[38:26] = 13'd1360;
	assign coin_y[38:26] = 13'd279;
	assign coin_x[51:39] = 13'd1400;
	assign coin_y[51:39] = 13'd279;
	assign box_x[142:130] = 13'd1480;
	assign box_y[142:130] = 13'd199;
	assign box_state[21:20] = 2'b11;
	assign coin_x[64:52] = 13'd1480;
	assign coin_y[64:52] = 13'd79;
	assign box_x[155:143] = 13'd1520;
	assign box_y[155:143] = 13'd199;
	assign box_state[23:22] = 2'b11;
	assign box_x[168:156] = 13'd1560;
	assign box_y[168:156] = 13'd199;
	assign box_state[25:24] = 2'b11;
	assign box_x[181:169] = 13'd1560;
	assign box_y[181:169] = 13'd79;
	assign box_state[27:26] = 2'b00;
	assign box_x[194:182] = 13'd1680;
	assign box_y[194:182] = 13'd119;
	assign box_state[29:28] = 2'b11;
	assign box_x[207:195] = 13'd1720;
	assign box_y[207:195] = 13'd119;
	assign box_state[31:30] = 2'b11;
	assign box_x[220:208] = 13'd1760;
	assign box_y[220:208] = 13'd119;
	assign box_state[33:32] = 2'b11;
	assign box_x[233:221] = 13'd1800;
	assign box_y[233:221] = 13'd119;
	assign box_state[35:34] = 2'b11;
	assign pipe_x[38:26] = 13'd1960;
	assign pipe_y[38:26] = 13'd439;
	assign coin_x[77:65] = 13'd1960;
	assign coin_y[77:65] = 13'd319;
	assign turtle_x[25:13] = 13'd2040;
	assign turtle_y[25:13] = 13'd439;
	assign box_x[246:234] = 13'd2160;
	assign box_y[246:234] = 13'd439;
	assign box_state[37:36] = 2'b10;
	assign box_x[259:247] = 13'd2160;
	assign box_y[259:247] = 13'd399;
	assign box_state[39:38] = 2'b10;
	assign coin_x[90:78] = 13'd2160;
	assign coin_y[90:78] = 13'd319;
	assign coin_x[103:91] = 13'd2160;
	assign coin_y[103:91] = 13'd279;
	assign box_x[272:260] = 13'd2280;
	assign box_y[272:260] = 13'd439;
	assign box_state[41:40] = 2'b10;
	assign coin_x[116:104] = 13'd2280;
	assign coin_y[116:104] = 13'd279;
	assign goomba_x[38:26] = 13'd2360;
	assign goomba_y[38:26] = 13'd439;
	assign box_x[285:273] = 13'd2400;
	assign box_y[285:273] = 13'd279;
	assign box_state[43:42] = 2'b00;
	assign coin_x[129:117] = 13'd2400;
	assign coin_y[129:117] = 13'd159;
	assign pipe_x[51:39] = 13'd2480;
	assign pipe_y[51:39] = 13'd439;
	assign coin_x[142:130] = 13'd2480;
	assign coin_y[142:130] = 13'd279;
	assign turtle_x[38:26] = 13'd2600;
	assign turtle_y[38:26] = 13'd439;
	assign box_x[298:286] = 13'd2720;
	assign box_y[298:286] = 13'd389;
	assign box_state[45:44] = 2'b10;
	assign box_x[311:299] = 13'd2760;
	assign box_y[311:299] = 13'd389;
	assign box_state[47:46] = 2'b10;
	assign box_x[324:312] = 13'd2760;
	assign box_y[324:312] = 13'd349;
	assign box_state[49:48] = 2'b10;
	assign box_x[337:325] = 13'd2760;
	assign box_y[337:325] = 13'd189;
	assign box_state[51:50] = 2'b10;
	assign box_x[350:338] = 13'd2800;
	assign box_y[350:338] = 13'd389;
	assign box_state[53:52] = 2'b10;
	assign box_x[363:351] = 13'd2800;
	assign box_y[363:351] = 13'd309;
	assign box_state[55:54] = 2'b10;
	assign box_x[376:364] = 13'd2800;
	assign box_y[376:364] = 13'd189;
	assign box_state[57:56] = 2'b00;
	assign coin_x[155:143] = 13'd2800;
	assign coin_y[155:143] = 13'd69;
	assign box_x[389:377] = 13'd2840;
	assign box_y[389:377] = 13'd389;
	assign box_state[59:58] = 2'b10;
	assign coin_x[168:156] = 13'd2840;
	assign coin_y[168:156] = 13'd349;
	assign box_x[402:390] = 13'd2840;
	assign box_y[402:390] = 13'd269;
	assign box_state[61:60] = 2'b10;
	assign box_x[415:403] = 13'd2840;
	assign box_y[415:403] = 13'd189;
	assign box_state[63:62] = 2'b10;
	assign box_x[428:416] = 13'd2880;
	assign box_y[428:416] = 13'd239;
	assign box_state[65:64] = 2'b10;
	assign box_x[441:429] = 13'd2880;
	assign box_y[441:429] = 13'd199;
	assign box_state[67:66] = 2'b10;
	assign box_x[454:442] = 13'd3000;
	assign box_y[454:442] = 13'd389;
	assign box_state[69:68] = 2'b10;
	assign box_x[467:455] = 13'd3000;
	assign box_y[467:455] = 13'd349;
	assign box_state[71:70] = 2'b10;
	assign box_x[480:468] = 13'd3040;
	assign box_y[480:468] = 13'd389;
	assign box_state[73:72] = 2'b10;
	assign box_x[493:481] = 13'd3080;
	assign box_y[493:481] = 13'd389;
	assign box_state[75:74] = 2'b10;
	assign goomba_x[51:39] = 13'd3080;
	assign goomba_y[51:39] = 13'd349;
	assign box_x[506:494] = 13'd3080;
	assign box_y[506:494] = 13'd229;
	assign box_state[77:76] = 2'b00;
	assign box_x[519:507] = 13'd3120;
	assign box_y[519:507] = 13'd389;
	assign box_state[79:78] = 2'b10;
	assign box_x[532:520] = 13'd3120;
	assign box_y[532:520] = 13'd349;
	assign box_state[81:80] = 2'b10;
	assign box_x[545:533] = 13'd3120;
	assign box_y[545:533] = 13'd229;
	assign box_state[83:82] = 2'b10;
	assign box_x[558:546] = 13'd3160;
	assign box_y[558:546] = 13'd319;
	assign box_state[85:84] = 2'b10;
	assign box_x[571:559] = 13'd3160;
	assign box_y[571:559] = 13'd279;
	assign box_state[87:86] = 2'b10;
	assign box_x[584:572] = 13'd3160;
	assign box_y[584:572] = 13'd239;
	assign box_state[89:88] = 2'b10;
	assign box_x[597:585] = 13'd3200;
	assign box_y[597:585] = 13'd239;
	assign box_state[91:90] = 2'b10;
	assign coin_x[181:169] = 13'd3200;
	assign coin_y[181:169] = 13'd119;
	assign box_x[610:598] = 13'd3320;
	assign box_y[610:598] = 13'd389;
	assign box_state[93:92] = 2'b10;
	assign box_x[623:611] = 13'd3320;
	assign box_y[623:611] = 13'd349;
	assign box_state[95:94] = 2'b10;
	assign box_x[636:624] = 13'd3360;
	assign box_y[636:624] = 13'd389;
	assign box_state[97:96] = 2'b10;
	assign box_x[649:637] = 13'd3360;
	assign box_y[649:637] = 13'd309;
	assign box_state[99:98] = 2'b10;
	assign box_x[662:650] = 13'd3400;
	assign box_y[662:650] = 13'd389;
	assign box_state[101:100] = 2'b10;
	assign coin_x[194:182] = 13'd3400;
	assign coin_y[194:182] = 13'd269;
	assign box_x[675:663] = 13'd3400;
	assign box_y[675:663] = 13'd229;
	assign box_state[103:102] = 2'b10;
	assign box_x[688:676] = 13'd3440;
	assign box_y[688:676] = 13'd389;
	assign box_state[105:104] = 2'b10;
	assign turtle_x[51:39] = 13'd3440;
	assign turtle_y[51:39] = 13'd349;
	assign box_x[701:689] = 13'd3480;
	assign box_y[701:689] = 13'd359;
	assign box_state[107:106] = 2'b10;
	assign box_x[714:702] = 13'd3520;
	assign box_y[714:702] = 13'd319;
	assign box_state[109:108] = 2'b10;
	assign box_x[727:715] = 13'd3560;
	assign box_y[727:715] = 13'd279;
	assign box_state[111:110] = 2'b10;
	assign box_x[740:728] = 13'd3560;
	assign box_y[740:728] = 13'd239;
	assign box_state[113:112] = 2'b10;
	assign coin_x[207:195] = 13'd3560;
	assign coin_y[207:195] = 13'd119;
	assign box_x[753:741] = 13'd3640;
	assign box_y[753:741] = 13'd439;
	assign box_state[115:114] = 2'b10;
	assign turtle_x[64:52] = 13'd3720;
	assign turtle_y[64:52] = 13'd439;
	assign pipe_x[64:52] = 13'd3800;
	assign pipe_y[64:52] = 13'd439;
	assign coin_x[220:208] = 13'd3800;
	assign coin_y[220:208] = 13'd319;
	assign castle_x[12:0] = 13'd4160;
	assign castle_y[12:0] = 13'd439;
	assign pipe_x[207:78] = 130'd0;
	assign pipe_y[207:78] = 130'd0;
	assign box_x[831:767] = 65'd0;
	assign box_y[831:767] = 65'd0;
	assign box_state[127:118] = 10'd0;
	assign coin_x[831:234] = 598'd0;
	assign coin_y[831:234] = 598'd0;
	assign goomba_x[207:52] = 143'd0;
	assign goomba_y[207:52] = 143'd0;
	assign turtle_x[207:65] = 130'd0;
	assign turtle_y[207:65] = 130'd0;
	assign map_width = 13'd4680;
endmodule

