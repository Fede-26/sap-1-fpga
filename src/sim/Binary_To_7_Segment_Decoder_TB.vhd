library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity Binary_To_7_Segment_Decoder_TB is
    generic (runner_cfg : string);
end entity;

architecture tb of Binary_To_7_Segment_Decoder_TB is

    signal r_Clk : std_logic := '0';
    signal r_Num : std_logic_vector(15 downto 0) := (others => '0');
    signal w_D1, w_D2, w_D3, w_D4 : std_logic;
    signal w_A, w_B, w_C, w_D, w_E, w_F, w_G : std_logic;

begin
    -- Instantiate the UUT
    UUT : entity work.Binary_To_7_Segment_Decoder
    port map(
        i_Clk => r_Clk, -- Clock
        i_Num => r_Num, -- 4 Digit hex number
        o_D1 => w_D1, o_D2 => w_D2, o_D3 => w_D3, o_D4 => w_D4, -- 7 segment display selector
        o_A => w_A, o_B => w_B, o_C => w_C, o_D => w_D, o_E => w_E, o_F => w_F, o_G => w_G -- 7 segment display segments
    );

    -- Clock
    -- r_Clk <= not r_Clk after 5 ns;

    main : process
    begin
        test_runner_setup(runner, runner_cfg);
        wait for 10 ns;

        r_Num <= x"F1E8";
        wait for 10 ns;
        
        -- First digit
        assert (w_D1 = '0' and w_D2 = '1' and w_D3 = '1' and w_D4 = '1') report "Error: First digit is not the first" severity failure;
        assert (w_A = '1' and w_B = '0' and w_C = '0' and w_D = '0' and w_E = '1' and w_F = '1' and w_G = '1') report "Error: First digit display wrong segments" severity failure;

        -- Switch to second digit
        r_Clk <= '0';
        wait for 10 ns;
        r_ClK <= '1';
        wait for 10 ns;
        assert (w_D1 = '1' and w_D2 = '0' and w_D3 = '1' and w_D4 = '1') report "Error: Second digit is not the second" severity failure;
        assert (w_A = '0' and w_B = '1' and w_C = '1' and w_D = '0' and w_E = '0' and w_F = '0' and w_G = '0') report "Error: Second digit display wrong segments" severity failure;

        -- Switch to third digit
        r_Clk <= '0';
        wait for 10 ns;
        r_ClK <= '1';
        wait for 10 ns;
        assert (w_D1 = '1' and w_D2 = '1' and w_D3 = '0' and w_D4 = '1') report "Error: Third digit is not the third" severity failure;
        assert (w_A = '1' and w_B = '0' and w_C = '0' and w_D = '1' and w_E = '1' and w_F = '1' and w_G = '1') report "Error: Third digit display wrong segments" severity failure;

        -- Switch to fourth digit
        r_Clk <= '0';
        wait for 10 ns;
        r_ClK <= '1';
        wait for 10 ns;
        assert (w_D1 = '1' and w_D2 = '1' and w_D3 = '1' and w_D4 = '0') report "Error: Fourth digit is not the fourth" severity failure;
        assert (w_A = '1' and w_B = '1' and w_C = '1' and w_D = '1' and w_E = '1' and w_F = '1' and w_G = '1') report "Error: Fourth digit display wrong segments" severity failure;

        -- Return to first digit
        r_Clk <= '0';
        wait for 10 ns;
        r_ClK <= '1';
        wait for 10 ns;
        assert(w_D1 = '0' and w_D2 = '1' and w_D3 = '1' and w_D4 = '1') report "Error: First digit is not the first" severity failure;
        assert(w_A = '1' and w_B = '0' and w_C = '0' and w_D = '0' and w_E = '1' and w_F = '1' and w_G = '1') report "Error: First digit display wrong segments" severity failure;

        -- Switch number without clock
        r_Num <= x"1234";
        wait for 10 ns;
        assert(w_D1 = '0' and w_D2 = '1' and w_D3 = '1' and w_D4 = '1') report "Error: First digit is not the first" severity failure;
        assert(w_A = '0' and w_B = '1' and w_C = '1' and w_D = '0' and w_E = '0' and w_F = '0' and w_G = '0') report "Error: First digit display wrong segments" severity failure;

        wait for 10 ns;

        test_runner_cleanup(runner); -- Simulation ends here
    end process;
end architecture;