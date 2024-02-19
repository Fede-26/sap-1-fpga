-- This is the top level file for the SAP-1 project

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sap_1_top is
    port (
        i_Ext_Clk : in std_logic
    );
end entity sap_1_top;

architecture rtl of sap_1_top is
    signal w_Clk : std_logic; -- Internal clock signal
    signal r_Clk_En : std_logic; -- Clock enable signal

    -- Registers
    signal r_Reg_A : std_logic_vector(7 downto 0); -- General purpose register A
    signal r_Reg_B : std_logic_vector(7 downto 0); -- General purpose register B
    signal r_Reg_MAR : std_logic_vector(3 downto 0); -- Memory address register (4-bit)

    -- Program counter
    signal r_Program_Counter : std_logic_vector(3 downto 0); -- Program counter (4-bit)
    signal r_Program_Counter_Enable : std_logic; -- Enable signal for the program counter

    -- ALU
    signal w_ALU_Out : std_logic_vector(7 downto 0); -- Output of the ALU

    -- RAM
    signal w_RAM_Out : std_logic_vector(7 downto 0); -- Output of the RAM
    signal w_RAM_Write : std_logic; -- Write signal for the RAM

    -- Bus
    signal w_Bus : std_logic_vector(7 downto 0);
    signal r_Bus_Enable_ALU : std_logic := '0'; -- Enable the bus to be driven by the ALU
    signal r_Bus_Enable_RAM : std_logic := '0'; -- Enable the bus to be driven by the RAM
    signal r_Bus_Enable_PC : std_logic := '0'; -- Enable the bus to be driven by the program counter

    -- Flags
    signal w_Carry : std_logic; -- Carry flag (set if the ALU operation results in a carry)
    signal w_Subtract : std_logic; -- Subtract flag (set if the ALU operation is a subtraction)
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

    -- ALU
    ALU_Inst : entity work.ALU
        port map(
            i_A => r_Reg_A,
            i_B => r_Reg_B,
            o_Out => w_ALU_Out,
            o_Carry => w_Carry,
            i_Subtract => w_Subtract
        );

    -- RAM
    RAM_Inst : entity work.RAM
        port map(
            i_Clk => w_Clk,
            i_Addr => r_Reg_MAR,
            i_Data => w_Bus,
            o_Data => w_RAM_Out,
            i_Write => w_RAM_Write
        );

    -- Bus
    w_Bus <= w_ALU_Out when r_Bus_Enable_ALU = '1' else
        w_RAM_Out when r_Bus_Enable_RAM = '1' else
        ("0000" & r_Program_Counter) when r_Bus_Enable_PC = '1' else
        (others => 'Z');

    -- Program counter
    Process_Counter : process (w_Clk)
    begin
        if rising_edge(w_Clk) then
            if r_Program_Counter_Enable = '1' then
                r_Program_Counter <= std_logic_vector(to_unsigned(to_integer(unsigned( r_Program_Counter )) + 1, 4));
            end if;
        end if;
    end process Process_Counter;

end rtl;