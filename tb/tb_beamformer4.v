`timescale 1ns/1ps
module tb_beamformer4;
reg clk=0;always #5 clk=~clk;
reg rst_n=0,sample_valid=0;
reg signed [11:0] i0=0,i1=0,i2=0,i3=0,q0=0,q1=0,q2=0,q3=0;
reg signed [7:0] wr0=0,wr1=0,wr2=0,wr3=0,wi0=0,wi1=0,wi2=0,wi3=0;
wire out_valid;wire signed [15:0] out_i,out_q;
beamformer4 dut(clk,rst_n,sample_valid,i0,i1,i2,i3,q0,q1,q2,q3,
 wr0,wr1,wr2,wr3,wi0,wi1,wi2,wi3,out_valid,out_i,out_q);
initial begin
 repeat(3) @(negedge clk);rst_n=1;
 @(negedge clk);sample_valid=1;
 i0=100;i1=200;i2=300;i3=400;
 q0=-100;q1=-200;q2=-300;q3=-400;
 wr0=64;wr1=64;wr2=64;wr3=64; // 0.5 real per channel
 wi0=0;wi1=0;wi2=0;wi3=0;
 @(negedge clk);
 if(!out_valid || out_i!==500 || out_q!==-500)
  $fatal(1,"beamformer test1 failed i=%0d q=%0d valid=%b",out_i,out_q,out_valid);
 // Complex rotation on channel 0 only: (100-j100)*j0.5=50+j50
 i0=100;q0=-100; i1=0;i2=0;i3=0;q1=0;q2=0;q3=0;
 wr0=0;wr1=0;wr2=0;wr3=0;wi0=64;
 @(negedge clk);
 if(!out_valid || out_i!==50 || out_q!==50)
  $fatal(1,"beamformer test2 failed i=%0d q=%0d",out_i,out_q);
 $display("PASS beamformer complex weights I=%0d Q=%0d",out_i,out_q);$finish;
end
initial begin #1000;$fatal(1,"timeout");end
endmodule
