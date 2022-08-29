FROM gitpod/workspace-full-vnc

ENV TIGERVNC_GEOMETRY=1846x968 

ARG phpMyAdminDownloadUrl=https://files.phpmyadmin.net/phpMyAdmin/5.2.0/phpMyAdmin-5.2.0-all-languages.zip
RUN # pwd \
 # && 
 wget ${phpMyAdminDownloadUrl} \
 # && ls -a $(pwd) \
 && phpMyAdminArchieveFile=$(basename ${phpMyAdminDownloadUrl}) \
 # && echo $phpMyAdminArchieveFile \
 && sudo unzip $phpMyAdminArchieveFile -d /opt/ \
 # && ls -a /opt/ \
 && rm $phpMyAdminArchieveFile \
 # && ls -a $(pwd) \
 && phpMyAdminFolder=$(echo $phpMyAdminArchieveFile | sed 's/\(.*\)\..*/\1/') \
 # && ls -a /opt/$phpMyAdminFolder \
 && sudo cp /opt/$phpMyAdminFolder/config.sample.inc.php /opt/$phpMyAdminFolder/config.inc.php \
 # && ls -a /opt/$phpMyAdminFolder \
 && printf "\n\$cfg['AllowArbitraryServer'] = true;" | sudo tee -a /opt/$phpMyAdminFolder/config.inc.php >/dev/null
 # && cat /opt/$phpMyAdminFolder/config.inc.php

ARG intellijIdeaDownloadUrl="https://download.jetbrains.com/idea/ideaIU-2022.2.1.tar.gz"
RUN wget ${intellijIdeaDownloadUrl} \
 && intellijIdeaInstallationFile=$(basename ${intellijIdeaDownloadUrl}) \
 && sudo tar -xvf $intellijIdeaInstallationFile -C /usr/local/ \
 && rm $intellijIdeaInstallationFile
RUN mkdir -p ~/.config/JetBrains/IntelliJIdea2022.2 \
 && cp /usr/local/idea-IU-222.3739.54/bin/idea64.vmoptions ~/.config/JetBrains/IntelliJIdea2022.2/ \
 && echo "-Dsun.java2d.xrender=false" >> ~/.config/JetBrains/IntelliJIdea2022.2/idea64.vmoptions
RUN sudo apt update \
 && sudo apt install -y \
     libxtst6 \
 && sudo rm -rf /var/lib/apt/lists/*