class driver extends uvm_driver#(seq_item);
  virtual add_if vif;
  `uvm_component_utils(driver)
  
  function new(string name = "driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Examples about getting vif from the uvm_config_db
    /* Example 1:  Empty Path ("")
       - This is the most common and recommended way inside a component:
       - The empty string means "look for configuration set for this component's full instance path".*/
    //if(!uvm_config_db#(virtual add_if) :: get(this, "", "vif", vif))
    // `uvm_fatal(get_type_name(), "Not set at top level");
    
    /*Example 2: Explicit Hierarchical Path
	  - You can specify the full hierarchical path to the component:
      - Useful if you want to override or check a specific location.*/
    //if (!uvm_config_db#(virtual add_if)::get(this, "uvm_test_top.env.agt.drv", "vif", vif))
    //  `uvm_fatal(get_type_name(), "Not set at specified path");
    
    /*Example 3: Relative Path
      - You can use a relative path from the current component:
      - This is less common, but possible if you know your hierarchy.*/
    //if (!uvm_config_db#(virtual add_if)::get(this, "drv", "vif", vif))
    // `uvm_fatal(get_type_name(), "Not set at relative path");
    
    /*Example 4: Wildcard Path
	  - You can use wildcards to match multiple components (less common for get, more for set):
      - Usually, get with wildcards is not recommended; use in set instead.*/
    //if (!uvm_config_db#(virtual add_if)::get(this, "*", "vif", vif))
    //  `uvm_fatal(get_type_name(), "Not set with wildcard path");
	
    /*Example 5: Parent Component as Context
      - You can use a parent component as the context instead of this:
      - Useful if you want to inherit configuration from a parent.*/
    if (!uvm_config_db#(virtual add_if)::get(get_parent(), "", "vif", vif))
      `uvm_fatal(get_type_name(), "Not set at parent level");


  endfunction
  
  task run_phase (uvm_phase phase);
    forever begin
      // Driver to the DUT
      seq_item_port.get_next_item(req);
      `uvm_info(get_type_name, $sformatf("a = %0d, b = %0d", req.a, req.b), UVM_LOW);
      vif.a <= req.a;
      vif.b <= req.b;
      seq_item_port.item_done();
    end
  endtask
endclass