module eth_axis_tx (
    payload_tuser,
    hdr_ethertype,
    hdr_src_mac,
    hdr_dst_mac,
    payload_tdata,
    hdr_valid,
    payload_tkeep,
    payload_tlast,
    payload_tvalid,
    clock,
    clear,
    tx_tready,
    payload_tstrb,
    payload_tready,
    tx_tvalid,
    tx_tdata,
    tx_tkeep,
    tx_tstrb,
    tx_tlast,
    tx_tuser
);

    input payload_tuser;
    input [15:0] hdr_ethertype;
    input [47:0] hdr_src_mac;
    input [47:0] hdr_dst_mac;
    input [63:0] payload_tdata;
    input hdr_valid;
    input [7:0] payload_tkeep;
    input payload_tlast;
    input payload_tvalid;
    input clock;
    input clear;
    input tx_tready;
    input [7:0] payload_tstrb;
    output payload_tready;
    output tx_tvalid;
    output [63:0] tx_tdata;
    output [7:0] tx_tkeep;
    output [7:0] tx_tstrb;
    output tx_tlast;
    output tx_tuser;

    wire _85;
    wire _2;
    reg _80;
    wire _81;
    wire _83;
    reg _86;
    wire [7:0] _87;
    wire [7:0] _96;
    wire [7:0] _90;
    reg [7:0] _93;
    wire [5:0] _94;
    wire [1:0] _88;
    wire [7:0] _95;
    wire [7:0] _97;
    reg [7:0] _100;
    wire [63:0] _145;
    wire [7:0] _141;
    wire [7:0] _140;
    wire [7:0] _139;
    wire [7:0] _138;
    wire [7:0] _137;
    wire [7:0] _136;
    wire [7:0] _135;
    wire [7:0] _134;
    wire [63:0] _142;
    wire [15:0] _126;
    wire [7:0] _124;
    wire [7:0] _123;
    wire [7:0] _122;
    wire [7:0] _121;
    wire [7:0] _120;
    wire [15:0] _8;
    wire [47:0] _10;
    wire [63:0] _105;
    wire [47:0] _12;
    wire [111:0] _106;
    wire [103:0] _107;
    wire [95:0] _108;
    wire [87:0] _109;
    wire [79:0] _110;
    wire [71:0] _111;
    wire [63:0] _112;
    wire [55:0] _113;
    wire [47:0] _114;
    wire [39:0] _115;
    wire [31:0] _116;
    wire [23:0] _117;
    wire [15:0] _118;
    wire [7:0] _119;
    wire [47:0] _125;
    wire [63:0] _127;
    wire [63:0] _128;
    reg [63:0] _131;
    wire [47:0] _132;
    wire [63:0] _14;
    reg [63:0] _103;
    wire [15:0] _104;
    wire [63:0] _133;
    wire [63:0] _143;
    reg [63:0] _146;
    wire _147;
    wire _148;
    wire _56;
    wire _54;
    wire _55;
    wire _57;
    wire _18;
    wire _166;
    wire gnd;
    wire [5:0] _75;
    wire [7:0] _20;
    wire [7:0] _62;
    reg [7:0] _73;
    wire [5:0] _74;
    wire _76;
    wire _22;
    wire _149;
    reg _152;
    wire _23;
    wire _77;
    wire _153;
    reg _156;
    wire _24;
    wire _69;
    wire _70;
    wire _66;
    wire _67;
    wire _68;
    wire _71;
    wire _26;
    wire _60;
    wire _65;
    wire _72;
    wire _157;
    reg _160;
    wire _27;
    wire _51;
    wire _52;
    wire _53;
    wire _163;
    wire _164;
    wire _50;
    wire _162;
    wire _165;
    wire _161;
    wire _167;
    wire _28;
    reg _40;
    wire _41;
    wire _49;
    wire _58;
    wire _30;
    wire vdd;
    reg _44;
    wire _45;
    wire _32;
    wire _46;
    wire _47;
    wire _34;
    wire _48;
    wire _59;
    assign _85 = 1'b0;
    assign _2 = payload_tuser;
    always @(posedge _30) begin
        if (_32)
            _80 <= _85;
        else
            if (_60)
                _80 <= _2;
    end
    assign _81 = _77 & _80;
    assign _83 = _41 ? gnd : _81;
    always @(posedge _30) begin
        if (_32)
            _86 <= _85;
        else
            if (_72)
                _86 <= _83;
    end
    assign _87 = 8'b00000000;
    assign _96 = 8'b11111111;
    assign _90 = _41 ? _96 : _73;
    always @(posedge _30) begin
        if (_32)
            _93 <= _87;
        else
            if (_72)
                _93 <= _90;
    end
    assign _94 = _93[7:2];
    assign _88 = _73[1:0];
    assign _95 = { _88,
                   _94 };
    assign _97 = _41 ? _96 : _95;
    always @(posedge _30) begin
        if (_32)
            _100 <= _87;
        else
            if (_72)
                _100 <= _97;
    end
    assign _145 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
    assign _141 = _106[111:104];
    assign _140 = _107[103:96];
    assign _139 = _108[95:88];
    assign _138 = _109[87:80];
    assign _137 = _110[79:72];
    assign _136 = _111[71:64];
    assign _135 = _112[63:56];
    assign _134 = _113[55:48];
    assign _142 = { _134,
                    _135,
                    _136,
                    _137,
                    _138,
                    _139,
                    _140,
                    _141 };
    assign _126 = 16'b0000000000000000;
    assign _124 = _114[47:40];
    assign _123 = _115[39:32];
    assign _122 = _116[31:24];
    assign _121 = _117[23:16];
    assign _120 = _118[15:8];
    assign _8 = hdr_ethertype;
    assign _10 = hdr_src_mac;
    assign _105 = { _10,
                    _8 };
    assign _12 = hdr_dst_mac;
    assign _106 = { _12,
                    _105 };
    assign _107 = _106[103:0];
    assign _108 = _107[95:0];
    assign _109 = _108[87:0];
    assign _110 = _109[79:0];
    assign _111 = _110[71:0];
    assign _112 = _111[63:0];
    assign _113 = _112[55:0];
    assign _114 = _113[47:0];
    assign _115 = _114[39:0];
    assign _116 = _115[31:0];
    assign _117 = _116[23:0];
    assign _118 = _117[15:0];
    assign _119 = _118[7:0];
    assign _125 = { _119,
                    _120,
                    _121,
                    _122,
                    _123,
                    _124 };
    assign _127 = { _125,
                    _126 };
    assign _128 = _41 ? _127 : _103;
    always @(posedge _30) begin
        if (_32)
            _131 <= _145;
        else
            if (_72)
                _131 <= _128;
    end
    assign _132 = _131[63:16];
    assign _14 = payload_tdata;
    always @(posedge _30) begin
        if (_32)
            _103 <= _145;
        else
            if (_60)
                _103 <= _14;
    end
    assign _104 = _103[15:0];
    assign _133 = { _104,
                    _132 };
    assign _143 = _41 ? _142 : _133;
    always @(posedge _30) begin
        if (_32)
            _146 <= _145;
        else
            if (_72)
                _146 <= _143;
    end
    assign _147 = ~ _46;
    assign _148 = _27 & _147;
    assign _56 = ~ _23;
    assign _54 = ~ _53;
    assign _55 = _51 & _54;
    assign _57 = _55 & _56;
    assign _18 = hdr_valid;
    assign _166 = _60 ? _50 : _40;
    assign gnd = 1'b0;
    assign _75 = 6'b000000;
    assign _20 = payload_tkeep;
    assign _62 = _60 ? _20 : _87;
    always @(posedge _30) begin
        if (_32)
            _73 <= _87;
        else
            if (_72)
                _73 <= _62;
    end
    assign _74 = _73[7:2];
    assign _76 = _74 == _75;
    assign _22 = payload_tlast;
    assign _149 = _60 ? _22 : vdd;
    always @(posedge _30) begin
        if (_32)
            _152 <= _85;
        else
            if (_72)
                _152 <= _149;
    end
    assign _23 = _152;
    assign _77 = _23 & _76;
    assign _153 = _41 ? gnd : _77;
    always @(posedge _30) begin
        if (_32)
            _156 <= _85;
        else
            if (_72)
                _156 <= _153;
    end
    assign _24 = _156;
    assign _69 = ~ _58;
    assign _70 = _69 | _26;
    assign _66 = ~ _53;
    assign _67 = _51 & _66;
    assign _68 = _67 & _48;
    assign _71 = _68 & _70;
    assign _26 = payload_tvalid;
    assign _60 = _59 & _26;
    assign _65 = _41 & _60;
    assign _72 = _65 | _71;
    assign _157 = _48 ? _72 : _27;
    always @(posedge _30) begin
        if (_32)
            _160 <= _85;
        else
            _160 <= _157;
    end
    assign _27 = _160;
    assign _51 = _50 == _40;
    assign _52 = _51 & _27;
    assign _53 = _52 & _24;
    assign _163 = _53 & _48;
    assign _164 = _163 ? _85 : _40;
    assign _50 = 1'b1;
    assign _162 = _40 == _50;
    assign _165 = _162 ? _164 : _40;
    assign _161 = _40 == _85;
    assign _167 = _161 ? _166 : _165;
    assign _28 = _167;
    always @(posedge _30) begin
        if (_32)
            _40 <= _85;
        else
            _40 <= _28;
    end
    assign _41 = _85 == _40;
    assign _49 = _41 & _18;
    assign _58 = _49 | _57;
    assign _30 = clock;
    assign vdd = 1'b1;
    always @(posedge _30) begin
        if (_32)
            _44 <= _85;
        else
            _44 <= vdd;
    end
    assign _45 = ~ _44;
    assign _32 = clear;
    assign _46 = _32 | _45;
    assign _47 = ~ _46;
    assign _34 = tx_tready;
    assign _48 = _34 & _47;
    assign _59 = _48 & _58;
    assign payload_tready = _59;
    assign tx_tvalid = _148;
    assign tx_tdata = _146;
    assign tx_tkeep = _100;
    assign tx_tstrb = _87;
    assign tx_tlast = _24;
    assign tx_tuser = _86;

endmodule
