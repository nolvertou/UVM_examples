//--------------------------------------------------------------
// PRODUCER: Sends packets
//--------------------------------------------------------------
class producer extends uvm_component;
  `uvm_component_utils(producer)

  uvm_nonblocking_put_port #(Packet) m_put_port;
  int m_num_tx;

  function new(string name = "producer", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_put_port = new("m_put_port", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    repeat (m_num_tx) begin
      bit success;
      Packet pkt = Packet::type_id::create("pkt");
      assert(pkt.randomize());

      `uvm_info("PRODUCER", "Packet sent to CONSUMER", UVM_LOW)
      pkt.print(uvm_default_line_printer);

`ifndef CAN_PUT
      // Keep trying until transfer succeeds
      do begin
        success = m_put_port.try_put(pkt);
        if (success)
          `uvm_info("PRODUCER",
                    "CONSUMER accepted the packet",
                    UVM_MEDIUM)
        else
          `uvm_info("PRODUCER",
                    "CONSUMER not ready, retrying after 1ns",
                    UVM_MEDIUM)
        #1;
      end while (!success);

`else
      // Wait until receiver is ready
      `uvm_info("PRODUCER",
                "Waiting for consumer to be ready...",
                UVM_MEDIUM)

      do begin
        success = m_put_port.can_put();
      end while (!success);

      `uvm_info("PRODUCER",
                "Consumer is ready, sending packet",
                UVM_MEDIUM)

      m_put_port.try_put(pkt);
`endif

    end

    phase.drop_objection(this);
  endtask
endclass