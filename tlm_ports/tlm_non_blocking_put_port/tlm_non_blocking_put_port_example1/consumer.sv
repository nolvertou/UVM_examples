//--------------------------------------------------------------
// CONSUMER: Receives packets
//--------------------------------------------------------------
class consumer extends uvm_component;
  `uvm_component_utils(consumer)

  uvm_nonblocking_put_imp #(Packet, consumer) m_put_imp;

  function new(string name = "consumer", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_put_imp = new("m_put_imp", this);
  endfunction

  virtual function bit try_put(Packet pkt);
    bit ready;

`ifndef CAN_PUT
    std::randomize(ready);
`else
    ready = 1;
`endif

    if (ready) begin
      `uvm_info("CONSUMER", "Packet received", UVM_LOW)
      pkt.print(uvm_default_line_printer);
      return 1;
    end
    else begin
      return 0;
    end
  endfunction

  virtual function bit can_put();
    return $urandom_range(0,1);
  endfunction

endclass