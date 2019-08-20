if(NOT BUILD_OS_WINDOWS)
    set(geos_configure_args
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DGEOS_ENABLE_TESTS=OFF
    )

    if(BUILD_OS_OSX)
        if(CMAKE_OSX_DEPLOYMENT_TARGET)
            list(APPEND geos_configure_args
                -DCMAKE_OSX_DEPLOYMENT_TARGET=${CMAKE_OSX_DEPLOYMENT_TARGET}
            )
        endif()
        if(CMAKE_OSX_SYSROOT)
            list(APPEND geos_configure_args
                -DCMAKE_OSX_SYSROOT=${CMAKE_OSX_SYSROOT}
            )
        endif()
    endif()

    ExternalProject_Add(Geos
        URL http://download.osgeo.org/geos/geos-3.7.2.tar.bz2
        URL_HASH SHA256=2166e65be6d612317115bfec07827c11b403c3f303e0a7420a2106bc999d7707
        CONFIGURE_COMMAND ${CMAKE_COMMAND} ${geos_configure_args} -G ${CMAKE_GENERATOR} ../Geos
    )
endif()
