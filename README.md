Lux Vanity Address Generator
-----------------------------

# Build linux:
--------------

    make -j$(nproc)

# Generate vanity address:
--------------------------
note: Lux address start with 'L' so you must set -k Lsomething

CPU:

    ./lux-vanity -C LUX -o address.txt -i -k Lux

GPU:

    ./lux-vanity-gpu -C LUX -o address.txt -i -k Lux -p OpenCL -d 1
