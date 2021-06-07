`timescale 1ns / 1ps


module control_unit(
    input [31:0] iw,				// instruction word
    output [3:0] ALUCtrl,
	 output [1:0] ALUOp,
	 output regDst,
	 output regWrite,
	 output ALUSrc,
	 output memWrite,
	 output memRead,
	 output memToReg,
	 output branch
    );
	 
	 
	wire [5:0] opcode;
	wire [4:0] rs;
	wire [4:0] rt;
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
	
	
// extracting instruction word
	assign opcode = iw[31:26];
	assign rs = iw[25:21];
	assign rt = iw[20:16];
	assign func = iw[5:0];
	
	
	always @(opcode,func)
	begin
		case (opcode)
			6'b000000:				// R-type 
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
						6'b100000:begin ALUCtrlReg <= 4'b0010;	end					// add
						6'b100010:begin ALUCtrlReg <= 4'b0110;	end					// subtract
						6'b100100:begin ALUCtrlReg <= 4'b0000;	end					// AND
						6'b100101:begin ALUCtrlReg <= 4'b0001;	end					// OR
						6'b101010:begin ALUCtrlReg <= 4'b0111;	end					// set-on-less-than
						default:begin ALUCtrlReg <= 4'bxxxx; end
					endcase
				end
				
			6'b100010:			// load
				begin
					ALUCtrlReg <= 4'b0010;
					ALUOpReg <= 2'b00;
					regDstReg <= 1'b0;
					regWriteReg <= 1'b1;
					ALUSrcReg <= 1'b1;
					memWriteReg <= 1'b0;
					memReadReg <= 1'b1;
					memToRegReg <= 1'b1;
					branchReg <= 1'b0;
				end
				
			6'b101011:			//	store
				begin
					ALUCtrlReg <= 4'b0010;
					ALUOpReg <= 2'b00;
					regDstReg <= 1'bx;
					regWriteReg <= 1'b0;
					ALUSrcReg <= 1'b1;
					memWriteReg <= 1'b1;
					memReadReg <= 1'b0;
					memToRegReg <= 1'bx;
					branchReg <= 1'b0;
				end
				
			6'b000010:				// branch
				begin
					ALUCtrlReg <= 4'b0110;
					ALUOpReg <= 2'b01;
					regDstReg <= 1'bx;
					regWriteReg <= 1'bx;
					ALUSrcReg <= 1'b0;
					memWriteReg <= 1'b0;
					memReadReg <= 1'b0;
					memToRegReg <= 1'bx;
					branchReg <= 1'b1;
				end
				
			default:
				begin
					ALUCtrlReg <= 4'bxxxx;
					ALUOpReg <= 2'bxx;
					regDstReg <= 1'bx;
					regWriteReg <= 1'bx;
					ALUSrcReg <= 1'bx;
					memWriteReg <= 1'bx;
					memReadReg <= 1'bx;
					memToRegReg <= 1'bx;
					branchReg <= 1'bx;
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
