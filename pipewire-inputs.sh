
# pw-metadata -n settings 0 clock.force-rate <samplerate>
# pw-metadata -n settings 0 clock.force-quantum <buffersize>
alias mic16='pw-metadata -n settings 0 clock.force-rate 1600'
alias buff256='pw-metadata -n settings 0 clock.force-quantum 256'




# Confirm the actuall sample rate and buffer size?
# pw-metadata -n settings
alias pwstatus='pw-metadata -n settings' # | grep....

# Reset pipewire to the default configuration?

# pw-metadata -n settings 0 clock.force-rate 0
# pw-metadata -n settings 0 clock.force-quantum 0

alias pwreset='pw-metadata -n settings 0 clock.force-rate 0 && pw-metadata -n settings 0 clock.force-quantum 0'
