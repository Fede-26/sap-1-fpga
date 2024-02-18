-- This is the top level file for the SAP-1 project

library ieee;
use ieee.std_logic_1164.all;

entity sap_1_top is
    port (
        i_Ext_Clk : in std_logic
    );
end entity sap_1_top;

architecture rtl of sap_1_top is
    signal w_Clk : std_logic;
    signal r_Clk_En : std_logic;
begin  

    -- Generate the clock signal using a divider
    Clock_Inst : entity work.clock_divider
        generic map(
            DIVIDER => 27_000_000/10 -- 10 Hz clock
        )
        port map(
            i_Clk => i_Ext_Clk,
            i_Clk_En => r_Clk_En,
            o_Clk => w_Clk,
            i_Reset => '0'
        );

end rtl;