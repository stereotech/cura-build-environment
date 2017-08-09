set(extra_cmake_args "")
set(make_tool "make")
if(BUILD_OS_WINDOWS)
    set(extra_cmake_args -G "MinGW Makefiles")
    set(make_tool "mingw32-make")
endif()

ExternalProject_Add(CppUnit
    GIT_REPOSITORY https://github.com/Ultimaker/CppUnit.git
    GIT_TAG cmake
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DCMAKE_INSTALL_LIBDIR=lib -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} ${extra_cmake_args}
    BUILD_COMMAND ${make_tool}
    INSTALL_COMMAND ${make_tool} install
)
