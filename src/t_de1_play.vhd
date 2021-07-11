library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity t_de1_play is
end t_de1_play;

architecture tbench of t_de1_play is

component de1_play is
  port (
    CLOCK_50 : in  std_ulogic;                    -- 50 mhz clock
    KEY      : in  std_ulogic_vector(1 downto 0); -- key(1..0)
    I2C_SCLK    : out   std_ulogic;
    I2C_SDAT    : inout std_logic;
    AUD_ADCLRCK : out   std_ulogic;
    AUD_ADCDAT  : in    std_ulogic;
    AUD_DACLRCK : out   std_ulogic;
    AUD_DACDAT  : out   std_ulogic;
    AUD_XCK     : out   std_ulogic;
    AUD_BCLK    : out   std_ulogic;
    LEDR     : out std_ulogic_vector(4 downto 0); -- red LED(4..0)
    LEDG     : out std_ulogic_vector(1 downto 0)  -- green LED(1..0)
    );
end component;

  -- definition of a clock period
  -- 50 MHz
  constant period : time    := 20 ns;
  -- 1 second timer counts 1 us to enable faster simulation
  constant s1_sim : time    := 1 us;
  -- switch for clock generator
  signal clken_p  : boolean := true;


  signal clk_i    : std_ulogic;
  signal rst_ni   : std_ulogic;
  signal key      : std_ulogic;
  signal ledr : std_ulogic_vector(4 downto 0);

  signal i2c_clk, i2c_dat : std_ulogic;
  signal aud_adclrck, aud_adcdat, aud_daclrck, aud_dacdat, aud_xck, aud_bclk : std_ulogic;
  signal phase               : real := 0.0;
  signal test_tone           : real;
  signal test_tone_quantized : signed(15 downto 0);
  signal bit_count           : integer range 0 to 31;

begin

  -- clock generation
  clock_proc : process
  begin
    while clken_p loop
      clk_i <= '0'; wait for period/2;
      clk_i <= '1'; wait for period/2;
    end loop;
    wait;
  end process;
  
  -- initial reset, always necessary at the beginning of a simulation
  reset : rst_ni <= '0', '1' AFTER period;

  stimuli_p : process
    begin
      key <= '0';     
      wait until rst_ni = '1';      
      --press key 2 times after 2 us
      wait for 2*s1_sim;
      key <= '1';
      wait for period;
      key <= '0';
      wait for period;
      key <= '1';
      wait for period;
      key <= '0';
      wait for 2*s1_sim; 

      --exit winning sequence
      key <= '1'; 
      wait for period;
      key <= '0'; 

      -- end simulation fter 10 us
      wait for 10*s1_sim; 
      clken_p <= false;
      wait;    
  end process stimuli_p;


  de1_play_i0 : de1_play
    port map (
      CLOCK_50  => clk_i,
      KEY(0)    => rst_ni,
      KEY(1)    => key,
      I2C_SCLK    => i2c_clk,
      I2C_SDAT    => i2c_dat,
      AUD_ADCLRCK => aud_adclrck,
      AUD_ADCDAT  => aud_adcdat,
      AUD_DACLRCK => aud_daclrck,
      AUD_DACDAT  => aud_dacdat,
      AUD_XCK     => aud_xck,
      AUD_BCLK    => aud_bclk,
      LEDR      => ledr);

  aud_adcdat <= test_tone_quantized(bit_count mod 16);

  -- Test tone generator for simulating the ADC from the audio codec
  phase               <= phase + 1.0/48.0 when rising_edge(aud_daclrck);
  test_tone           <= sin(2*3.14*phase);
  test_tone_quantized <= to_signed(integer(test_tone * real(2**15-1)), 16);
  bit_count           <= 31 when falling_edge(aud_daclrck) else
                         0 when bit_count = 0 else
                         bit_count - 1 when falling_edge(aud_bclk);

end tbench;
