library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM is
    port (
        i_Clk : in std_logic;
        i_Addr : in std_logic_vector(3 downto 0);
        i_Data : in std_logic_vector(7 downto 0);
        i_Write : in std_logic;
        o_Data : out std_logic_vector(7 downto 0)
    );
end entity RAM;

architecture rtl of RAM is
    type ram_type is array(0 to 15) of std_logic_vector(7 downto 0);
    signal r_RAM : ram_type := (others => (others => '0'));
begin
    process (i_Clk)
    begin
        if rising_edge(i_Clk) then
            if i_Write = '1' then
                r_RAM(to_integer(unsigned(i_Addr))) <= i_Data;
            end if;
            o_Data <= r_RAM(to_integer(unsigned(i_Addr)));
        end if;
    end process;
end rtl;