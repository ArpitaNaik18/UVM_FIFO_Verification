class fifo_trans extends uvm_sequence_item;

  `uvm_object_utils(fifo_trans)

  rand bit rst;

  rand bit wr_cs;
  rand bit rd_cs;

  rand bit wr_en;
  rand bit rd_en;

  rand bit [7:0] data_in;

  bit [7:0] data_out;

  bit full;
  bit empty;

  constraint c_rst {
    rst dist {0:=95, 1:=5};
  }

  constraint c_wr_cs {
    wr_cs dist {0:=20, 1:=80};
  }

  constraint c_rd_cs {
    rd_cs dist {0:=20, 1:=80};
  }

  constraint c_wr_en {
    wr_en dist {0:=30, 1:=70};
  }

  constraint c_rd_en {
    rd_en dist {0:=30, 1:=70};
  }
  constraint c_data_in {
    data_in inside {[0:256]};
  }


  function new(string name="fifo_trans");
    super.new(name);
  endfunction

  virtual function void do_copy(uvm_object rhs);

    fifo_trans rhs_;

    if(!$cast(rhs_, rhs))
      `uvm_fatal("DO_COPY","Cast Failed")

    super.do_copy(rhs);

    rst      = rhs_.rst;
    wr_cs    = rhs_.wr_cs;
    rd_cs    = rhs_.rd_cs;
    wr_en    = rhs_.wr_en;
    rd_en    = rhs_.rd_en;
    data_in  = rhs_.data_in;
    data_out = rhs_.data_out;
    full     = rhs_.full;
    empty    = rhs_.empty;

  endfunction


  virtual function bit do_compare(uvm_object rhs,
                                  uvm_comparer comparer);

    fifo_trans rhs_;

    if(!$cast(rhs_, rhs))
      `uvm_fatal("DO_COMPARE","Cast Failed")

    return super.do_compare(rhs, comparer) &&
           (data_out == rhs_.data_out) &&
           (full     == rhs_.full) &&
           (empty    == rhs_.empty);

  endfunction


  virtual function void do_print(uvm_printer printer);

    super.do_print(printer);

    printer.print_field("RST",      rst,      1, UVM_BIN);
    printer.print_field("WR_CS",    wr_cs,    1, UVM_BIN);
    printer.print_field("RD_CS",    rd_cs,    1, UVM_BIN);
    printer.print_field("WR_EN",    wr_en,    1, UVM_BIN);
    printer.print_field("RD_EN",    rd_en,    1, UVM_BIN);

    printer.print_field("DATA_IN",  data_in,  8, UVM_HEX);
    printer.print_field("DATA_OUT", data_out, 8, UVM_HEX);

    printer.print_field("FULL",     full,     1, UVM_BIN);
    printer.print_field("EMPTY",    empty,    1, UVM_BIN);

  endfunction

endclass
