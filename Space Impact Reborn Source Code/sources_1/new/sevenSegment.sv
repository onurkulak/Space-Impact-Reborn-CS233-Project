////////////////////////////////////////////////////////
//  
//  display_controller.sv
//
//  by Will Sawyer  14 March 2016
//
//  puts 4 4-digit hexadecimal values on the 4-digit 7-segment display
//     unit on the BASYS3 board, with enable signals for each digit
//
//  the AN, Cx and DP outputs are active-low, for the BASYS3 board
//    AN3 is the left-most digit, AN2 is the second-left-most, etc
//    C[6] is CA for the A segment, C[5] is CB for the B segment, etc
//  
//  For physical implementation, it needs a 100 MHz clock, and a clear signal
//
//  Be sure to get this display_controller working in simulation and 
//    verify its correct input-output behavior before using it in other
//    modules.   When simulating, be sure to modify the count to be 2 bit
//    or at most 3 bits, so that wait times are greatly reduced.
//
//  When synthesizing to the FPGA chip on the BASYS3 board, sure to use the
//    correct constraints in the .xdc file:
//	use the constraint for the 100 M Hz clock signal
//	use the constraint for a switch or pushbutton clear signal
//	use the constraint to connect V7 as the DP signal
//	use the constraints to connect the 7 cathodes (U7 to W7) as the CA to CG signals
//	use the constraints to connect the 4 anodes (W4 to U2) as the AN3 to AN0 signals
//  
//////////////////////////////////////////////////////// 

module display_controller (
		input logic clk, clear,
		input logic [3:0] enables, 
		input logic [3:0] digit3, digit2, digit1, digit0,
		output logic [3:0] AN,
		output logic [0:6] C,
		output logic DP
		);


// internal signals ("wires") are defined here

		logic [3:0] current_digit, cur_dig_AN;
		logic [6:0] segments;


// the outputs are all continuously assigned

	assign AN = ~(enables & cur_dig_AN);// AN signals are active low,
                                	// and must be enabled to display digit

      	assign C = ~segments;     	// since the C values are active low

      	assign DP = 1;            	// the dot point is always off 
                                	// (0 = on, since it is active low)
		

// the 19-bit counter, runs at 100 MHz, so bit17 changes each 1.3 millisecond

	
	logic [18:0] count, nextcount;

	always_ff @(posedge clk)
		if(clear) count <= 0;
		else count <= nextcount;

	always_comb
		nextcount = count + 1;
	
	
// the upper 2 bits of the counter cycle through the digits and the AN patterns
			
	always_comb
	   case (count[18:17])
                // left most is AN3  
		2'b00: begin current_digit = digit3; cur_dig_AN = 4'b1000; end  
		2'b01: begin current_digit = digit2; cur_dig_AN = 4'b0100; end
		2'b10: begin current_digit = digit1; cur_dig_AN = 4'b0010; end
		2'b11: begin current_digit = digit0; cur_dig_AN = 4'b0001; end
                // right most is AN0
	   endcase	   
	   

// the hex-to-7-segment decoder
	always_comb
		case (current_digit)
		4'b0000: segments = 7'b111_1110;  // 0
		4'b0001: segments = 7'b011_0000;  // 1
		4'b0010: segments = 7'b110_1101;  // 2
		4'b0011: segments = 7'b111_1001;  // 3
		4'b0100: segments = 7'b011_0011;  // 4
		4'b0101: segments = 7'b101_1011;  // 5
		4'b0110: segments = 7'b101_1111;  // 6
		4'b0111: segments = 7'b111_0000;  // 7
		4'b1000: segments = 7'b111_1111;  // 8
		4'b1001: segments = 7'b111_0011;  // 9
		4'b1010: segments = 7'b111_0111;  // A
		4'b1011: segments = 7'b001_1111;  // b
		4'b1100: segments = 7'b000_1101;  // c
		4'b1101: segments = 7'b011_1101;  // d
		4'b1110: segments = 7'b100_1111;  // E
		4'b1111: segments = 7'b100_0111;  // F
		default: segments = 7'bxxx_xxxx;
		endcase		


		
endmodule
