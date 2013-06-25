git clean -f -x -d -e doit.sh
export CROSS_COMPILE=arm-none-eabi-

#
# Remove the build *after* the clea and before
# we start building (e.g. the build directory
# is regenerated.
#
rm -rf build

for i in am335x_evm omap3_beagle
do
(
	make ${i}_config
	make
	sha1sum u-boot.img u-boot MLO spl/u-boot-spl.bin  > u-boot.sha1
	mkdir -p build/$i/spl
	cp MLO build/$i/
	cp u-boot build/$i/
	cp u-boot.img build/$i/
	cp spl/u-boot-spl.bin build/$i/spl/
	cp u-boot.sha1 build/$i/
	git clean -f -x -d -e doit.sh -e build
)
done
git clean -f -x -d -e doit.sh -e build
