// Project 3: four-channel complex weighted spatial combiner.
// Inputs: signed 12-bit I/Q; coefficients signed Q1.7 (8-bit), independently
// programmable complex weights for each antenna. One output per valid input.
module beamformer4 (
 input wire clk, rst_n, sample_valid,
 input wire signed [11:0] i0,i1,i2,i3,q0,q1,q2,q3,
 input wire signed [7:0] wr0,wr1,wr2,wr3,wi0,wi1,wi2,wi3,
 output reg out_valid,
 output reg signed [15:0] out_i,out_q
);
 wire signed [19:0] ri0=i0*wr0, ri1=i1*wr1, ri2=i2*wr2, ri3=i3*wr3;
 wire signed [19:0] iq0=q0*wi0, iq1=q1*wi1, iq2=q2*wi2, iq3=q3*wi3;
 wire signed [19:0] qi0=q0*wr0, qi1=q1*wr1, qi2=q2*wr2, qi3=q3*wr3;
 wire signed [19:0] ir0=i0*wi0, ir1=i1*wi1, ir2=i2*wi2, ir3=i3*wi3;
 wire signed [22:0] isum =
    ($signed(ri0)-$signed(iq0)) + ($signed(ri1)-$signed(iq1)) +
    ($signed(ri2)-$signed(iq2)) + ($signed(ri3)-$signed(iq3));
 wire signed [22:0] qsum =
    ($signed(qi0)+$signed(ir0)) + ($signed(qi1)+$signed(ir1)) +
    ($signed(qi2)+$signed(ir2)) + ($signed(qi3)+$signed(ir3));
 wire signed [22:0] si=isum >>> 7;
 wire signed [22:0] sq=qsum >>> 7;
 function [15:0] sat16;
 input signed [22:0] a;
 begin
  if(a>23'sd32767) sat16=16'h7fff;
  else if(a< -23'sd32768) sat16=16'h8000;
  else sat16=a[15:0];
 end
 endfunction
 always @(posedge clk or negedge rst_n) begin
  if(!rst_n) begin out_i<=0;out_q<=0;out_valid<=0;end
  else begin
   out_valid<=sample_valid;
   if(sample_valid) begin out_i<=sat16(si);out_q<=sat16(sq);end
  end
 end
endmodule
