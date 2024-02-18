library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity ALU_TB is
    generic (runner_cfg : string);
end entity;

architecture tb of ALU_TB is

    function num(val : in integer) return std_logic_vector is
    begin
        return std_logic_vector(to_unsigned(val, 8));
    end function num;

    signal w_A, w_B, w_Out : std_logic_vector(7 downto 0);
    signal w_Carry : std_logic;
    signal r_Subtract : std_logic := '0';
begin
    -- Instantiate the UUT
    UUT : entity work.ALU
        port map(
            i_A => w_A,
            i_B => w_B,
            o_Out => w_Out,
            o_Carry => w_Carry,
            i_Subtract => r_Subtract
        );

    main : process
    begin
        test_runner_setup(runner, runner_cfg);

        -- Simulation starts here
        w_A <= num(1);
        w_B <= num(1);
        wait for 10 ns;
        assert w_Out = num(2) report "Error: 1 + 1 != 2" severity failure;
        assert w_Carry = '0' report "Error: carry set" severity failure;

        w_A <= num(3); -- Dec -1
        w_B <= num(5); -- Dec 3
        wait for 10 ns;
        assert w_Out = num(8) report "Error: 3 + 5 != 8" severity failure;
        assert w_Carry = '0' report "Error: carry set" severity failure;

        w_A <= num(255);
        w_B <= num(1);
        wait for 10 ns;
        assert w_Out = num(0) report "Error: 0xFF + 0x01 != 0x00" severity failure;
        assert w_Carry = '1' report "Error: carry not set" severity failure;

        w_A <= num(255);
        w_B <= num(255);
        wait for 10 ns;
        assert w_Out = num(254) report "Error: 0xFF + 0xFF != 0xFE" severity failure;
        assert w_Carry = '1' report "Error: carry not set" severity failure;

        w_A <= "01111111"; -- Dec 127
        w_B <= "00000001"; -- Dec 1
        wait for 10 ns;
        assert w_Out = "10000000" report "Error: 127 + 1 != 128" severity failure;
        assert w_Carry = '0' report "Error: carry set" severity failure;

        -- Subtraction
        r_Subtract <= '1';
        wait for 10 ns;

        w_A <= "00000011";
        w_B <= "00000010";
        wait for 10 ns;
        assert w_Out = "00000001" report "Error: 3 - 2 != 1" severity failure;
        assert w_Carry = '0' report "Error: carry set" severity failure;

        w_A <= "11000000";
        w_B <= "11111110";
        wait for 10 ns;
        assert w_Out = "11000010" report "Error: (-64) - (-2) != (-62)" severity failure;
        assert w_Carry = '1' report "Error: carry set" severity failure;

        wait for 10 ns;

        test_runner_cleanup(runner); -- Simulation ends here
    end process;
end architecture;