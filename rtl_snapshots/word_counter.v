module word_counter (
    valid,
    clear,
    clock,
    count
);

    input valid;
    input clear;
    input clock;
    output [15:0] count;

    wire _2;
    wire [15:0] _10;
    wire _4;
    wire _6;
    wire [15:0] _12;
    wire [15:0] _13;
    wire [15:0] _7;
    reg [15:0] _11;
    assign _2 = valid;
    assign _10 = 16'b0000000000000000;
    assign _4 = clear;
    assign _6 = clock;
    assign _12 = 16'b0000000000000001;
    assign _13 = _11 + _12;
    assign _7 = _13;
    always @(posedge _6) begin
        if (_4)
            _11 <= _10;
        else
            if (_2)
                _11 <= _7;
    end
    assign count = _11;

endmodule
module word_counter_top (
    valid,
    clear,
    clock,
    count
);

    input valid;
    input clear;
    input clock;
    output [15:0] count;

    wire _2;
    wire _4;
    wire _6;
    wire [15:0] _10;
    wire [15:0] _7;
    assign _2 = valid;
    assign _4 = clear;
    assign _6 = clock;
    word_counter
        word_counter
        ( .clock(_6),
          .clear(_4),
          .valid(_2),
          .count(_10[15:0]) );
    assign _7 = _10;
    assign count = _7;

endmodule
