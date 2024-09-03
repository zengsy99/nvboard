module led(
  input clk,
  input rst,
  input [4:0] btn,
  input [7:0] sw,
  output [15:0] ledr
);
  reg [31:0] count;
  reg [7:0] led;
  always @(posedge clk) begin
    if (rst) begin led <= 1; count <= 0; end
    else begin
      if (count == 0) led <= {led[6:0], led[7]};
      count <= (count >= 5000000 ? 32'b0 : count + 1);
    end
  end
  wire led_2;
  assign led_2 = sw[0] ^ sw[1] ^ sw[0];

  assign ledr = {led[7:5], led[4:0] ^ btn, sw[7:3],led_2, sw[1:0]};
endmodule
