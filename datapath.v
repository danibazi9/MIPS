`timescale 1ns / 1ps

module datapath(
    input clk,
	 input rstPC,
    input [31:0] instruction,	
    input readDataFromMem,
    output ALUOutput,
    output writeDataToMem
    );

// wires of ALU
	wire [31:0] ALUInput;

// instantiating alu
	alu alu_inst (
		.a (readData1),
		.b (ALUInput),
		.opcode (ALUCtrl),
		.zero (zero),
		.result(ALUOutput)
	);

// control unit output wires.	 
	 wire [3:0] ALUCtrl;		
    wire [1:0] ALUOp;			
    wire ALUSrc;					
    wire branch;					
    wire memToReg;			
    wire memWrite;			
    wire memRead;					
    wire regDest;					
    wire regWrite;				
	 
// instantiating control unit 
	control_unit control_unit_inst (
		.instruction(instruction),				
		.ALUCtrl(ALUCtrl),
		.ALUOp(ALUOp),
		.regDest(regDest),
		.regWrite(regWrite),
		.ALUSrc(ALUSrc),
		.memWrite(memWrite),
		.memRead(memRead),
		.memToReg(memToReg),
		.branch(branch)
	);
	

// wires of register file
	wire [4:0] writeReg;
	wire [31:0] writeData;
	wire [31:0] readData1;
	wire [31:0] readData2;
	
	
// assign wires to register file 
	assign writeReg = regDest ? instruction[15:11] : instruction[20:16];
	assign writeData = memToReg ? readDataFromMem : ALUOutput ;
	
	
// instantiating register file
	register_file register_file_inst (
		.readAddr1(instruction[25:21]),
		.readAddr2(instruction[20:16]),
		.writeAddr(writeReg),
		.writeData(writeData),
		.writeEn(regWrite),
		.clk(clk),
		.readData1(readData1),
		.readData2(readData2)
	);
	

// assigning write to memory wires
	assign writeDataToMem = readData2;

endmodule
