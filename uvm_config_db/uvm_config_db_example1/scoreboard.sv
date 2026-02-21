class scoreboard extends uvm_scoreboard;
  uvm_analysis_imp #(seq_item, scoreboard) item_collect_export;
  seq_item item_q[$];
  `uvm_component_utils(scoreboard)
  
  function new(string name = "scoreboard", uvm_component parent = null);
    super.new(name, parent);
    item_collect_export = new("item_collect_export", this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  function void write(seq_item req);
    item_q.push_back(req);
  endfunction
  
  task run_phase (uvm_phase phase);
    seq_item sb_item;
    forever begin
      wait(item_q.size > 0);
      
      if(item_q.size > 0) begin
        sb_item = item_q.pop_front();
        $display("----------------------------------------------------------------------------------------------------------");
        if(sb_item.a + sb_item.b == sb_item.y) begin
          `uvm_info(get_type_name, $sformatf("Matched: a = %0d, b = %0d, y = %0d", sb_item.a, sb_item.b, sb_item.y),UVM_LOW);
        end
        else begin
          `uvm_error(get_name, $sformatf("NOT matched: a = %0d, b = %0d, y = %0d", sb_item.a, sb_item.b, sb_item.y));
        end
        $display("----------------------------------------------------------------------------------------------------------");
      end
    end
  endtask
  
endclass