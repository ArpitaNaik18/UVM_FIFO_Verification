class reset_seq extends uvm_sequence #(fifo_trans);
  `uvm_object_utils(reset_seq)

  function new(string name="reset_seq");
    super.new(name);
  endfunction

  task body();
    req = fifo_trans::type_id::create("req");

    start_item(req);
    assert(req.randomize() with {
      rst   == 1;
      wr_cs == 0;
      rd_cs == 0;
      wr_en == 0;
      rd_en == 0;
    });
    finish_item(req);
  endtask

endclass



class write_seq extends uvm_sequence #(fifo_trans);
  `uvm_object_utils(write_seq)

  function new(string name="write_seq");
    super.new(name);
  endfunction

  task body();
    req = fifo_trans::type_id::create("req");

    start_item(req);
    assert(req.randomize() with {
      rst   == 0;
      wr_cs == 1;
      wr_en == 1;
      rd_cs == 0;
      rd_en == 0;
    });
    finish_item(req);
  endtask

endclass



class read_seq extends uvm_sequence #(fifo_trans);
  `uvm_object_utils(read_seq)

  function new(string name="read_seq");
    super.new(name);
  endfunction

  task body();
    req = fifo_trans::type_id::create("req");

    start_item(req);
    assert(req.randomize() with {
      rst   == 0;
      wr_cs == 0;
      wr_en == 0;
      rd_cs == 1;
      rd_en == 1;
    });
    finish_item(req);
  endtask

endclass



class simultaneous_rw_seq extends uvm_sequence #(fifo_trans);
  `uvm_object_utils(simultaneous_rw_seq)

  function new(string name="simultaneous_rw_seq");
    super.new(name);
  endfunction

  task body();
    req = fifo_trans::type_id::create("req");

    start_item(req);
    assert(req.randomize() with {
      rst   == 0;
      wr_cs == 1;
      wr_en == 1;
      rd_cs == 1;
      rd_en == 1;
    });
    finish_item(req);
  endtask

endclass



class random_seq extends uvm_sequence #(fifo_trans);
  `uvm_object_utils(random_seq)

  function new(string name="random_seq");
    super.new(name);
  endfunction

  task body();

    repeat (100) begin

      req = fifo_trans::type_id::create("req");

      start_item(req);
      assert(req.randomize());
      finish_item(req);

    end

  endtask

endclass
