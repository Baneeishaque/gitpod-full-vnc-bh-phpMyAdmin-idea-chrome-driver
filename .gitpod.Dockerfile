FROM gitpod/workspace-full-vnc

RUN echo "demo content to trigger rebuild due to the change in Dockerfile"

RUN sudo rm -rf /etc/localtime && sudo ln -s /usr/share/zoneinfo/Asia/Kolkata /etc/localtime

# RUN intellijIdeaInstallationFile=ideaIU.tar.gz \
#  && wget --output-document=$intellijIdeaInstallationFile "https://download.jetbrains.com/product?code=IIU&latest&distribution=linux" \
#  && sudo tar -xvf $intellijIdeaInstallationFile -C /usr/local/ \
#  && rm $intellijIdeaInstallationFile

# ARG keyExplorerDownloadUrl="https://github.com/kaikramer/keystore-explorer/releases/download/v5.5.1/kse_5.5.1_all.deb"
ARG dBeaverDownloadPageUrl="https://dbeaver.com/files/ea/ultimate"
ARG gitKrakenDownloadUrl="https://release.gitkraken.com/linux/gitkraken-amd64.deb"
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
 && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
#  && wget ${keyExplorerDownloadUrl} \
#  && keyExplorerInstallationFile=$(basename ${keyExplorerDownloadUrl}) \
# && visualStudioCodeInstallationFile=visualStudioCode.deb \
# && wget --output-document=$visualStudioCodeInstallationFile "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" \
 && visualStudioCodeInsidersInstallationFile=visualStudioCodeInsiders.deb \
 && wget --output-document=$visualStudioCodeInsidersInstallationFile "https://code.visualstudio.com/sha/download?build=insider&os=linux-deb-x64" \
 && brew install pup \
 && dBeaverDownloadUrl=$(echo ${dBeaverDownloadPageUrl}/$(wget -O - ${dBeaverDownloadPageUrl} | pup 'table.s3_listing_files tbody tr td a attr{href}' | grep '.deb')) \
 && wget $dBeaverDownloadUrl \
 && dBeaverInstallationFile=$(basename $dBeaverDownloadUrl) \
 && wget ${gitKrakenDownloadUrl} \
 && gitKrakenInstallationFile=$(basename ${gitKrakenDownloadUrl}) \
 && sudo add-apt-repository -y ppa:persepolis/ppa \
 && wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add - \
 && sudo add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" \
 && curl https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - \
 && echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list > /dev/null \
 && curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg \
 && VERSION_ID=$(sudo grep -oP 'VERSION_ID="\K[^"]+' /etc/os-release) \
 && wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb \
 && peaZipInstallationFile=PeaZip.deb \
 && wget --output-document=$peaZipInstallationFile $(curl -s https://api.github.com/repos/peazip/peaZip/releases/latest | sed 's/[()",{}]/ /g; s/ /\n/g' | grep "https.*releases/download.*GTK.*deb") \
 && sudo apt update \
 && sudo apt install -y \
     libxtst6 aria2 gh \
    #  ./$keyExplorerInstallationFile \
     tree ./$visualStudioCodeInsidersInstallationFile rclone-browser ./$dBeaverInstallationFile firefox qbittorrent persepolis ./$gitKrakenInstallationFile p7zip-full software-properties-common apt-transport-https wget \
    #  microsoft-edge-dev \
     squid postgresql-16 dotnet-sdk-7.0 ./packages-microsoft-prod.deb ./$peaZipInstallationFile \
 && sudo apt update \
 && sudo apt install -y \
     powershell \
 && sudo rm -rf /var/lib/apt/lists/* \
#  && rm $keyExplorerInstallationFile \
#  && rm $visualStudioCodeInstallationFile \
 && rm $visualStudioCodeInsidersInstallationFile \
 && rm $dBeaverInstallationFile \
 && rm $gitKrakenInstallationFile \
 && rm $peaZipInstallationFile \
 && phpMyAdminDownloadUrl=$(wget -O - https://www.phpmyadmin.net/downloads | pup 'a.download_popup attr{href}' | grep --max-count=1 'english.zip') \
 && wget $phpMyAdminDownloadUrl \
 && phpMyAdminArchieveFile=$(basename $phpMyAdminDownloadUrl) \
 && sudo unzip $phpMyAdminArchieveFile -d /opt/ \
 && rm $phpMyAdminArchieveFile \
 && phpMyAdminFolder=$(echo $phpMyAdminArchieveFile | sed 's/\(.*\)\..*/\1/') \
 && sudo mv /opt/$phpMyAdminFolder /opt/phpMyAdmin-english \
 && sudo cp /opt/phpMyAdmin-english/config.sample.inc.php /opt/phpMyAdmin-english/config.inc.php \
 && printf "\n\$cfg['AllowArbitraryServer'] = true;" | sudo tee -a /opt/phpMyAdmin-english/config.inc.php >/dev/null

# ARG chromeDriverDownloadUrl=https://chromedriver.storage.googleapis.com/111.0.5563.64/chromedriver_linux64.zip
# RUN wget ${chromeDriverDownloadUrl} \
#  && chromeDriverArchieve=$(basename ${chromeDriverDownloadUrl}) \
#  && unzip $chromeDriverArchieve \
#  && rm $chromeDriverArchieve \
#  && chromeDriverExecutable=chromedriver \
#  && sudo mv $chromeDriverExecutable /usr/bin/ \
#  && sudo chmod a+x /usr/bin/$chromeDriverExecutable

RUN curl https://rclone.org/install.sh | sudo bash -s beta

# ARG androidCommandLineToolsLinuxDownloadUrl="https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip"
# RUN cd /workspace \
#  && wget ${androidCommandLineToolsLinuxDownloadUrl} \
#  && androidCommandLineToolsArchieve=$(basename ${androidCommandLineToolsLinuxDownloadUrl}) \
#  && unzip $androidCommandLineToolsArchieve \
#  && mkdir -p Android/Sdk/cmdline-tools/latest \
#  && mv cmdline-tools/* Android/Sdk/cmdline-tools/latest/ \
#  && rmdir cmdline-tools/ \
#  && rm $androidCommandLineToolsArchieve

# ARG androidPlatformVersion="android-33"
# ARG androidBuildToolsVersion="33.0.0"
# ARG androidSourcesPlatformVersion="android-33-ext3"
# # ARG cmakeVersion="3.22.1"
# # ARG ndkVersion="25.1.8937393"
# RUN yes | /workspace/Android/Sdk/cmdline-tools/latest/bin/sdkmanager --licenses \
#  && /workspace/Android/Sdk/cmdline-tools/latest/bin/sdkmanager "platforms;${androidPlatformVersion}" "build-tools;${androidBuildToolsVersion}" "sources;${androidPlatformVersion}"
# # RUN yes | Android/Sdk/cmdline-tools/latest/bin/sdkmanager --licenses \
# #  && Android/Sdk/cmdline-tools/latest/bin/sdkmanager "platforms;${androidPlatformVersion}" "build-tools;${androidBuildToolsVersion}" "sources;${androidPlatformVersion}" "cmake;${cmakeVersion}" "ndk;${ndkVersion}"

ENV ANDROID_HOME="/workspace/Android/Sdk"

ENV PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH

# ARG eclipseDownloadUrl="https://ftp.yz.yamagata-u.ac.jp/pub/eclipse/technology/epp/downloads/release/2022-09/R/eclipse-java-2022-09-R-linux-gtk-x86_64.tar.gz"
# RUN wget ${eclipseDownloadUrl} \
#  && eclipseInstallationFile=$(basename ${eclipseDownloadUrl}) \
#  && sudo tar -xvf $eclipseInstallationFile --directory=/usr/local/  --no-same-owner \
#  && rm $eclipseInstallationFile

ENV KONAN_DATA_DIR=/workspace/.konan/

# ARG androidStudioCanaryDownloadUrl="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2022.2.1.6/android-studio-2022.2.1.6-linux.tar.gz"
# RUN cd $HOME \
#  && wget ${androidStudioCanaryDownloadUrl} \
#  && androidStudioCanaryInstallationFile=$(basename ${androidStudioCanaryDownloadUrl}) \
#  && sudo tar -xvf $androidStudioCanaryInstallationFile -C /usr/local/ \
#  && sudo mv /usr/local/android-studio/ /usr/local/android-studio-canary/ \
#  && rm $androidStudioCanaryInstallationFile

# ARG androidStudioBetaDownloadUrl="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2021.3.1.15/android-studio-2021.3.1.15-linux.tar.gz"
# RUN cd $HOME \
#  && wget ${androidStudioBetaDownloadUrl} \
#  && androidStudioBetaInstallationFile=$(basename ${androidStudioBetaDownloadUrl}) \
#  && sudo tar -xvf $androidStudioBetaInstallationFile -C /usr/local/ \
#  && sudo mv /usr/local/android-studio/ /usr/local/android-studio-beta/ \
#  && rm $androidStudioBetaInstallationFile

RUN pip install --upgrade pip && pip install getgist

RUN curl -sSL https://install.python-poetry.org | python3 - --git https://github.com/python-poetry/poetry.git@master
# RUN curl -sSL https://install.python-poetry.org | python3 - --git https://github.com/python-poetry/poetry.git@master \
#  && poetry completions bash >> ~/.bash_completion

# RUN brew install thefuck \
#  && echo 'eval "$(thefuck --alias)"' >> ~/.bashrc

# RUN brew install gradle-completion \
#  && echo '[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"' >> ~/.bash_profile

# ARG pyCharmDownloadUrl="https://download.jetbrains.com/python/pycharm-professional-223.6160.21.tar.gz"
# RUN wget ${pyCharmDownloadUrl} \
#  && pyCharmInstallationFile=$(basename ${pyCharmDownloadUrl}) \
#  && sudo tar -xvf $pyCharmInstallationFile -C /usr/local/ \
#  && rm $pyCharmInstallationFile

# RUN cd $HOME \
#  && wget https://github.com/java-decompiler/jd-gui/releases/download/v1.6.6/jd-gui-1.6.6.jar

# ARG apktoolDownloadUrl="https://github.com/iBotPeaches/Apktool/releases/download/v2.6.1/apktool_2.6.1.jar"
# RUN cd $HOME \
#  && mkdir apktool \
#  && cd apktool \
#  && wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool ${apktoolDownloadUrl} \
#  && apktoolJarFile=$(basename ${apktoolDownloadUrl}) \
#  && mv $apktoolJarFile apktool.jar \
#  && chmod +x apktool apktool.jar

# ENV PATH=$HOME/apktool:$PATH

# ARG jadxDownloadUrl="https://github.com/skylot/jadx/releases/download/v1.4.5/jadx-1.4.5.zip"
# RUN cd $HOME \
#  && wget ${jadxDownloadUrl} \
#  && jadxArchieveFile=$(basename ${jadxDownloadUrl}) \
#  && jadxFolder=$(echo $jadxArchieveFile | sed 's/\(.*\)\..*/\1/') \
#  && unzip $jadxArchieveFile -d $jadxFolder \
#  && rm $jadxArchieveFile \
#  && sed -i 's/DEFAULT_JVM_OPTS=""/DEFAULT_JVM_OPTS='"'"'"-Dsun.java2d.xrender=false"'"'"'/g' $HOME/$jadxFolder/bin/jadx-gui \
#  && echo $jadxFolder > $HOME/jadxFolder

# ARG dexToolsDownloadUrl="https://github.com/pxb1988/dex2jar/releases/download/v2.2-SNAPSHOT-2021-10-31/dex-tools-2.2-SNAPSHOT-2021-10-31.zip"
# RUN cd $HOME \
#  && wget ${dexToolsDownloadUrl} \
#  && dexToolsArchieveFile=$(basename ${dexToolsDownloadUrl}) \
#  && unzip $dexToolsArchieveFile \
#  && rm $dexToolsArchieveFile \
#  && echo $dexToolsArchieveFile | sed 's/\(.*\)\..*/\1/' | cut -d '-' -f1,2,3,4 > $HOME/dexToolsFolder

# RUN cd $HOME \
#  && wget "https://gist.githubusercontent.com/SergLam/3adb64051a1c8ebd8330191aedcefe47/raw/7936d8acde59cc31f487bc455904e3942d7ecbda/xcode-downloader.rb" \
#  && chmod a+x xcode-downloader.rb \
#  && sudo mv xcode-downloader.rb /usr/local/bin/

RUN sudo systemctl enable squid \
 && sudo sed -i 's/http_access deny all/http_access allow all/g' /etc/squid/squid.conf \
 && sudo service squid restart

ENV FVM_CACHE_PATH=/workspace/fvm

RUN brew tap leoafarias/fvm \
 && brew install leoafarias/fvm/fvm glab \
#  && brew install dart-sdk \
#  && dart pub global activate very_good_cli \
#  && brew uninstall dart-sdk \
 && brew autoremove \
 && brew cleanup

ENV PATH=$FVM_CACHE_PATH/default/bin:$HOME/.pub-cache/bin:$PATH

COPY tigerVncGeometry.txt $HOME
RUN searchKey='test -e "$GITPOD_REPO_ROOT"' && TIGERVNC_GEOMETRY=$(cat $HOME/tigerVncGeometry.txt) && sed -i "s|$searchKey && gp-vncsession|export TIGERVNC_GEOMETRY=$TIGERVNC_GEOMETRY \&\& $searchKey \&\& gp-vncsession|" $HOME/.bashrc

RUN bash -c ". /home/gitpod/.sdkman/bin/sdkman-init.sh && sdk update && sdk upgrade"

# Setup PostgreSQL server for user gitpod
ENV PATH=$PATH:/usr/lib/postgresql/16/bin
ENV PGDATA=/home/gitpod/.pg_ctl/data
RUN mkdir -p ~/.pg_ctl/bin ~/.pg_ctl/data ~/.pg_ctl/sockets \
 && initdb -D ~/.pg_ctl/data/ \
 && printf "#!/bin/bash\npg_ctl -D ~/.pg_ctl/data/ -l ~/.pg_ctl/log -o \"-k ~/.pg_ctl/sockets\" start\n" > ~/.pg_ctl/bin/pg_start \
 && printf "#!/bin/bash\npg_ctl -D ~/.pg_ctl/data/ -l ~/.pg_ctl/log -o \"-k ~/.pg_ctl/sockets\" stop\n" > ~/.pg_ctl/bin/pg_stop \
 && chmod +x ~/.pg_ctl/bin/*
ENV PATH=$PATH:$HOME/.pg_ctl/bin
ENV DATABASE_URL="postgresql://gitpod@localhost"

ENV PATH=$PATH:$HOME/.dotnet/tools
RUN git config --global credential.credentialStore cache \
 && git config --global credential.cacheOptions "--timeout 1576800000" \
 && dotnet tool install -g git-credential-manager
#  && dotnet tool install -g git-credential-manager \
#  && git-credential-manager configure
