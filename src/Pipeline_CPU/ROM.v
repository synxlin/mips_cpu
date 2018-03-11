`timescale 1ns/1ps

module ROM (addr,data);
input [31:0] addr;
output [31:0] data;
reg [31:0] data;
localparam ROM_size = 32;
reg [31:0] ROM_data[ROM_size-1:0];

always@(*)
	case(addr[8:2])	//Address Must Be Word Aligned.
		//  j INIT
		0: data <= 32'b00001000000000000000000000000011;
		//  j INTER
		1: data <= 32'b00001000000000000000000000101100;
		//  j EXCEPT
		2: data <= 32'b00001000000000000000000010000000;
		//INIT:
		//  addi $t0, $zero, 0x0014
		3: data <= 32'b00100000000010000000000000010100;
		//  jr $t0
		4: data <= 32'b00000001000000000000000000001000;
		//  lui $s0, 0x4000
		5: data <= 32'b00111100000100000100000000000000;
		//  sw $zero, 8($s0)
		6: data <= 32'b10101110000000000000000000001000;
		//  addi $s1, $zero, -25000
		7: data <= 32'b00100000000100011001111001011000;
		//  sw $s1, 0($s0)
		8: data <= 32'b10101110000100010000000000000000;
		//  addi $s1, $zero, -1
		9: data <= 32'b00100000000100011111111111111111;
		//  sw $s1, 4($s0)
		10: data <= 32'b10101110000100010000000000000100;
		//  addi $s1, $zero, 3
		11: data <= 32'b00100000000100010000000000000011;
		//  sw $s1, 8($s0)
		12: data <= 32'b10101110000100010000000000001000;
		//  sw $t0, 32($s0)
		13: data <= 32'b10101110000010000000000000100000;
		//UART_START:
		//  addi $s1, $zero, -1
		14: data <= 32'b00100000000100011111111111111111;
		//UART_LOOP:
		//  lw $t0, 32($s0)
		15: data <= 32'b10001110000010000000000000100000;
		//  andi $t0, $t0, 0x08
		16: data <= 32'b00110001000010000000000000001000;
		//  beq $t0, $zero, UART_LOOP
		17: data <= 32'b00010001000000001111111111111101;
		//  lw $v1, 28($s0)
		18: data <= 32'b10001110000000110000000000011100;
		//  beq $v1, $zero, UART_LOOP
		19: data <= 32'b00010000011000001111111111111011;
		//  beq $s1, $zero, LOAD_2
		20: data <= 32'b00010010001000000000000000000011;
		//  addi $s4, $v1, 0
		21: data <= 32'b00100000011101000000000000000000;
		//  addi $s1, $s1, 1
		22: data <= 32'b00100010001100010000000000000001;
		//  j UART_LOOP
		23: data <= 32'b00001000000000000000000000001111;
		//LOAD_2:
		//  addi $s3, $v1, 0
		24: data <= 32'b00100000011100110000000000000000;
		//  addi $v0, $s4, 0
		25: data <= 32'b00100010100000100000000000000000;
		//GCD:
		//  beq $v0, $zero, ANS1
		26: data <= 32'b00010000010000000000000000001000;
		//  beq $v1, $zero, ANS2
		27: data <= 32'b00010000011000000000000000001001;
		//  sub $t3, $v0, $v1
		28: data <= 32'b00000000010000110101100000100010;
		//  bgtz $t3, LOOP1
		29: data <= 32'b00011101011000000000000000000001;
		//  bltz $t3, LOOP2
		30: data <= 32'b00000101011000000000000000000010;
		//LOOP1:
		//  sub $v0, $v0, $v1
		31: data <= 32'b00000000010000110001000000100010;
		//  j GCD
		32: data <= 32'b00001000000000000000000000011010;
		//LOOP2:
		//  sub $v1, $v1, $v0
		33: data <= 32'b00000000011000100001100000100010;
		//  j GCD
		34: data <= 32'b00001000000000000000000000011010;
		//ANS1:
		//  add $a0, $v1, $zero
		35: data <= 32'b00000000011000000010000000100000;
		//  j RESULT_DISPLAY
		36: data <= 32'b00001000000000000000000000100110;
		//ANS2:
		//  add $a0, $v0, $zero
		37: data <= 32'b00000000010000000010000000100000;
		//RESULT_DISPLAY:
		//  sw $a0, 12($s0)
		38: data <= 32'b10101110000001000000000000001100;
		//UART_SEND_BACK:
		//  lw $t0, 32($s0)
		39: data <= 32'b10001110000010000000000000100000;
		//  andi $t0, $t0, 0x10
		40: data <= 32'b00110001000010000000000000010000;
		//  bne $t0, $zero, UART_SEND_BACK
		41: data <= 32'b00010101000000001111111111111101;
		//  sw $a0, 24($s0)
		42: data <= 32'b10101110000001000000000000011000;
		//  j UART_START
		43: data <= 32'b00001000000000000000000000001110;
		//INTER:
		//  lw $t7, 8($s0)
		44: data <= 32'b10001110000011110000000000001000;
		//  andi $t7, $t7, 0xfff9
		45: data <= 32'b00110001111011111111111111111001;
		//  sw $t7, 8($s0)
		46: data <= 32'b10101110000011110000000000001000;
		//  addi $t3, $zero, 1
		47: data <= 32'b00100000000010110000000000000001;
		//  addi $t4, $zero, 2
		48: data <= 32'b00100000000011000000000000000010;
		//  addi $t5, $zero, 4
		49: data <= 32'b00100000000011010000000000000100;
		//  addi $t6, $zero, 8
		50: data <= 32'b00100000000011100000000000001000;
		//  lw $t7, 20($s0)
		51: data <= 32'b10001110000011110000000000010100;
		//  andi $t7, $t7, 0xf00
		52: data <= 32'b00110001111011110000111100000000;
		//  srl $t7, $t7, 8
		53: data <= 32'b00000000000011110111101000000010;
		//  beq $t7, $t3, DIGITAL_TUBE_1
		54: data <= 32'b00010001111010110000000000000110;
		//  beq $t7, $t4, DIGITAL_TUBE_2
		55: data <= 32'b00010001111011000000000000001010;
		//  beq $t7, $t5, DIGITAL_TUBE_3
		56: data <= 32'b00010001111011010000000000001101;
		//DIGITAL_TUBE_0:
		//  andi $s5, $s3, 0x0f
		57: data <= 32'b00110010011101010000000000001111;
		//  jal DECODE
		58: data <= 32'b00001100000000000000000001001011;
		//  addi $s5, $s2, 0x100
		59: data <= 32'b00100010010101010000000100000000;
		//  j DIGITAL_TUBE_DISPLAY
		60: data <= 32'b00001000000000000000000001111001;
		//DIGITAL_TUBE_1:
		//  andi $s5, $s3, 0xf0
		61: data <= 32'b00110010011101010000000011110000;
		//  srl $s5, $s5, 4
		62: data <= 32'b00000000000101011010100100000010;
		//  jal DECODE
		63: data <= 32'b00001100000000000000000001001011;
		//  addi $s5, $s2, 0x200
		64: data <= 32'b00100010010101010000001000000000;
		//  j DIGITAL_TUBE_DISPLAY
		65: data <= 32'b00001000000000000000000001111001;
		//DIGITAL_TUBE_2:
		//  andi $s5, $s4, 0x0f
		66: data <= 32'b00110010100101010000000000001111;
		//  jal DECODE
		67: data <= 32'b00001100000000000000000001001011;
		//  addi $s5, $s2, 0x400
		68: data <= 32'b00100010010101010000010000000000;
		//  j DIGITAL_TUBE_DISPLAY
		69: data <= 32'b00001000000000000000000001111001;
		//DIGITAL_TUBE_3:
		//  andi $s5, $s4, 0xf0
		70: data <= 32'b00110010100101010000000011110000;
		//  srl $s5, $s5, 4
		71: data <= 32'b00000000000101011010100100000010;
		//  jal DECODE
		72: data <= 32'b00001100000000000000000001001011;
		//  addi $s5, $s2, 0x800
		73: data <= 32'b00100010010101010000100000000000;
		//  j DIGITAL_TUBE_DISPLAY
		74: data <= 32'b00001000000000000000000001111001;
		//DECODE:
		//  addi $s2, $zero, 0xc0
		75: data <= 32'b00100000000100100000000011000000;
		//  beq $zero, $s5, DECODE_COMPLETE
		76: data <= 32'b00010000000101010000000000101011;
		//  addi $s2, $zero, 0xf9
		77: data <= 32'b00100000000100100000000011111001;
		//  addi $s6, $zero, 1
		78: data <= 32'b00100000000101100000000000000001;
		//  beq $s6, $s5, DECODE_COMPLETE
		79: data <= 32'b00010010110101010000000000101000;
		//  addi $s2, $zero, 0xa4
		80: data <= 32'b00100000000100100000000010100100;
		//  addi $s6, $zero, 2
		81: data <= 32'b00100000000101100000000000000010;
		//  beq $s6, $s5, DECODE_COMPLETE
		82: data <= 32'b00010010110101010000000000100101;
		//  addi $s2, $zero, 0xb0
		83: data <= 32'b00100000000100100000000010110000;
		//  addi $s6, $zero, 3
		84: data <= 32'b00100000000101100000000000000011;
		//  beq $s6, $s5, DECODE_COMPLETE
		85: data <= 32'b00010010110101010000000000100010;
		//  addi $s2, $zero, 0x99
		86: data <= 32'b00100000000100100000000010011001;
		//  addi $s6, $zero, 4
		87: data <= 32'b00100000000101100000000000000100;
		//  beq $s6, $s5, DECODE_COMPLETE
		88: data <= 32'b00010010110101010000000000011111;
		//  addi $s2, $zero, 0x92
		89: data <= 32'b00100000000100100000000010010010;
		//  addi $s6, $zero, 5
		90: data <= 32'b00100000000101100000000000000101;
		//  beq $s6, $s5, DECODE_COMPLETE
		91: data <= 32'b00010010110101010000000000011100;
		//  addi $s2, $zero, 0x82
		92: data <= 32'b00100000000100100000000010000010;
		//  addi $s6, $zero, 6
		93: data <= 32'b00100000000101100000000000000110;
		//  beq $s6, $s5, DECODE_COMPLETE
		94: data <= 32'b00010010110101010000000000011001;
		//  addi $s2, $zero, 0xf8
		95: data <= 32'b00100000000100100000000011111000;
		//  addi $s6, $zero, 7
		96: data <= 32'b00100000000101100000000000000111;
		//  beq $s6, $s5, DECODE_COMPLETE
		97: data <= 32'b00010010110101010000000000010110;
		//  addi $s2, $zero, 0x80
		98: data <= 32'b00100000000100100000000010000000;
		//  addi $s6, $zero, 8
		99: data <= 32'b00100000000101100000000000001000;
		//  beq $s6, $s5, DECODE_COMPLETE
		100: data <= 32'b00010010110101010000000000010011;
		//  addi $s2, $zero, 0x90
		101: data <= 32'b00100000000100100000000010010000;
		//  addi $s6, $zero, 9
		102: data <= 32'b00100000000101100000000000001001;
		//  beq $s6, $s5, DECODE_COMPLETE
		103: data <= 32'b00010010110101010000000000010000;
		//  addi $s2, $zero, 0x88
		104: data <= 32'b00100000000100100000000010001000;
		//  addi $s6, $zero, 0x0a
		105: data <= 32'b00100000000101100000000000001010;
		//  beq $s6, $s5, DECODE_COMPLETE
		106: data <= 32'b00010010110101010000000000001101;
		//  addi $s2, $zero, 0x83
		107: data <= 32'b00100000000100100000000010000011;
		//  addi $s6, $zero, 0x0b
		108: data <= 32'b00100000000101100000000000001011;
		//  beq $s6, $s5, DECODE_COMPLETE
		109: data <= 32'b00010010110101010000000000001010;
		//  addi $s2, $zero, 0xc6
		110: data <= 32'b00100000000100100000000011000110;
		//  addi $s6, $zero, 0x0c
		111: data <= 32'b00100000000101100000000000001100;
		//  beq $s6, $s5, DECODE_COMPLETE
		112: data <= 32'b00010010110101010000000000000111;
		//  addi $s2, $zero, 0xa1
		113: data <= 32'b00100000000100100000000010100001;
		//  addi $s6, $zero, 0x0d
		114: data <= 32'b00100000000101100000000000001101;
		//  beq $s6, $s5, DECODE_COMPLETE
		115: data <= 32'b00010010110101010000000000000100;
		//  addi $s2, $zero, 0x86
		116: data <= 32'b00100000000100100000000010000110;
		//  addi $s6, $zero, 0x0e
		117: data <= 32'b00100000000101100000000000001110;
		//  beq $s6, $s5, DECODE_COMPLETE
		118: data <= 32'b00010010110101010000000000000001;
		//  addi $s2, $zero, 0x8e
		119: data <= 32'b00100000000100100000000010001110;
		//DECODE_COMPLETE:
		//  jr $ra
		120: data <= 32'b00000011111000000000000000001000;
		//DIGITAL_TUBE_DISPLAY:
		//  sw $s5, 20($s0)
		121: data <= 32'b10101110000101010000000000010100;
		//  lw $t3, 8($s0)
		122: data <= 32'b10001110000010110000000000001000;
		//  addi $t4, $zero, 2
		123: data <= 32'b00100000000011000000000000000010;
		//  or $t3, $t3, $t4
		124: data <= 32'b00000001011011000101100000100101;
		//  sw $t3, 8($s0)
		125: data <= 32'b10101110000010110000000000001000;
		//  addi $26, $26, -4
		126: data <= 32'b00100011010110101111111111111100;
		//  jr $26
		127: data <= 32'b00000011010000000000000000001000;
		//EXCEPT:
		//  nop
		//128: data <= 32'b00000000000000000000000000000000;
	   default:	data <= 32'h8000_0000;
	endcase
endmodule