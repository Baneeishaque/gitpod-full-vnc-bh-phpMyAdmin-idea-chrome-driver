install_android_components() {
    sdkmanager --install \
        "platforms;android-35" \
        "platform-tools" \
        "build-tools;35.0.0"
}
