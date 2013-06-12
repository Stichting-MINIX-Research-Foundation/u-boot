git clean -f -x -d -e doit.sh
export CROSS_COMPILE=arm-none-eabi-

for i in am335x_evm omap3_beagle
do
(
	make ${i}_config
	make
	sha1sum u-boot MLO spl/u-boot-spl.bin  > u-boot.sha1
	mkdir -p build/$i/spl
	cp MLO build/$i/
	cp u-boot build/$i/
	cp spl/u-boot-spl.bin build/$i/spl/
	cp u-boot.sha1 build/$i/
	git clean -f -x -d -e doit.sh -e build
)
done
git clean -f -x -d -e doit.sh -e build
