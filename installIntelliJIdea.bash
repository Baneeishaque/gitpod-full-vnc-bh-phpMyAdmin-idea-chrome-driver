intellijIdeaInstallationFile=ideaIU.tar.gz
wget --output-document=$intellijIdeaInstallationFile "https://download.jetbrains.com/product?code=IIU&latest&distribution=linux"
sudo tar -xvf $intellijIdeaInstallationFile -C /usr/local/
rm $intellijIdeaInstallationFile
