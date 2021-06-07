`timescale 1ns / 1ps

module alu_tb;
	reg [3:0] opcode;
	reg [31:0] a;
	reg [31:0] b;

	wire [31:0] result;

	alu uut (
		.opcode(opcode), 
		.a(a), 
		.b(b), 
		.result(result)
	);

	initial begin
		a = 101010101;
		b = 11;
		opcode = 0;
		#100;
		opcode = 1;
		#100;
		opcode = 2;
		#100;
		opcode = 3;
		#100;
		opcode = 4;
		#100;
		opcode = 5;
		#100;
		opcode = 6;
		#100;
		opcode = 7;
		#100;		
		opcode = 8;
		$finish;
	end
endmodule

