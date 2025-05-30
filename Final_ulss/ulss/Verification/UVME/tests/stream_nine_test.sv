class stream_nine_test extends ulss_base_test;
  // Factory registration
  `uvm_component_utils(stream_nine_test)
  
  // Constructor
  function new(string name = "stream_nine_test", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     // Configure timeout settings for driver using configuration database
   // uvm_config_db#(int)::set(this, "env.agent.drv", "wait_timeout_cycles", 200);
   // uvm_config_db#(int)::set(this, "env.agent.drv", "simulation_timeout_cycles", 2000);
    
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    stream_nine_sequence  stream_nine_sequence_inst;  // Declare separate stream_nine_sequence instance
    int repeat_count = 200;  // Number of times to repeat the sequence
    
    `uvm_info(get_full_name(), $sformatf("Starting test with %0d repetitions", repeat_count), UVM_MEDIUM)
     phase.raise_objection(this);
    `uvm_info(get_type_name(), $sformatf("inside the packet_count_limit_stream_nine_sequence_inst test"), UVM_MEDIUM)
       
    // Loop to repeat the sequence 50 times
    for (int i = 0; i < repeat_count; i++) begin
      `uvm_info(get_type_name(), $sformatf("Starting repetition %0d of %0d", i+1, repeat_count), UVM_MEDIUM)
      
      // Create and run scenario 2
      stream_nine_sequence_inst = stream_nine_sequence::type_id::create($sformatf("stream_nine_sequence_inst_%0d", i));
     // stream_nine_sequence_inst.scenario = 2;
      stream_nine_sequence_inst.num_packets = 20;           // Send 611 packets
      stream_nine_sequence_inst.delay_between_packets = 1;   // Wait 0 cycles between packets
      stream_nine_sequence_inst.token_wait = 16'h10;              // Set token wait to 8
      stream_nine_sequence_inst.tokens_per_packet = 48'hffff_ffff;       // Set tokens per packet to 1
      stream_nine_sequence_inst.start(env.agent.sqr);
      
      `uvm_info(get_type_name(), $sformatf("stream_nine_test repetition %0d completed", i+1), UVM_MEDIUM)
    end
    
    `uvm_info(get_type_name(), $sformatf("All %0d repetitions completed", repeat_count), UVM_MEDIUM)
    
    // Add drain time to allow transactions to complete
    #1000;
    phase.drop_objection(this);
  endtask
endclass
