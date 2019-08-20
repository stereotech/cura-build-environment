if(BUILD_OS_LINUX)
    set(_freetype_config_cmd
        BZIP2_CFLAGS="-I${CMAKE_INSTALL_PREFIX}/include"
        BZIP2_LIBS="-L${CMAKE_INSTALL_PREFIX}/lib"
        ./configure --prefix=${CMAKE_INSTALL_PREFIX} --with-zlib=yes --with-bzip2=yes
    )

    ExternalProject_Add(freetype
        URL https://sourceforge.net/projects/freetype/files/freetype2/2.10.1/freetype-2.10.1.tar.xz
        URL_HASH SHA256=16dbfa488a21fe827dc27eaf708f42f7aa3bb997d745d31a19781628c36ba26f
        CONFIGURE_COMMAND ${_freetype_config_cmd}
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET freetype DEPENDS bzip2-shared bzip2-static zlib)
endif()
