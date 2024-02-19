library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Binary_To_7_Segment_Decoder is
    port (
        i_Clk : in std_logic; -- Clock
        i_Num : in std_logic_vector(15 downto 0); -- 4 Digit hex number
        o_D1, o_D2, o_D3, o_D4 : out std_logic; -- 7 segment display selector
        o_A, o_B, o_C, o_D, o_E, o_F, o_G : out std_logic -- 7 segment display segments
    );
end Binary_To_7_Segment_Decoder;

architecture rtl of Binary_To_7_Segment_Decoder is
    signal w_First_Digit, w_Second_Digit, w_Third_Digit, w_Fourth_Digit : std_logic_vector(3 downto 0);
    signal w_Current_Digit_Content : std_logic_vector(3 downto 0);
    signal r_Current_Viewing_Digit : std_logic_vector(1 downto 0) := "00";
    signal w_Output : std_logic_vector(6 downto 0);
begin

    -- Split the number into 4 digits
    w_First_Digit <= i_Num(15 downto 12);
    w_Second_Digit <= i_Num(11 downto 8);
    w_Third_Digit <= i_Num(7 downto 4);
    w_Fourth_Digit <= i_Num(3 downto 0);

    -- Selects the current digit to display
    w_Current_Digit_Content <= w_First_Digit when r_Current_Viewing_Digit = "00" else
        w_Second_Digit when r_Current_Viewing_Digit = "01" else
        w_Third_Digit when r_Current_Viewing_Digit = "10" else
        w_Fourth_Digit;

    -- Enable the digit to display (active low)
    o_D1 <= '0' when r_Current_Viewing_Digit = "00" else
        '1';
    o_D2 <= '0' when r_Current_Viewing_Digit = "01" else
        '1';
    o_D3 <= '0' when r_Current_Viewing_Digit = "10" else
        '1';
    o_D4 <= '0' when r_Current_Viewing_Digit = "11" else
        '1';

    -- 7 segment display decoder
    w_Output <= "1111110" when w_Current_Digit_Content = "0000" else -- 0x7E
        "0110000" when w_Current_Digit_Content = "0001" else -- 0x30
        "1101101" when w_Current_Digit_Content = "0010" else -- 0x6D
        "1111001" when w_Current_Digit_Content = "0011" else -- 0x79
        "0110011" when w_Current_Digit_Content = "0100" else -- 0x33
        "1011011" when w_Current_Digit_Content = "0101" else -- 0x5B
        "1011111" when w_Current_Digit_Content = "0110" else -- 0x5F
        "1110000" when w_Current_Digit_Content = "0111" else -- 0x70
        "1111111" when w_Current_Digit_Content = "1000" else -- 0x7F
        "1111011" when w_Current_Digit_Content = "1001" else -- 0x7B
        "1110111" when w_Current_Digit_Content = "1010" else -- 0x77
        "0011111" when w_Current_Digit_Content = "1011" else -- 0x1F
        "1001110" when w_Current_Digit_Content = "1100" else -- 0x4E
        "0111101" when w_Current_Digit_Content = "1101" else -- 0x3D
        "1001111" when w_Current_Digit_Content = "1110" else -- 0x4F
        "1000111" when w_Current_Digit_Content = "1111" else -- 0x47
        "0000000";

    -- 7 segment display output
    o_A <= w_Output(6);
    o_B <= w_Output(5);
    o_C <= w_Output(4);
    o_D <= w_Output(3);
    o_E <= w_Output(2);
    o_F <= w_Output(1);
    o_G <= w_Output(0);

    process (i_Clk)
    begin
        if rising_edge(i_Clk) then

            -- Rotate the digit to display
            r_Current_Viewing_Digit <= "01" when r_Current_Viewing_Digit = "00" else
                "10" when r_Current_Viewing_Digit = "01" else
                "11" when r_Current_Viewing_Digit = "10" else
                "00";
        end if;
    end process;

end rtl;