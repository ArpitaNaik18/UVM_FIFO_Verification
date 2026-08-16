class fifo_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(fifo_scoreboard)

  uvm_analysis_imp #(fifo_transaction, fifo_scoreboard) sb_port;

  bit [DATA_WIDTH-1:0] expected_fifo[$];

  function new(string name = "fifo_scoreboard",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sb_port = new("sb_port", this);
  endfunction

  function void write(fifo_transaction tr);

    // Write transaction
    if (tr.wr_cs && tr.wr_en && !tr.full) begin
      expected_fifo.push_back(tr.data_in);

      `uvm_info("SCOREBOARD",
                $sformatf("WRITE: data=%0d", tr.data_in),
                UVM_MEDIUM)
    end

    // Read transaction
    if (tr.rd_cs && tr.rd_en && !tr.empty) begin

      if (expected_fifo.size() == 0) begin
        `uvm_error("SCOREBOARD",
                   "Read occurred but expected FIFO is empty")
      end
      else begin

        bit [DATA_WIDTH-1:0] expected_data;

        expected_data = expected_fifo.pop_front();

        if (expected_data == tr.data_out) begin
          `uvm_info("SCOREBOARD",
                    $sformatf("READ PASS: Expected=%0d Actual=%0d",
                              expected_data, tr.data_out),
                    UVM_MEDIUM)
        end
        else begin
          `uvm_error("SCOREBOARD",
                     $sformatf("READ FAIL: Expected=%0d Actual=%0d",
                               expected_data, tr.data_out))
        end

      end
    end

  endfunction

endclass
