if(BUILD_OS_OSX)
    ExternalProject_Add(sqlite3
        URL https://www.sqlite.org/2019/sqlite-autoconf-3290000.tar.gz
        URL_HASH SHA256=8e7c1e2950b5b04c5944a981cb31fffbf9d2ddda939d536838ebc854481afd5b
        CONFIGURE_COMMAND ./configure --disable-debug --disable-dependency-tracking --disable-silent-rules --prefix=${CMAKE_INSTALL_PREFIX} --with-sysroot=${CMAKE_OSX_SYSROOT}
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET sqlite3 DEPENDS zlib)
elseif(BUILD_OS_LINUX)
    ExternalProject_Add(sqlite3
        URL https://www.sqlite.org/2019/sqlite-autoconf-3290000.tar.gz
        URL_HASH SHA256=8e7c1e2950b5b04c5944a981cb31fffbf9d2ddda939d536838ebc854481afd5b
        PATCH_COMMAND libtoolize
        CONFIGURE_COMMAND ./configure --disable-debug --disable-dependency-tracking --disable-silent-rules --prefix=${CMAKE_INSTALL_PREFIX}
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET sqlite3 DEPENDS zlib)
endif()
