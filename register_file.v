`timescale 1ns / 1ps

module register_file(
	readAddr1,
	readAddr2,
	writeAddr,
	writeData,
	writeEn,
	clk,
	readData1,
	readData2
	);
	 
	 input [4:0] readAddr1;
    input [4:0] readAddr2;
    input [4:0] writeAddr;
    input [31:0] writeData;
    input writeEn;
    input clk;
    output [31:0] readData1;
    output [31:0] readData2;
	 
	reg [31:0] readData1reg;
	reg [31:0] readData2reg;
	// 32 * 32 bit memory
	reg [31:0] registers [31:0];
	
	// register $zero is always assinged to 0
	initial
		begin
			registers[0] <= 32'b00000000000000000000000000000000;
		end	
	
	// positive edge triggered
	always @(posedge clk)
		begin
			if (writeEn == 1'b1)
				begin
					registers[writeAddr] <=  writeData;
				end
			else
				begin
					readData1reg <= registers[readAddr1];
					readData2reg <= registers[readAddr2];
				end
		end

	assign readData1 = readData1reg;
	assign readData2 = readData2reg;
	
endmodule
