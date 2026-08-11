module eth_axis_rx (
    rx_tuser,
    rx_tdata,
    rx_tkeep,
    clear,
    clock,
    rx_tlast,
    rx_tvalid,
    rx_tstrb,
    hdr_valid,
    hdr_dst_mac,
    hdr_src_mac,
    hdr_ethertype,
    payload_tvalid,
    payload_tdata,
    payload_tkeep,
    payload_tstrb,
    payload_tlast,
    payload_tuser,
    error_short_frame
);

    input rx_tuser;
    input [63:0] rx_tdata;
    input [7:0] rx_tkeep;
    input clear;
    input clock;
    input rx_tlast;
    input rx_tvalid;
    input [7:0] rx_tstrb;
    output hdr_valid;
    output [47:0] hdr_dst_mac;
    output [47:0] hdr_src_mac;
    output [15:0] hdr_ethertype;
    output payload_tvalid;
    output [63:0] payload_tdata;
    output [7:0] payload_tkeep;
    output [7:0] payload_tstrb;
    output payload_tlast;
    output payload_tuser;
    output error_short_frame;

    wire _49;
    wire _42;
    reg _43;
    wire _50;
    reg _64;
    wire _3;
    wire _65;
    wire _66;
    reg _69;
    wire _71;
    wire _70;
    wire _72;
    wire _73;
    wire _74;
    reg _77;
    wire [7:0] _78;
    reg [7:0] _84;
    wire [1:0] _85;
    wire [5:0] _80;
    wire [5:0] _79;
    wire [5:0] _81;
    wire [7:0] _86;
    reg [7:0] _89;
    wire [63:0] _97;
    wire [15:0] _94;
    wire [47:0] _90;
    wire [63:0] _95;
    reg [63:0] _98;
    wire _102;
    wire _56;
    wire _54;
    wire _55;
    wire _57;
    reg _60;
    wire _52;
    wire _53;
    wire _61;
    reg _101;
    wire _103;
    wire [15:0] _108;
    wire [7:0] _105;
    wire [7:0] _104;
    wire [15:0] _106;
    reg [15:0] _110;
    wire [47:0] _119;
    wire [7:0] _116;
    wire [7:0] _115;
    wire [7:0] _114;
    wire [7:0] _113;
    wire [7:0] _112;
    wire [7:0] _111;
    wire [47:0] _117;
    reg [47:0] _120;
    wire [7:0] _126;
    wire [7:0] _125;
    wire [7:0] _124;
    wire [7:0] _123;
    wire [7:0] _122;
    wire [63:0] _13;
    reg [63:0] _93;
    wire [7:0] _121;
    wire [47:0] _127;
    reg [47:0] _130;
    reg _46;
    wire _47;
    wire _48;
    wire _148;
    wire [7:0] _16;
    wire _36;
    wire _37;
    wire _38;
    wire _33;
    wire _39;
    wire _40;
    wire _143;
    wire vdd;
    wire [1:0] _30;
    wire _18;
    wire _20;
    wire _139;
    wire _140;
    wire [1:0] _141;
    wire [1:0] _136;
    wire [1:0] _137;
    wire _22;
    wire _24;
    wire _27;
    wire [1:0] _134;
    wire [1:0] _51;
    wire _133;
    wire [1:0] _135;
    wire _132;
    wire [1:0] _138;
    wire _131;
    wire [1:0] _142;
    wire [1:0] _25;
    reg [1:0] _32;
    wire [1:0] _34;
    wire _35;
    wire _109;
    wire _144;
    reg _147;
    wire _149;
    assign _49 = ~ _48;
    assign _42 = 1'b0;
    always @(posedge _20) begin
        if (_18)
            _43 <= _42;
        else
            _43 <= _40;
    end
    assign _50 = _43 & _49;
    always @(posedge _20) begin
        if (_18)
            _64 <= _42;
        else
            if (_24)
                _64 <= _3;
    end
    assign _3 = rx_tuser;
    assign _65 = _60 ? _64 : _3;
    assign _66 = _61 & _65;
    always @(posedge _20) begin
        if (_18)
            _69 <= _42;
        else
            _69 <= _66;
    end
    assign _71 = ~ _56;
    assign _70 = _53 & _22;
    assign _72 = _70 & _71;
    assign _73 = _60 | _72;
    assign _74 = _61 & _73;
    always @(posedge _20) begin
        if (_18)
            _77 <= _42;
        else
            _77 <= _74;
    end
    assign _78 = 8'b00000000;
    always @(posedge _20) begin
        if (_18)
            _84 <= _78;
        else
            if (_24)
                _84 <= _16;
    end
    assign _85 = _84[7:6];
    assign _80 = 6'b000000;
    assign _79 = _16[5:0];
    assign _81 = _60 ? _80 : _79;
    assign _86 = { _81,
                   _85 };
    always @(posedge _20) begin
        if (_18)
            _89 <= _78;
        else
            if (_61)
                _89 <= _86;
    end
    assign _97 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
    assign _94 = _93[63:48];
    assign _90 = _13[47:0];
    assign _95 = { _90,
                   _94 };
    always @(posedge _20) begin
        if (_18)
            _98 <= _97;
        else
            if (_61)
                _98 <= _95;
    end
    assign _102 = ~ _48;
    assign _56 = _16[6:6];
    assign _54 = _35 | _52;
    assign _55 = _27 & _54;
    assign _57 = _55 & _56;
    always @(posedge _20) begin
        if (_18)
            _60 <= _42;
        else
            _60 <= _57;
    end
    assign _52 = _51 == _32;
    assign _53 = _52 & _24;
    assign _61 = _53 | _60;
    always @(posedge _20) begin
        if (_18)
            _101 <= _42;
        else
            _101 <= _61;
    end
    assign _103 = _101 & _102;
    assign _108 = 16'b0000000000000000;
    assign _105 = _13[47:40];
    assign _104 = _13[39:32];
    assign _106 = { _104,
                    _105 };
    always @(posedge _20) begin
        if (_18)
            _110 <= _108;
        else
            if (_109)
                _110 <= _106;
    end
    assign _119 = 48'b000000000000000000000000000000000000000000000000;
    assign _116 = _13[31:24];
    assign _115 = _13[23:16];
    assign _114 = _13[15:8];
    assign _113 = _13[7:0];
    assign _112 = _93[63:56];
    assign _111 = _93[55:48];
    assign _117 = { _111,
                    _112,
                    _113,
                    _114,
                    _115,
                    _116 };
    always @(posedge _20) begin
        if (_18)
            _120 <= _119;
        else
            if (_109)
                _120 <= _117;
    end
    assign _126 = _93[47:40];
    assign _125 = _93[39:32];
    assign _124 = _93[31:24];
    assign _123 = _93[23:16];
    assign _122 = _93[15:8];
    assign _13 = rx_tdata;
    always @(posedge _20) begin
        if (_18)
            _93 <= _97;
        else
            if (_24)
                _93 <= _13;
    end
    assign _121 = _93[7:0];
    assign _127 = { _121,
                    _122,
                    _123,
                    _124,
                    _125,
                    _126 };
    always @(posedge _20) begin
        if (_18)
            _130 <= _119;
        else
            if (_109)
                _130 <= _127;
    end
    always @(posedge _20) begin
        if (_18)
            _46 <= _42;
        else
            _46 <= vdd;
    end
    assign _47 = ~ _46;
    assign _48 = _18 | _47;
    assign _148 = ~ _48;
    assign _16 = rx_tkeep;
    assign _36 = _16[5:5];
    assign _37 = ~ _36;
    assign _38 = _35 & _37;
    assign _33 = _30 == _32;
    assign _39 = _33 | _38;
    assign _40 = _27 & _39;
    assign _143 = ~ _40;
    assign vdd = 1'b1;
    assign _30 = 2'b00;
    assign _18 = clear;
    assign _20 = clock;
    assign _139 = ~ _22;
    assign _140 = _24 & _139;
    assign _141 = _140 ? _34 : _32;
    assign _136 = _22 ? _30 : _51;
    assign _137 = _24 ? _136 : _32;
    assign _22 = rx_tlast;
    assign _24 = rx_tvalid;
    assign _27 = _24 & _22;
    assign _134 = _27 ? _30 : _32;
    assign _51 = 2'b10;
    assign _133 = _32 == _51;
    assign _135 = _133 ? _134 : _32;
    assign _132 = _32 == _34;
    assign _138 = _132 ? _137 : _135;
    assign _131 = _32 == _30;
    assign _142 = _131 ? _141 : _138;
    assign _25 = _142;
    always @(posedge _20) begin
        if (_18)
            _32 <= _30;
        else
            _32 <= _25;
    end
    assign _34 = 2'b01;
    assign _35 = _34 == _32;
    assign _109 = _35 & _24;
    assign _144 = _109 & _143;
    always @(posedge _20) begin
        if (_18)
            _147 <= _42;
        else
            _147 <= _144;
    end
    assign _149 = _147 & _148;
    assign hdr_valid = _149;
    assign hdr_dst_mac = _130;
    assign hdr_src_mac = _120;
    assign hdr_ethertype = _110;
    assign payload_tvalid = _103;
    assign payload_tdata = _98;
    assign payload_tkeep = _89;
    assign payload_tstrb = _78;
    assign payload_tlast = _77;
    assign payload_tuser = _69;
    assign error_short_frame = _50;

endmodule
