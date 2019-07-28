`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/07/08 18:45:53
// Design Name: 
// Module Name: Rising2En
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Rising2En #( parameter SYNC_STG = 1 )(
    input wire clk, in,
    output logic en, out
);
    logic [SYNC_STG : 0] dly;
    always_ff@(posedge clk) begin
        dly <= {dly[SYNC_STG - 1 : 0], in};    
    end
    assign en = (SYNC_STG ? dly[SYNC_STG -: 2] : {dly, in}) == 2'b01;
    assign out = dly[SYNC_STG];
endmodule