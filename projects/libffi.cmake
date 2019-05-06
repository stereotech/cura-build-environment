if(BUILD_OS_LINUX)
    ExternalProject_Add(libffi
        URL ftp://sourceware.org/pub/libffi/libffi-3.2.1.tar.gz
        URL_HASH SHA256=d06ebb8e1d9a22d19e38d63fdb83954253f39bedc5d46232a05645685722ca37
        CONFIGURE_COMMAND ./configure --prefix=${CMAKE_INSTALL_PREFIX} --disable-debug --disable-dependency-tracking
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
endif()
