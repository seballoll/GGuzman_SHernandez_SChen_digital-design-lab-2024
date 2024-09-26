module spiMaster (
    input wire clk,           // System clock
    input wire rst_n,         // Active-low reset
    input wire data_in,       // Single bit to send
    output reg mosi,          // Master Output, Slave Input (connect to Arduino's MOSI)
    input wire miso,          // Master Input, Slave Output (optional for this case)
    output reg sclk,          // SPI Clock (connect to Arduino's SCK)
    output reg ss,            // Slave Select (active-low) (connect to Arduino's SS)
    input wire start,         // Start signal (active low)
    output reg done           // Done signal
);

    reg spi_active;           // SPI active flag
    reg sclk_toggle;          // Clock toggling control

    // SPI clock generation (simple clock divider)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sclk_toggle <= 0;
            sclk <= 0;
        end else if (spi_active) begin
            sclk_toggle <= ~sclk_toggle; // Toggle clock on every positive edge of clk
            if (sclk_toggle) begin
                sclk <= ~sclk; // Toggle SPI clock (SCLK)
            end
        end else begin
            sclk <= 0;
        end
    end

    // Main SPI process
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ss <= 1;        // Slave deselected (active-high)
            mosi <= 0;
            done <= 0;
            spi_active <= 0;
        end else begin
            if (!start && !spi_active) begin
                // Start transmission when start is low
                ss <= 0;              // Select slave (active-low)
                mosi <= data_in;      // Send 1 bit of data
                spi_active <= 1;      // Set SPI active flag
                done <= 0;
            end

            if (spi_active) begin
                if (sclk == 0 && sclk_toggle) begin
                    // Falling edge of SCLK
                    ss <= 1;          // Deselect slave (end transmission)
                    spi_active <= 0;  // Reset SPI active flag
                    done <= 1;        // Indicate transmission done
                end
            end
        end
    end
endmodule
