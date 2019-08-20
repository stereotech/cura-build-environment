if(BUILD_OS_LINUX)
    set(_fontconfig_config_cmd
        PKG_CONFIG_PATH="${CMAKE_INSTALL_PREFIX}/lib/pkgconfig"
        ./configure --disable-debug --disable-dependency-tracking --disable-silent-rules
            --prefix=${CMAKE_INSTALL_PREFIX}
    )

    ExternalProject_Add(fontconfig
        URL https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.13.92.tar.gz
        URL_HASH SHA256=3406a05b83a42231e3df68d02bc0a0cf47b3f2e8f11c8ede62267daf5f130016
        CONFIGURE_COMMAND ${_fontconfig_config_cmd}
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET fontconfig DEPENDS freetype)
endif()
