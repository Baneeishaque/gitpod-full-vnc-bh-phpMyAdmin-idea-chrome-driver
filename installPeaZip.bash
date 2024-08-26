peaZipInstallationFile=PeaZip.deb
wget --output-document=$peaZipInstallationFile $(curl -s https://api.github.com/repos/peazip/peaZip/releases/latest | sed 's/[()",{}]/ /g; s/ /\n/g' | grep "https.*releases/download.*GTK.*deb")
./updatePackageIndex.bash
sudo apt install -y ./$peaZipInstallationFile
rm $peaZipInstallationFile
