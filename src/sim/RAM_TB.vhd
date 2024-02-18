library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity RAM_TB is
    generic (runner_cfg : string);
end entity;

architecture tb of RAM_TB is

    signal r_Clk : std_logic := '0';
    signal r_Reg_MAR : std_logic_vector(3 downto 0) := (others => '0');
    signal r_Bus : std_logic_vector(7 downto 0) := (others => '0');
    signal w_RAM_Out : std_logic_vector(7 downto 0);
    signal r_RAM_Write : std_logic := '0';

begin
    -- Instantiate the UUT
    UUT : entity work.RAM
        port map(
            i_Clk => r_Clk,
            i_Addr => r_Reg_MAR,
            i_Data => r_Bus,
            o_Data => w_RAM_Out,
            i_Write => r_RAM_Write
        );

    -- Clock
    -- r_Clk <= not r_Clk after 5 ns;

    main : process
    begin
        test_runner_setup(runner, runner_cfg);
        r_Clk <= '0';
        wait for 10 ns;
        r_Clk <= '1';
        wait for 10 ns;

        -- Simulation starts here

        -- Check all addresses should be 0
        for i in 0 to 15 loop
            r_Reg_MAR <= std_logic_vector(to_unsigned(i, 4));
            r_RAM_Write <= '0';
            wait for 10 ns;
            r_Clk <= '0';
            wait for 10 ns;
            r_Clk <= '1';
            wait for 10 ns;
            assert w_RAM_Out = "00000000" report "RAM output is not 0" severity failure;
        end loop;

        -- Write to RAM
        wait for 10 ns;
        r_RAM_Write <= '1';
        r_Reg_MAR <= "0000";
        r_Bus <= "10101010";
        wait for 10 ns;
        r_Clk <= '0';
        wait for 10 ns;
        r_Clk <= '1';
        wait for 10 ns;
        
        -- Write to another location
        r_RAM_Write <= '1';
        r_Reg_MAR <= "1111";
        r_Bus <= "01010101";
        wait for 10 ns;
        r_Clk <= '0';
        wait for 10 ns;
        r_Clk <= '1';
        wait for 10 ns;

        -- Read from RAM
        r_RAM_Write <= '0';
        r_Reg_MAR <= "0000";
        wait for 10 ns;
        r_Clk <= '0';
        wait for 10 ns;
        r_Clk <= '1';
        wait for 10 ns;
        assert w_RAM_Out = "10101010" report "RAM output is not 10101010" severity failure;

        -- Read from another location
        r_RAM_Write <= '0';
        r_Reg_MAR <= "1111";
        wait for 10 ns;
        r_Clk <= '0';
        wait for 10 ns;
        r_Clk <= '1';
        wait for 10 ns;
        assert w_RAM_Out = "01010101" report "RAM output is not 01010101" severity failure;

        wait for 10 ns;

        test_runner_cleanup(runner); -- Simulation ends here
    end process;
end architecture;