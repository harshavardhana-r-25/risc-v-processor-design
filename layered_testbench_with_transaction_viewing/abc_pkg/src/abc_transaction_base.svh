class abc_transaction_base extends ncsu_transaction;
  `ncsu_register_object(abc_transaction_base)

       bit [63:0] header, payload [8], trailer;
  rand bit [5:0]  delay;

  function new(string name=""); 
    super.new(name);
  endfunction

  virtual function string convert2string();
     return {super.convert2string(),$sformatf("header:0x%x payload:0x%p trailer:0x%x delay:%d", header, payload, trailer, delay)};
  endfunction

  function bit compare(abc_transaction_base rhs);
    return ((this.header  == rhs.header ) && 
            (this.payload == rhs.payload) &&
            (this.trailer == rhs.trailer) );
  endfunction

  virtual function void add_to_wave(int transaction_viewing_stream_h);
     super.add_to_wave(transaction_viewing_stream_h);
     $add_attribute(transaction_view_h,header,"header");
     $add_attribute(transaction_view_h,payload,"payload");
     $add_attribute(transaction_view_h,trailer,"trailer");
     $add_attribute(transaction_view_h,delay,"delay");
     $end_transaction(transaction_view_h,end_time);
     $free_transaction(transaction_view_h);
  endfunction

endclass
