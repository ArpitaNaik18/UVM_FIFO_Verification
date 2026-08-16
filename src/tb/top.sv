module top;

  bit clk;

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  fifo_if vif(clk);

  syn_fifo #(
    .DATA_WIDTH(8),
    .ADDR_WIDTH(8)
  ) dut (
    .clk      (vif.clk),
    .rst      (vif.rst),
    .wr_cs    (vif.wr_cs),
    .rd_cs    (vif.rd_cs),
    .wr_en    (vif.wr_en),
    .rd_en    (vif.rd_en),
    .data_in  (vif.data_in),
    .data_out (vif.data_out),
    .full     (vif.full),
    .empty    (vif.empty)
  );

  initial begin
    uvm_config_db#(virtual fifo_if)::set(
      null,
      "*",
      "vif",
      vif
    );

    run_test("fifo_test");
  end
endmodule

endmodule
