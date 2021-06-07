`timescale 1ns / 1ps

module alu(opcode, a, b, result, zero);
	input [3:0] opcode;
	input [31:0] a;
	input [31:0] b;
	output reg [31:0] result;
	output reg zero;
	reg [31:0] y;
	integer i;
	
	always @(opcode, a, b)
	begin
		case(opcode)
			4'b0000: // ADD
			begin
				result <= a + b;
			end
			4'b0001: // SUB: a - b
			begin
				result <= a + (~b + 1); 
			end
			4'b0010: // AND
			begin
				result <= a & b;
			end
			4'b0011: // OR
			begin
				result <= a | b;
			end
			4'b0100: // XOR
			begin
				result <= a ^ b;
			end
			4'b0101: // LUI
			begin
				result <= a;
			end
			4'b0110: // SLL
			begin
				y = a;
				for(i = b ; i > 0 ; i = i - 1) begin
					y = {y[30:0], 1'b0};
				end
				result <= y;				
			end
			4'b0111: // SRL
			begin
				y = a;
				for(i = b ; i > 0 ; i = i - 1) begin
					y = {1'b0, y[31:1]};
				end
				result <= y;
			end
			4'b1000: // SRA
			begin
				y = a;
				for(i = b ; i > 0 ; i = i - 1) begin
					y = {y[31], y[31:1]};
				end
				result <= y;
			end
		endcase
	end
	
	always @(result) begin
		if (result == 0) begin
			zero <= 1;
		end else begin
			zero <= 0;
		end
	
	end
	
endmodule
