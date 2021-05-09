library ieee;
use ieee.std_logic_1164.all;

library altera;
use altera.altera_primitives_components.all;

entity de1_play is
  port (
    CLOCK_50    : in    std_ulogic;                     -- 50 mhz clock
    KEY         : in    std_ulogic_vector(1 downto 0);
    I2C_SCLK    : out   std_ulogic;
    I2C_SDAT    : inout std_logic;
    AUD_ADCLRCK : out   std_ulogic;
    AUD_ADCDAT  : in    std_ulogic;
    AUD_DACLRCK : out   std_ulogic;
    AUD_DACDAT  : out   std_ulogic;
    AUD_XCK     : out   std_ulogic;
    AUD_BCLK    : out   std_ulogic;
    LEDR        : out   std_ulogic_vector(4 downto 0);  -- red LED(4..0)
    LEDG        : out   std_ulogic_vector(1 downto 0)   -- green LED(1..0)
    );
end de1_play;

architecture structure of de1_play is

  component audio is
    port (
      clk_i         : in  std_ulogic;
      reset_ni      : in  std_ulogic;
      i2c_sclk_o    : out std_ulogic;
      i2c_dat_i     : in  std_ulogic;
      i2c_dat_o     : out std_ulogic;
      aud_adclrck_o : out std_ulogic;
      aud_adcdat_i  : in  std_ulogic;
      aud_daclrck_o : out std_ulogic;
      aud_dacdat_o  : out std_ulogic;
      aud_xck_o     : out std_ulogic;
      aud_bclk_o    : out std_ulogic;
      adc_data_o    : out std_ulogic_vector(15 downto 0);
      adc_valid_o   : out std_ulogic;
      dac_data_i    : in  std_ulogic_vector(15 downto 0);
      dac_strobe_o  : out std_ulogic);
  end component;

  component tone is
    port (clk        : in  std_ulogic;
          rst_n      : in  std_ulogic;
          switches_i : in  std_ulogic_vector(9 downto 0);
          dv_i       : in  std_ulogic;
          audio_i    : in  std_ulogic_vector(15 downto 0);
          audio_o    : out std_ulogic_vector(15 downto 0));
  end component;

  component count1s
    port (
      clk         : in  std_ulogic;
      rst_n       : in  std_ulogic;
      onesec_o    : out std_ulogic);
  end component;

  component falling_edge_detector
    port (
      clk_i    : in  std_ulogic;
      rst_ni   : in  std_ulogic;
      x_i      : in  std_ulogic;
      fall_o   : out std_ulogic);
  end component;

  component play is
  port (clk        : in  std_ulogic;
        rst_n      : in  std_ulogic;
        onesec_i   : in  std_ulogic;
        key_i      : in  std_ulogic;
        led_o      : out std_ulogic_vector(4 downto 0));
  end component;

  signal clk      : std_ulogic;
  signal rst_n    : std_ulogic;
  signal key_inv  : std_ulogic;
  signal key_edge : std_ulogic;

  signal one_second_period : std_ulogic;

  signal i2c_dat_o : std_ulogic;
  signal i2c_dat_i : std_ulogic;

  signal adc_valid          : std_ulogic;
  signal dac_data, adc_data : std_ulogic_vector(15 downto 0);

begin

  -- connecting clock generator master clock of synchronous system
  clk <= CLOCK_50;

  -- connecting asynchronous system reset to digital system
  rst_n <= KEY(0);

  LEDG <= KEY;                      -- pushbutton on green LED
  
  -- falling edge detection for KEY1 
  falling_edge_detect_i0 : falling_edge_detector
    port map (
      clk_i    => clk,
      rst_ni   => rst_n,
      x_i      => KEY(1),
      fall_o   => key_edge);

  -- based on the 50 mhz clock, generates an enable signal of period t = 1 sec
  count1s_i0 : count1s
    port map (
      clk         => clk,
      rst_n       => rst_n,               
      onesec_o    => one_second_period);

  play_i0 : play
    port map (
      clk      => clk,
      rst_n    => rst_n,
      onesec_i => one_second_period,
      key_i    => key_edge,
      led_o    => LEDR);

  audio_i0 : audio
    port map (
      clk_i         => clk,
      reset_ni      => rst_n,
      i2c_sclk_o    => I2C_SCLK,
      i2c_dat_i     => i2c_dat_i,
      i2c_dat_o     => i2c_dat_o,
      aud_adclrck_o => AUD_ADCLRCK,
      aud_adcdat_i  => AUD_ADCDAT,
      aud_daclrck_o => AUD_DACLRCK,
      aud_dacdat_o  => AUD_DACDAT,
      aud_xck_o     => AUD_XCK,
      aud_bclk_o    => AUD_BCLK,
      adc_data_o    => adc_data,
      adc_valid_o   => adc_valid,
      dac_data_i    => dac_data,
      dac_strobe_o  => open);
  
  tone_i0 : tone
    port map (
      clk        => clk,
      rst_n      => rst_n,
      dv_i       => adc_valid,
      audio_i    => adc_data,
      audio_o    => dac_data,
      switches_i => "0000000000");

    -- i2c has an open-drain ouput
  i2c_dat_i <= I2C_SDAT;
  i2c_data_buffer_i : OPNDRN
    port map (a_in => i2c_dat_o, a_out => I2C_SDAT);
  
end structure;
