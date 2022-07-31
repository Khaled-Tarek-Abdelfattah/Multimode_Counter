interface count_intf(input clk);
  bit reset;
  bit[3:0] initvalue;
  bit[1:0]up_down;
  bit[3:0]counter;
  bit winner;
  bit loser;
  bit gameover;
  bit[1:0] who;
  
  clocking cb @(posedge clk);
    default input #5ns output #2ns;
    output reset, initvalue,up_down;
    input counter,winner,loser,gameover,who;
  endclocking
  
  modport dut(input reset,input initvalue,input up_down, output counter,output winner,output loser,output gameover,output who);
  
  modport tb(clocking cb);
endinterface

module updowncounter_testbench(count_intf tbint);

  
    initial begin
      tbint.cb.reset <= 0;
      tbint.cb.up_down <= 0;
      tbint.cb.initvalue <= 4'b1100;
      #40;
      tbint.cb.initvalue <= 4'b0110;
      tbint.cb.up_down <= 2'b01;
      #140;
      tbint.cb.initvalue <= 4'b0101;
      tbint.cb.up_down <= 2'b10;
      #60;
      tbint.cb.reset <= 1;
      tbint.cb.up_down <= 2'b11;
      #60;
      tbint.cb.reset <= 0;
      tbint.cb.up_down <= 3'b10;
      #20;
      tbint.cb.up_down <= 1;
      #220;
      tbint.cb.initvalue <= 4'b0110;
      tbint.cb.up_down <= 2'b11;
      #120;
      tbint.cb.initvalue <= 4'b0010;
      tbint.cb.up_down <= 2'b11;
      #80;
      tbint.cb.initvalue <= 4'b0110;
      tbint.cb.up_down <= 2'b11;
      #120;
      tbint.cb.initvalue <= 4'b0100;
      tbint.cb.up_down <= 2'b11;
      #80;
      tbint.cb.initvalue <= 4'b0010;
      tbint.cb.up_down <= 2'b11;
      #80;
      tbint.cb.initvalue <= 4'b0110;
      tbint.cb.up_down <= 2'b11;
      #120;
      tbint.cb.initvalue <= 4'b0010;
      tbint.cb.up_down <= 2'b11;
      #80;
      tbint.cb.initvalue <= 4'b0110;
      tbint.cb.up_down <= 2'b11;
      #120;
      tbint.cb.initvalue <= 4'b0100;
      tbint.cb.up_down <= 2'b11;
      #80;
      tbint.cb.initvalue <= 4'b0010;
      tbint.cb.up_down <= 2'b11;
      #80;
      tbint.cb.initvalue <= 4'b0110;
      tbint.cb.up_down <= 2'b11;
      #120;
      tbint.cb.initvalue <= 4'b0010;
      tbint.cb.up_down <= 2'b11;
      #80;
      tbint.cb.initvalue <= 4'b0100;
      tbint.cb.up_down <= 2'b11;
      #80;
      tbint.cb.initvalue <= 4'b0010;
      tbint.cb.up_down <= 2'b11;
      #80;
      tbint.cb.initvalue <= 4'b0100;
      tbint.cb.up_down <= 2'b11;
      #160;
      tbint.cb.reset <= 1;
      
  end
  
  
endmodule