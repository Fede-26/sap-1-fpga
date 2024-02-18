-- Inspired by the pinout of DM74LS283, 4-bit binary full adder with fast carry

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
    port (
        i_A, i_B : in std_logic_vector(7 downto 0); -- 8-bit input registers
        o_Out : out std_logic_vector(7 downto 0); -- 8-bit output register
        o_Carry : out std_logic; -- Carry output
        i_Subtract : in std_logic -- Subtract flag (if 1, subtract, if 0, add)
    );
end ALU;

architecture rtl of ALU is
    signal w_Carry_Tmp : std_logic_vector(8 downto 0);
    signal w_B: std_logic_vector(7 downto 0);
begin

    w_B <= std_logic_vector(unsigned(not i_B) + 1) when i_Subtract = '1' else i_B; -- Two's complement

    o_Out <= std_logic_vector(unsigned(i_A) + unsigned(w_B));

    -- o_Out <= std_logic_vector(unsigned(i_A) + unsigned(i_B)) when i_Subtract = '0' else std_logic_vector(unsigned(i_A) - unsigned(i_B));

    w_Carry_Tmp <= std_logic_vector(unsigned('0' & i_A) + unsigned('0' & i_B));
    o_Carry <= w_Carry_Tmp(8);
end rtl;