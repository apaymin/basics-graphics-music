`include "config.svh"

module lab_top
# (
    parameter  clk_mhz       = 50,
               w_key         = 4,
               w_sw          = 8,
               w_led         = 8,
               w_digit       = 8,
               w_gpio        = 100,

               screen_width  = 640,
               screen_height = 480,

               w_red         = 4,
               w_green       = 4,
               w_blue        = 4,

               w_x           = $clog2 ( screen_width  ),
               w_y           = $clog2 ( screen_height )
)
(
    input                        clk,
    input                        slow_clk,
    input                        rst,

    // Keys, switches, LEDs

    input        [w_key   - 1:0] key,
    input        [w_sw    - 1:0] sw,
    output logic [w_led   - 1:0] led,

    // A dynamic seven-segment display

    output logic [          7:0] abcdefgh,
    output logic [w_digit - 1:0] digit,

    // Graphics

    input        [w_x     - 1:0] x,
    input        [w_y     - 1:0] y,

    output logic [w_red   - 1:0] red,
    output logic [w_green - 1:0] green,
    output logic [w_blue  - 1:0] blue,

    // Microphone, sound output and UART

    input        [         23:0] mic,
    output       [         15:0] sound,

    input                        uart_rx,
    output                       uart_tx,

    // General-purpose Input/Output

    inout        [w_gpio  - 1:0] gpio
);

    //------------------------------------------------------------------------

    // assign led        = '0;
       assign abcdefgh   = '0;
       assign digit      = '0;
       assign red        = '0;
       assign green      = '0;
       assign blue       = '0;
       assign sound      = '0;
       assign uart_tx    = '1;

    //------------------------------------------------------------------------

    // Exercise 1: Free running counter.
    // How do you change the speed of LED blinking?
    // Try different bit slices to display.

    /* // localparam w_cnt = $clog2 (clk_mhz * 1000 * 1000);
    localparam w_cnt = $clog2 (clk_mhz * 1000);

    logic [w_cnt - 1:0] cnt;

    always_ff @ (posedge clk or posedge rst)
        if (rst)
            cnt <= '0;
        else
            cnt <= cnt + 1'd1;

    assign led = cnt [$left (cnt) -: w_led]; */

    // Exercise 2: Key-controlled counter.
    // Comment out the code above.
    // Uncomment and synthesize the code below.
    // Press the key to see the counter incrementing.
    //
    // Change the design, for example:
    //
    // 1. One key is used to increment, another to decrement.
    //
    // 2. Two counters controlled by different keys
    // displayed in different groups of LEDs.

    

   /*  wire any_key = | key;

    logic any_key_r;

    always_ff @ (posedge clk or posedge rst)
        if (rst)
            any_key_r <= '0;
        else
            any_key_r <= any_key;

    wire any_key_pressed = ~ any_key & any_key_r;

    logic [w_led - 1:0] cnt;

    always_ff @ (posedge clk or posedge rst)
        if (rst)
            cnt <= '0;
        else if (any_key_pressed)
            cnt <= cnt + 1'd1;

    assign led = w_led' (cnt); */


    // Task 2.2

    // wire any_key = | key;
    logic [w_key-1:0] all_keys_r;

    always_ff @ (posedge clk or posedge rst)
        if (rst)
            all_keys_r <= '0;
        else
            all_keys_r <= key;

    // logic [w_key-1:0] keys_pressed = ~ key & all_keys_r;

    wire add_key_0_pressed = ~ key[0] & all_keys_r[0];
    wire sub_key_0_pressed = ~ key[1] & all_keys_r[1];
    wire add_key_1_pressed = ~ key[2] & all_keys_r[2];
    wire sub_key_1_pressed = ~ key[3] & all_keys_r[3];
    

    logic [(w_led - 1) >> 1:0] cnt, cnt1;

    always_ff @ (posedge clk or posedge rst)
        if (rst)
        begin
            cnt <= '0;
            cnt1 <= '0;
        end
        else if (add_key_0_pressed)
            cnt <= cnt + 1'd1;
        else if (sub_key_0_pressed)
            cnt <= cnt - 1'd1;
        else if (add_key_1_pressed)
            cnt1 <= cnt1 + 1'd1;
        else if (sub_key_1_pressed)
            cnt1 <= cnt1 - 1'd1;

    assign led[1:0] = w_led' (cnt);
    assign led[3:2] = w_led' (cnt1);

   

endmodule
