`timescale 1ns / 1ps

module datapath_tb;

	// Inputs
	reg clk;
	reg rstPC;
	reg [31:0] instruction;
	reg readDataFromMem;

	// Outputs
	wire ALUOutput;
	wire writeDataToMem;

	// Instantiate the Unit Under Test (UUT)
	datapath uut (
		.clk(clk), 
		.rstPC(rstPC), 
		.instruction(instruction), 
		.readDataFromMem(readDataFromMem), 
		.ALUOutput(ALUOutput), 
		.writeDataToMem(writeDataToMem)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rstPC = 0;
		instruction = 0;
		readDataFromMem = 0;

		// Wait 100 ns for global reset to finish
		#100;
		instruction = 8'h00000001;
		#100;
		instruction = 8'h00000010;
		#100;
		instruction = 8'h00000100;
		#100;
		instruction = 8'h00001000;
		#100;
		instruction = 8'h00010000;
		#100;
		instruction = 8'h00100000;
		#100;
		instruction = 8'h01000000;
		#100;
		instruction = 8'h10000000;
      
		// Add stimulus here

	end
	
	initial begin
		forever
			begin
				#50
				clk = ~clk;
			end
	end
      
endmodule

