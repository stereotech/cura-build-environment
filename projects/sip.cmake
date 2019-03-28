if(BUILD_OS_WINDOWS)
    set(sip_command
        ${PYTHON_EXECUTABLE}
        configure.py
        --platform win32-msvc2015
    )
elseif(BUILD_OS_LINUX)
    set(sip_command
        ${PYTHON_EXECUTABLE}
        configure.py
        --bindir=${CMAKE_INSTALL_PREFIX}/bin
        --destdir=${CMAKE_INSTALL_PREFIX}/lib/python3.5/site-packages
        --incdir=${CMAKE_INSTALL_PREFIX}/include
        --sipdir=${CMAKE_INSTALL_PREFIX}/share/sip
    )
elseif(BUILD_OS_OSX)
    set(sip_command
        ${PYTHON_EXECUTABLE}
        configure.py
    )
else()
    set(sip_command "")
endif()

ExternalProject_Add(Sip
    URL https://www.riverbankcomputing.com/static/Downloads/sip/4.19.15/sip-4.19.15.tar.gz
    URL_MD5 236578d2199da630ae1251671b9a7bfe
    CONFIGURE_COMMAND ${sip_command}
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET Sip DEPENDS Python)
