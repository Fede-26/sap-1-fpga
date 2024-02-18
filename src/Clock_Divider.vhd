library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity Clock_Divider is
    generic (
        DIVIDER : integer := 27_000_000/10 -- Defaults to 10Hz
    );
    port (
        i_Clk : in std_logic;
        i_Clk_En : in std_logic;
        i_Reset : in std_logic;
        o_Clk : out std_logic
    );
end Clock_Divider;

architecture rtl of Clock_Divider is

    signal r_Counter : integer := 0;
    signal r_Clk : std_logic := '0';

begin

    process (i_Clk, i_Reset)
    begin
        if (i_Reset = '1') then
            r_Counter <= 0;
            r_Clk <= '0';
        elsif (i_Clk'event and i_Clk = '1') then
            r_Counter <= r_Counter + 1;
            if (r_Counter = DIVIDER/2) then
                r_Clk <= not r_Clk;
                r_Counter <= 0;
            end if;
        end if;
        o_Clk <= r_Clk;
    end process;

end rtl;