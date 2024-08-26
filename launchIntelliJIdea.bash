cd /workspace
git clone --depth 1 "https://gitlab.com/baneeishaque/gitpod-workspace-full-vnc-1366x768-tint2-pcmanfm-zsh-android-studio-gh-chrome-intellij-idea.git" intellij-idea-config
rm -rf ~/.config/JetBrains/IntelliJIdea2022.2
mkdir -p ~/.config/JetBrains
ln -s `pwd`/intellij-idea-config/IntelliJIdea2022.2-config ~/.config/JetBrains/IntelliJIdea2022.2
rm -rf ~/.local/share/JetBrains/IntelliJIdea2022.2
mkdir -p ~/.local/share/JetBrains
ln -s `pwd`/intellij-idea-config/IntelliJIdea2022.2-local ~/.local/share/JetBrains/IntelliJIdea2022.2
rm -rf ~/.local/share/JetBrains/consentOptions
ln -s `pwd`/intellij-idea-config/consentOptions ~/.local/share/JetBrains/consentOptions
rm -rf ~/.local/share/JetBrains/bl
ln -s `pwd`/intellij-idea-config/bl ~/.local/share/JetBrains/bl
rm -rf ~/.local/share/JetBrains/crl
ln -s `pwd`/intellij-idea-config/crl ~/.local/share/JetBrains/crl
cd /usr/local/idea-IU-222.4167.29/bin/
./idea.sh
