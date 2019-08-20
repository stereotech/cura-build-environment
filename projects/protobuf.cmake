if(BUILD_OS_OSX)
    set(protobuf_cxx_flags "-fPIC -std=c++11 -stdlib=libc++")
elseif(BUILD_OS_LINUX)
    set(protobuf_cxx_flags "-fPIC -std=c++11")
else()
    set(protobuf_cxx_flags "")
endif()

set(protobuf_configure_args
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}
    -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
    -DCMAKE_INSTALL_LIBDIR=lib
    -DCMAKE_INSTALL_CMAKEDIR=lib/cmake/protobuf
    -DCMAKE_CXX_FLAGS=${protobuf_cxx_flags}
    -Dprotobuf_BUILD_TESTS=OFF
    -Dprotobuf_BUILD_SHARED_LIBS=OFF
    -Dprotobuf_WITH_ZLIB=OFF
)

if(BUILD_OS_OSX)
    if (CMAKE_OSX_DEPLOYMENT_TARGET)
        list(APPEND protobuf_configure_args
            -DCMAKE_OSX_DEPLOYMENT_TARGET=${CMAKE_OSX_DEPLOYMENT_TARGET}
        )
    endif()
    if (CMAKE_OSX_SYSROOT)
        list(APPEND protobuf_configure_args
            -DCMAKE_OSX_SYSROOT=${CMAKE_OSX_SYSROOT}
        )
    endif()
endif()

ExternalProject_Add(Protobuf
    URL https://github.com/google/protobuf/archive/v3.0.2.tar.gz
    URL_MD5 7349a7f43433d72c6d805c6ca22b7eeb
    CONFIGURE_COMMAND ${CMAKE_COMMAND} ${protobuf_configure_args} -G ${CMAKE_GENERATOR} ../Protobuf/cmake
)

if(BUILD_OS_WINDOWS)
    # Compile it again, this time using MinGW
    # We need to build the Arcus Python plugin with MSVC due to Python.
    # However, we also need a MinGW library because CuraEngine does not really support MSVC.
    # Since the two are ABI-incompatible we need two versions of the library...
    set(protobuf_configure_args
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        -DCMAKE_INSTALL_BINDIR=lib-mingw
        -DCMAKE_INSTALL_LIBDIR=lib-mingw
        -DCMAKE_CXX_FLAGS="--std=c++11"
        -Dprotobuf_BUILD_TESTS=OFF
        -Dprotobuf_BUILD_SHARED_LIBS=OFF
    )

    ExternalProject_Add(Protobuf-MinGW
        URL https://github.com/google/protobuf/archive/v3.0.2.tar.gz
        URL_MD5 7349a7f43433d72c6d805c6ca22b7eeb
        DEPENDS Protobuf
        CONFIGURE_COMMAND ${CMAKE_COMMAND} ${protobuf_configure_args} -G "MinGW Makefiles" ../Protobuf-MinGW/cmake
        BUILD_COMMAND mingw32-make
        INSTALL_COMMAND mingw32-make install
    )
endif()

if(BUILD_OS_OSX AND OSX_USE_GCC)
    # Compile it again, this time using GCC. Mac OS X clang doesn't support OpenMP but GCC does. Use GCC to compile
    # CuraEngine so it can use multithreading.
    set(protobuf_configure_args
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}/gcc
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}/gcc
        -DCMAKE_C_COMPILER=${OSX_GCC_C_COMPILER}
        -DCMAKE_C_FLAGS="-isystem ${CMAKE_PREFIX_PATH}/gcc/include"
        -DCMAKE_CXX_COMPILER=${OSX_GCC_CXX_COMPILER}
        -DCMAKE_CXX_FLAGS="-isystem ${CMAKE_PREFIX_PATH}/gcc/include"
        -Dprotobuf_BUILD_TESTS=OFF
        -Dprotobuf_BUILD_SHARED_LIBS=ON
    )

    ExternalProject_Add(Protobuf-GCC
        URL https://github.com/protocolbuffers/protobuf/archive/v3.0.2.tar.gz
        URL_MD5 7349a7f43433d72c6d805c6ca22b7eeb
        DEPENDS Protobuf
        CONFIGURE_COMMAND ${CMAKE_COMMAND} ${protobuf_configure_args} -G "Unix Makefiles" ../Protobuf-GCC/cmake
        BUILD_COMMAND make
        INSTALL_COMMAND make install
    )
endif()
