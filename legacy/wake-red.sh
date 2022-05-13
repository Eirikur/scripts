#!/bin/bash
echo "Waking red..."
ssh eh@red.local & sleep 2
scp ~/Customization/touch eh@red.local:/media/Upper
scp ~/Customization/touch eh@red.local:/media/Lower
echo "Done."
