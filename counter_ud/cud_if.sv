interface cud_if #(parameter WIDTH = 4) (input clk);
	logic rstn;
	logic load_en;
	logic [WIDTH - 1:0] load;
	logic [WIDTH - 1:0] count;
	logic ud;				//ud = 1 : up; ud = 0 : down
	logic rollover;

	modport DUT (
		input clk, rstn, load_en, ud,
		input load,
		output count,
		output rollover
	);

	modport TB (
		input clk, rollover,
		input count,
		output rstn, load_en, ud,
		output load
	);

endinterface
