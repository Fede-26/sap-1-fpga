library ieee;
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity Clock_Divider_TB is
  generic (runner_cfg : string);
end entity;

architecture tb of Clock_Divider_TB is
  signal i_Ext_Clk : std_logic := '0';
  signal i_Clk_En : std_logic := '1';
  signal i_Reset : std_logic := '0';
  signal o_Clk : std_logic;
begin
  -- Instantiate the UUT
  UUT : entity work.Clock_Divider
  generic map (
    DIVIDER => 2
  )
  port map (
    i_Clk => i_Ext_Clk,
    i_Clk_En => i_Clk_En,
    i_Reset => i_Reset,
    o_Clk => o_Clk
);


main : process
  begin
    test_runner_setup(runner, runner_cfg);

    -- Simulation starts here
    
    i_Ext_Clk <= '0';
    wait for 10 ns;
    i_Ext_Clk <= '1';
    wait for 10 ns;
    assert o_Clk = '0' report "Clock divider failed 1" severity failure;
    wait for 10 ns;

    i_Ext_Clk <= '0';
    wait for 10 ns;
    i_Ext_Clk <= '1';
    wait for 10 ns;
    assert o_Clk = '0' report "Clock divider failed 2" severity failure;
    wait for 10 ns;

    i_Ext_Clk <= '0';
    wait for 10 ns;
    i_Ext_Clk <= '1';
    wait for 10 ns;
    assert o_Clk = '1' report "Clock divider failed 3" severity failure;
    wait for 10 ns;
    
    i_Ext_Clk <= '0';
    wait for 10 ns;
    i_Ext_Clk <= '1';
    assert o_Clk = '1' report "Clock divider failed 4" severity failure;
    wait for 10 ns;

        
    i_Ext_Clk <= '0';
    wait for 10 ns;
    i_Ext_Clk <= '1';
    wait for 10 ns;
    assert o_Clk = '0' report "Clock divider failed 5" severity failure;
    wait for 10 ns;

    i_Ext_Clk <= '0';
    wait for 10 ns;
    i_Ext_Clk <= '1';
    wait for 10 ns;
    assert o_Clk = '0' report "Clock divider failed 6" severity failure;
    wait for 10 ns;

    test_runner_cleanup(runner); -- Simulation ends here
  end process;
end architecture;