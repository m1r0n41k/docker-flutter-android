FROM cirrusci/android-sdk:27

RUN sudo apt-get update \
    && sudo apt-get install -y --allow-unauthenticated --no-install-recommends lib32stdc++6 libstdc++6 libglu1-mesa locales \
    && sudo rm -rf /var/lib/apt/lists/*

RUN sudo locale-gen en_US "en_US.UTF-8" \
    && sudo dpkg-reconfigure locales

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US:en

RUN $ANDROID_HOME/tools/bin/sdkmanager --install "build-tools;28.0.3"
RUN yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses

ENV FLUTTER_HOME ${HOME}/sdks/flutter
RUN git clone --branch master https://github.com/flutter/flutter.git ${FLUTTER_HOME}

ENV PATH ${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin

# doctor
RUN flutter doctor
