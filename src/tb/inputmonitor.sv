class fifo_inp_mon extends uvm_monitor;

 'uvm_component_utils(fifo_inp_mon);

 uvm_analysis_port #(trans) inp_mon_port;

 virtual fifo_if.INP_MON vif;

 fifo_config m_config;

  function new(string name="fifo_inp_mon", uvm_component parent);
   super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase)
   super.build_phase(phase);

  (!uvm_config_db #(fifo_config):: get(this, "", m_config, vif)
    `uvm_fatal(get_type_name(), "Failed to get configuration");

  inp_mon_port = new("inp_mon_port",this);
  endfunction

  funcion void connect_phase(uvm_phase phase)
    super.connect_phase(phase);

    vif = m_config;
  endfunction

 task run_phase;

  forever begin

   collect_data();

  end
endtask

 trans rd_data;

  task collect_data;

   rd_data.wr_cs = vif.inp_mon.wr_cs;
   rd_data.wr_en = vif.inp_mon.wr_en;
   rd_data.rd_en = vif.inp_mon.rd_en;
   rd_data.rd_cs = vif.inp_mon.rd_cs;
   rd-data.data_in = vif.inp_mon.data_in;
 endtask

endclass
