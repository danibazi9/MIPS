`timescale 1ns / 1ps

module control_unit(
    input [31:0] instruction,
    output [3:0] ALUCtrl,
	 output [1:0] ALUOp,
	 output regDest,
	 output regWrite,
	 output ALUSrc,
	 output memWrite,
	 output memRead,
	 output memToReg,
	 output branch
    );
	 
	 
	wire [5:0] opcode;
	wire [4:0] rs; // first source register
	wire [4:0] rt; // second source register
	wire [15:0] func;
	
	
	reg [3:0] ALUCtrlReg;
	reg [1:0] ALUOpReg;
	reg regDstReg;
	reg regWriteReg;
	reg ALUSrcReg;
	reg memWriteReg;
	reg memReadReg;
	reg memToRegReg;
	reg branchReg;
	
	
// instruction extraction
	assign opcode = instruction[31:26];
	assign rs = instruction[25:21];
	assign rt = instruction[20:16];
	assign func = instruction[5:0];
	
	
	always @(opcode, func, rt, rs)
	begin
		case (opcode)
			6'b000000:				 
				begin
					ALUOpReg <= 2'b00;
					regDstReg <= 1'b1;
					regWriteReg <= 1'b1;
					ALUSrcReg <= 1'b0;
					memWriteReg <= 1'b0;
					memReadReg <= 1'b0;
					memToRegReg <= 1'b0;
					branchReg <= 1'b0;
					case (func)
						6'b100000: ALUCtrlReg <= 4'b0010;						
						6'b100010: ALUCtrlReg <= 4'b0110;						
						6'b100100: ALUCtrlReg <= 4'b0000;						
						6'b100101: ALUCtrlReg <= 4'b0001;						
						6'b101010: ALUCtrlReg <= 4'b0111;						
						default: ALUCtrlReg <= 4'bxxxx; 
					endcase
				end
			// lw	
			6'b100010:
				begin
					ALUCtrlReg <= 4'b0010;
					ALUSrcReg <= 1'b1;
					memWriteReg <= 1'b0;
					memReadReg <= 1'b1;
					ALUOpReg <= 2'b00;
					regDstReg <= 1'b0;
					regWriteReg <= 1'b1;
					memToRegReg <= 1'b1;
					branchReg <= 1'b0;
				end
			// sw	
			6'b101011:
				begin
					ALUCtrlReg <= 4'b0010;
					ALUSrcReg <= 1'b1;
					memWriteReg <= 1'b1;
					memReadReg <= 1'b0;
					ALUOpReg <= 2'b00;
					regDstReg <= 1'bx;
					regWriteReg <= 1'b0;
					memToRegReg <= 1'bx;
					branchReg <= 1'b0;
				end
			// branch -> it's not asked to be implemented but maybe in 	future it is required
			6'b000010:
				begin
					ALUCtrlReg <= 4'b0110;
					ALUSrcReg <= 1'b0;
					memWriteReg <= 1'b0;
					memReadReg <= 1'b0;
					ALUOpReg <= 2'b01;
					regDstReg <= 1'bx;
					regWriteReg <= 1'bx;
					memToRegReg <= 1'bx;
					branchReg <= 1'b1;
				end
		endcase
	end

	 assign ALUCtrl = ALUCtrlReg;
	 assign ALUOp = ALUOpReg;
	 assign regDst = regDstReg;
	 assign regWrite = regWriteReg;
	 assign ALUSrc = ALUSrcReg;
	 assign memWrite = memWriteReg;
	 assign memRead = memReadReg;
	 assign memToReg = memToRegReg;
	 assign branch = branchReg;

endmodule
