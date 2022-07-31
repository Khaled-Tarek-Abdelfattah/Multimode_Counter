module up_down_counter(count_intf dutint);
  
  bit [3:0] counter_up_down;
  bit [3:0] wincount;
  bit [3:0] losecount;
  bit wflag;
  bit lflag;
  bit [3:0] initoldvalue;
  bit init;
  bit gameflag;
  bit [1:0] whoflag;
  
  initial begin
    counter_up_down <= 1;
  end
  
  always @(posedge dutint.clk or posedge dutint.reset) begin
    

  /*Asynchrounous reset active high when enabled it initiate the 	counter to 1*/
    if(dutint.reset == 1) begin 
      counter_up_down <= 4'b0001;
    end
    
	else begin
      /*if the reset is low so continue and check if the init flag is high*/
      if(init == 1) begin
        counter_up_down <= 4'b0001;
        lflag <= 0;
        wflag <= 0;
        gameflag <= 0;
        init <= 0;
      end
      else begin
        /*check the win conter if it's 15 so rise the output game over and spacify the winner and initiate the counters*/
        if(wincount == 4'b1111) begin
          gameflag <= 1;
          whoflag <= 2'b10;
          init <= 1;
          wincount <= 0;
        end

        else if(losecount == 4'b1111) begin
          gameflag <= 1;
          whoflag <= 2'b01;
          init <= 1;
          losecount <=0;
        end
        else begin
          /*check the input up_down and based on it's value take the action*/
          if(dutint.up_down == 2'b00) begin
            counter_up_down <= counter_up_down + 4'd1;
          end

          if(dutint.up_down == 2'b01) begin
            counter_up_down <= counter_up_down + 4'd2;
          end

          if(dutint.up_down == 2'b10) begin
            counter_up_down <= counter_up_down - 4'd1;
          end

          if(dutint.up_down == 2'b11) begin
            counter_up_down <= counter_up_down - 4'd2;
          end
          if(dutint.initvalue != initoldvalue) begin
            counter_up_down <= dutint.initvalue;
            initoldvalue <= dutint.initvalue;
          end
		  /*check the counter and if it 0 or 15 raise lose flage or winflage and increment it's counter and initialize the counter again*/
          if(counter_up_down == 4'b1111) begin
            wflag <= 1;
            wincount <= wincount + 4'd1;
            init <=1;
          end

          if(counter_up_down == 4'b0000) begin
            lflag <= 1;
            losecount <= losecount + 4'd1;
            init <=1;
          end
        end
      end
    end
  end 
  /*Assignment of the outputs*/
  assign dutint.counter = counter_up_down;
  assign dutint.winner = wflag;
  assign dutint.loser = lflag;
  assign dutint.gameover = gameflag;
  assign dutint.who = whoflag;
  
endmodule

module top;
  bit clk;
  initial begin 
    clk=0;
    forever #10 clk=~clk;
    end
  
  count_intf i1(clk);
  up_down_counter dut1(i1.dut);
  updowncounter_testbench t1(i1.tb);
  
  initial begin
    $dumpfile("waves.vcd");
    $dumpvars;
    #2100 $finish;
  end
endmodule
