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
  signal o_Clk_2 : std_logic;
  signal o_Clk_4 : std_logic;
  signal o_Clk_6 : std_logic;
begin
  -- Instantiate the UUT
  UUT_Clock_2 : entity work.Clock_Divider
    generic map(
      DIVIDER => 2
    )
    port map(
      i_Clk => i_Ext_Clk,
      i_Clk_En => i_Clk_En,
      i_Reset => i_Reset,
      o_Clk => o_Clk_2
    );

  UUT_Clock_4 : entity work.Clock_Divider
    generic map(
      DIVIDER => 4
    )
    port map(
      i_Clk => i_Ext_Clk,
      i_Clk_En => i_Clk_En,
      i_Reset => i_Reset,
      o_Clk => o_Clk_4
    );

    UUT_Clock_6 : entity work.Clock_Divider
    generic map(
      DIVIDER => 6
    )
    port map(
      i_Clk => i_Ext_Clk,
      i_Clk_En => i_Clk_En,
      i_Reset => i_Reset,
      o_Clk => o_Clk_6
    );

  main : process
  begin
    test_runner_setup(runner, runner_cfg);

    -- Simulation starts here

    i_Ext_Clk <= '0';
    wait for 10 ns;
    i_Ext_Clk <= '1';
    wait for 10 ns;
    assert o_Clk_2 = '0' report "Clock divider (/2) failed N.1" severity failure;
    assert o_Clk_4 = '0' report "Clock divider (/4) failed N.1" severity failure;
    assert o_Clk_6 = '0' report "Clock divider (/6) failed N.1" severity failure;

    i_Ext_Clk <= '0';
    wait for 10 ns;
    i_Ext_Clk <= '1';
    wait for 10 ns;
    assert o_Clk_2 = '1' report "Clock divider (/2) failed N.2" severity failure;
    assert o_Clk_4 = '0' report "Clock divider (/4) failed N.2" severity failure;
    assert o_Clk_6 = '0' report "Clock divider (/6) failed N.2" severity failure;

    i_Ext_Clk <= '0';
    wait for 10 ns;
    i_Ext_Clk <= '1';
    wait for 10 ns;
    assert o_Clk_2 = '0' report "Clock divider (/2) failed N.3" severity failure;
    assert o_Clk_4 = '1' report "Clock divider (/4) failed N.3" severity failure;
    assert o_Clk_6 = '0' report "Clock divider (/6) failed N.3" severity failure;

    i_Ext_Clk <= '0';
    wait for 10 ns;
    i_Ext_Clk <= '1';
    wait for 10 ns;
    assert o_Clk_2 = '1' report "Clock divider (/2) failed N.4" severity failure;
    assert o_Clk_4 = '1' report "Clock divider (/4) failed N.4" severity failure;
    assert o_Clk_6 = '1' report "Clock divider (/6) failed N.4" severity failure;
    
    i_Ext_Clk <= '0';
    wait for 10 ns;
    i_Ext_Clk <= '1';
    wait for 10 ns;
    assert o_Clk_2 = '0' report "Clock divider (/2) failed N.5" severity failure;
    assert o_Clk_4 = '0' report "Clock divider (/4) failed N.5" severity failure;
    assert o_Clk_6 = '1' report "Clock divider (/6) failed N.5" severity failure;

    i_Ext_Clk <= '0';
    wait for 10 ns;
    i_Ext_Clk <= '1';
    wait for 10 ns;
    assert o_Clk_2 = '1' report "Clock divider (/2) failed N.6" severity failure;
    assert o_Clk_4 = '0' report "Clock divider (/4) failed N.6" severity failure;
    assert o_Clk_6 = '1' report "Clock divider (/6) failed N.6" severity failure;

    i_Ext_Clk <= '0';
    wait for 10 ns;
    i_Ext_Clk <= '1';
    wait for 10 ns;
    assert o_Clk_2 = '0' report "Clock divider (/2) failed N.7" severity failure;
    assert o_Clk_4 = '1' report "Clock divider (/4) failed N.7" severity failure;
    assert o_Clk_6 = '0' report "Clock divider (/6) failed N.7" severity failure;

    i_Ext_Clk <= '0';
    wait for 10 ns;
    i_Ext_Clk <= '1';
    wait for 10 ns;
    assert o_Clk_2 = '1' report "Clock divider (/2) failed N.8" severity failure;
    assert o_Clk_4 = '1' report "Clock divider (/4) failed N.8" severity failure;
    assert o_Clk_6 = '0' report "Clock divider (/6) failed N.8" severity failure;
   

    -- -- Loop for wave generation

    -- for i in 1 to 100 loop
    --   i_Ext_Clk <= '0';
    --   wait for 10 ns;
    --   i_Ext_Clk <= '1';
    --   wait for 10 ns;
    -- end loop;
    test_runner_cleanup(runner); -- Simulation ends here
  end process;
end architecture;