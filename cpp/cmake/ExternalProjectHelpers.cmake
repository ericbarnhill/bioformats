## #%L
# Bio-Formats C++ libraries (cmake build infrastructure)
# %%
# Copyright © 2006 - 2014 Open Microscopy Environment:
#   - Massachusetts Institute of Technology
#   - National Institutes of Health
#   - University of Dundee
#   - Board of Regents of the University of Wisconsin-Madison
#   - Glencoe Software, Inc.
# %%
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# The views and conclusions contained in the software and documentation are
# those of the authors and should not be interpreted as representing official
# policies, either expressed or implied, of any organization.
# #L%

# Compute -G arg for configuring external projects with the same CMake generator:
if(CMAKE_EXTRA_GENERATOR)
  set(BIOFORMATS_EP_GENERATOR "${CMAKE_EXTRA_GENERATOR} - ${CMAKE_GENERATOR}")
else()
  set(BIOFORMATS_EP_GENERATOR "${CMAKE_GENERATOR}")
endif()

set(source-cache "${CMAKE_BINARY_DIR}/sourcecache" CACHE FILEPATH "Directory for cached source downloads")
file(MAKE_DIRECTORY ${source-cache})

set(BIOFORMATS_EP_INSTALL_DIR ${CMAKE_BINARY_DIR}/superbuild-install)
set(BIOFORMATS_EP_INCLUDE_DIR ${CMAKE_BINARY_DIR}/superbuild-install/${CMAKE_INSTALL_INCLUDEDIR})
set(BIOFORMATS_EP_LIB_DIR ${CMAKE_BINARY_DIR}/superbuild-install/${CMAKE_INSTALL_LIBDIR})
set(BIOFORMATS_EP_BIN_DIR ${CMAKE_BINARY_DIR}/superbuild-install/${CMAKE_INSTALL_BINDIR})

list(APPEND CMAKE_PREFIX_PATH "${BIOFORMATS_EP_INSTALL_DIR}")

# Look in superbuild staging tree when building
if(WIN32)
  # Windows compiler flags
else()
  set(CMAKE_CXX_FLAGS           "${CMAKE_CXX_FLAGS} -I${BIOFORMATS_EP_INCLUDE_DIR}")
  set(CMAKE_EXE_LINKER_FLAGS    "${CMAKE_EXE_LINKER_FLAGS} -L${BIOFORMATS_EP_LIB_DIR}")
  set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -L${BIOFORMATS_EP_LIB_DIR}")
  set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -L${BIOFORMATS_EP_LIB_DIR}")
endif()


set(EP_SCRIPT_CONFIG "${PROJECT_BINARY_DIR}/project-config.cmake")

string(REPLACE ";" "^^" BIOFORMATS_EP_ESCAPED_CMAKE_PREFIX_PATH "${CMAKE_PREFIX_PATH}")

set(BIOFORMATS_EP_CMAKE_ARGS
  "-DCMAKE_PREFIX_PATH:INTERNAL=${BIOFORMATS_EP_ESCAPED_CMAKE_PREFIX_PATH}"
  "-DCMAKE_BUILD_TYPE:INTERNAL=${CMAKE_BUILD_TYPE}"
)

# Set CMake OSX variables needed to be passed to external projects
if(APPLE)
  list(APPEND BIOFORMATS_EP_CMAKE_ARGS
    -DCMAKE_OSX_ARCHITECTURES:STRING=${CMAKE_OSX_ARCHITECTURES}
    -DCMAKE_OSX_SYSROOT:PATH=${CMAKE_OSX_SYSROOT}
    -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING=${CMAKE_OSX_DEPLOYMENT_TARGET})
endif()

set(BIOFORMATS_EP_CMAKE_CACHE_ARGS
  "-DCMAKE_AR:FILEPATH=${CMAKE_AR}"
  "-DCMAKE_C_COMPILER:FILEPATH=${CMAKE_C_COMPILER}"
  "-DCMAKE_CXX_COMPILER:FILEPATH=${CMAKE_CXX_COMPILER}"
  "-DCMAKE_LINKER:FILEPATH=${CMAKE_LINKER}"
  "-DCMAKE_MAKE_PROGRAM:FILEPATH=${CMAKE_MAKE_PROGRAM}"
  "-DCMAKE_NM:FILEPATH=${CMAKE_NM}"
  "-DCMAKE_OBJCOPY:FILEPATH=${CMAKE_OBJCOPY}"
  "-DCMAKE_OBJDUMP:FILEPATH=${CMAKE_OBJDUMP}"
  "-DCMAKE_RANLIB:FILEPATH=${CMAKE_RANLIB}"
  "-DCMAKE_STRIP:FILEPATH=${CMAKE_STRIP}"

  "-DCMAKE_MAKE_PROGRAM:FILEPATH=${CMAKE_MAKE_PROGRAM}"

  "-DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}"
  "-DCMAKE_CXX_FLAGS_DEBUG:STRING=${CMAKE_CXX_FLAGS_DEBUG}"
  "-DCMAKE_CXX_FLAGS_MINSIZEREL:STRING=${CMAKE_CXX_FLAGS_MINSIZEREL}"
  "-DCMAKE_CXX_FLAGS_RELEASE:STRING=${CMAKE_CXX_FLAGS_RELEASE}"
  "-DCMAKE_CXX_FLAGS_RELWITHDEBINFO:STRING=${CMAKE_CXX_FLAGS_RELWITHDEBINFO}"

  "-DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS}"
  "-DCMAKE_C_FLAGS_DEBUG:STRING=${CMAKE_C_FLAGS_DEBUG}"
  "-DCMAKE_C_FLAGS_MINSIZEREL:STRING=${CMAKE_C_FLAGS_MINSIZEREL}"
  "-DCMAKE_C_FLAGS_RELEASE:STRING=${CMAKE_C_FLAGS_RELEASE}"
  "-DCMAKE_C_FLAGS_RELWITHDEBINFO:STRING=${CMAKE_C_FLAGS_RELWITHDEBINFO}"

  "-DCMAKE_EXE_LINKER_FLAGS:STRING=${CMAKE_EXE_LINKER_FLAGS}"
  "-DCMAKE_EXE_LINKER_FLAGS_DEBUG:STRING=${CMAKE_EXE_LINKER_FLAGS_DEBUG}"
  "-DCMAKE_EXE_LINKER_FLAGS_MINSIZEREL:STRING=${CMAKE_EXE_LINKER_FLAGS_MINSIZEREL}"
  "-DCMAKE_EXE_LINKER_FLAGS_RELEASE:STRING=${CMAKE_EXE_LINKER_FLAGS_RELEASE}"
  "-DCMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO:STRING=${CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO}"

  "-DCMAKE_MODULE_LINKER_FLAGS:STRING=${CMAKE_MODULE_LINKER_FLAGS}"
  "-DCMAKE_MODULE_LINKER_FLAGS_DEBUG:STRING=${CMAKE_MODULE_LINKER_FLAGS_DEBUG}"
  "-DCMAKE_MODULE_LINKER_FLAGS_MINSIZEREL:STRING=${CMAKE_MODULE_LINKER_FLAGS_MINSIZEREL}"
  "-DCMAKE_MODULE_LINKER_FLAGS_RELEASE:STRING=${CMAKE_MODULE_LINKER_FLAGS_RELEASE}"
  "-DCMAKE_MODULE_LINKER_FLAGS_RELWITHDEBINFO:STRING=${CMAKE_MODULE_LINKER_FLAGS_RELWITHDEBINFO}"

  "-DCMAKE_SHARED_LINKER_FLAGS:STRING=${CMAKE_SHARED_LINKER_FLAGS}"
  "-DCMAKE_SHARED_LINKER_FLAGS_DEBUG:STRING=${CMAKE_SHARED_LINKER_FLAGS_DEBUG}"
  "-DCMAKE_SHARED_LINKER_FLAGS_MINSIZEREL:STRING=${CMAKE_SHARED_LINKER_FLAGS_MINSIZEREL}"
  "-DCMAKE_SHARED_LINKER_FLAGS_RELEASE:STRING=${CMAKE_SHARED_LINKER_FLAGS_RELEASE}"
  "-DCMAKE_SHARED_LINKER_FLAGS_RELWITHDEBINFO:STRING=${CMAKE_SHARED_LINKER_FLAGS_RELWITHDEBINFO}"

  "-DCMAKE_STATIC_LINKER_FLAGS:STRING=${CMAKE_STATIC_LINKER_FLAGS}"
  "-DCMAKE_STATIC_LINKER_FLAGS_DEBUG:STRING=${CMAKE_STATIC_LINKER_FLAGS_DEBUG}"
  "-DCMAKE_STATIC_LINKER_FLAGS_MINSIZEREL:STRING=${CMAKE_STATIC_LINKER_FLAGS_MINSIZEREL}"
  "-DCMAKE_STATIC_LINKER_FLAGS_RELEASE:STRING=${CMAKE_STATIC_LINKER_FLAGS_RELEASE}"
  "-DCMAKE_STATIC_LINKER_FLAGS_RELWITHDEBINFO:STRING=${CMAKE_STATIC_LINKER_FLAGS_RELWITHDEBINFO}"

  "-DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=${CMAKE_EXPORT_COMPILE_COMMANDS}"

  "-DCMAKE_INSTALL_BINDIR:PATH=${CMAKE_INSTALL_BINDIR}"
  "-DCMAKE_INSTALL_DATADIR:PATH=${CMAKE_INSTALL_DATADIR}"
  "-DCMAKE_INSTALL_DATAROOTDIR:PATH=${CMAKE_INSTALL_DATAROOTDIR}"
  "-DCMAKE_INSTALL_DOCDIR:PATH=${CMAKE_INSTALL_DOCDIR}"
  "-DCMAKE_INSTALL_INCLUDEDIR:PATH=${CMAKE_INSTALL_INCLUDEDIR}"
  "-DCMAKE_INSTALL_INFODIR:PATH=${CMAKE_INSTALL_INFODIR}"
  "-DCMAKE_INSTALL_LIBDIR:PATH=${CMAKE_INSTALL_LIBDIR}"
  "-DCMAKE_INSTALL_LIBEXECDIR:PATH=${CMAKE_INSTALL_LIBEXECDIR}"
  "-DCMAKE_INSTALL_LOCALEDIR:PATH=${CMAKE_INSTALL_LOCALEDIR}"
  "-DCMAKE_INSTALL_LOCALSTATEDIR:PATH=${CMAKE_INSTALL_LOCALSTATEDIR}"
  "-DCMAKE_INSTALL_MANDIR:PATH=${CMAKE_INSTALL_MANDIR}"
  "-DCMAKE_INSTALL_OLDINCLUDEDIR:PATH=${CMAKE_INSTALL_OLDINCLUDEDIR}"
  "-DCMAKE_INSTALL_SBINDIR:PATH=${CMAKE_INSTALL_SBINDIR}"
  "-DCMAKE_INSTALL_SHAREDSTATEDIR:PATH=${CMAKE_INSTALL_SHAREDSTATEDIR}"
  "-DCMAKE_INSTALL_SYSCONFDIR:PATH=${CMAKE_INSTALL_SYSCONFDIR}"

  "-DCMAKE_PREFIX_PATH:PATH=${CMAKE_PREFIX_PATH}"

  "-DCMAKE_SKIP_INSTALL_RPATH:BOOL=${CMAKE_SKIP_INSTALL_RPATH}"
  "-DCMAKE_SKIP_RPATH:BOOL=${CMAKE_SKIP_RPATH}"
  "-DCMAKE_USE_RELATIVE_PATHS:BOOL=${CMAKE_USE_RELATIVE_PATHS}"
  "-DCMAKE_VERBOSE_MAKEFILE:BOOL=${CMAKE_VERBOSE_MAKEFILE}"

  ${SUPERBUILD_OPTIONS}
)

# With make, we can do a DESTDIR staging install, otherwise we have to
# make the staging directory the installation prefix (which might
# cause problems when the contents are relocated).
if (CMAKE_GENERATOR MATCHES "Unix Makefiles")
  list(APPEND BIOFORMATS_EP_CMAKE_CACHE_ARGS "-DCMAKE_INSTALL_PREFIX:PATH=")
else()
  list(APPEND BIOFORMATS_EP_CMAKE_CACHE_ARGS "-DCMAKE_INSTALL_PREFIX:PATH=${BIOFORMATS_EP_INSTALL_DIR}")
endif()

# Primarily for Windows; will need extending for non-x86 platforms if required.
if(MSVC)
  list(APPEND BIOFORMATS_EP_CMAKE_CACHE_ARGS
       "-DMSVC:INTERNAL=${MSVC}"
       "-DMSVC_VERSION:INTERNAL=${MSVC_VERSION}"
       "-DCMAKE_VS_PLATFORM_NAME:INTERNAL=${CMAKE_VS_PLATFORM_NAME}"
       "-DCMAKE_VS_PLATFORM_TOOLSET:INTERNAL=${CMAKE_VS_PLATFORM_TOOLSET}")
endif()

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
  list(APPEND BIOFORMATS_EP_CMAKE_CACHE_ARGS
       "-DEP_PLATFORM_BITS:INTERNAL=64")
else()
  list(APPEND BIOFORMATS_EP_CMAKE_CACHE_ARGS
       "-DEP_PLATFORM_BITS:INTERNAL=32")
endif()

set(BIOFORMATS_EP_SCRIPT_ARGS
  "-DCMAKE_C_COMPILER_ID:STRING=${CMAKE_C_COMPILER_ID}"
  "-DCMAKE_CXX_COMPILER_ID:STRING=${CMAKE_CXX_COMPILER_ID}"
  "-DBIOFORMATS_EP_INSTALL_DIR:PATH=${BIOFORMATS_EP_INSTALL_DIR}"
  "-DBIOFORMATS_EP_BIN_DIR:PATH=${BIOFORMATS_EP_BIN_DIR}"
  "-DBIOFORMATS_EP_INCLUDE_DIR:PATH=${BIOFORMATS_EP_INCLUDE_DIR}"
  "-DBIOFORMATS_EP_LIB_DIR:PATH=${BIOFORMATS_EP_LIB_DIR}"
  "-DCMAKE_GENERATOR:PATH=${CMAKE_GENERATOR}"
)

  set(BIOFORMATS_EP_COMMON_ARGS
  LIST_SEPARATOR "^^"
  DOWNLOAD_DIR ${source-cache}
  CMAKE_GENERATOR ${BIOFORMATS_EP_GENERATOR}
  CMAKE_ARGS ${BIOFORMATS_EP_CMAKE_ARGS}
  CMAKE_CACHE_ARGS ${BIOFORMATS_EP_CMAKE_CACHE_ARGS}
)

# Create script file for use by external project scripts, where the
# command-line and cache args won't be used.
foreach(arg ${BIOFORMATS_EP_CMAKE_ARGS}
            ${BIOFORMATS_EP_CMAKE_CACHE_ARGS}
            ${BIOFORMATS_EP_SCRIPT_ARGS})
  if("${arg}" MATCHES "^-D(.*)")
    set(arg "${CMAKE_MATCH_1}")
    if("${arg}" MATCHES "^([^:]+):([^=]+)=(.*)$")
      set(name "${CMAKE_MATCH_1}")
      set(type "${CMAKE_MATCH_2}")
      set(value "${CMAKE_MATCH_3}")
      string(REPLACE "\"" "\\\"" value "${value}")
      set(line "set(${name} \"${value}\" CACHE ${type} \"${name} from superbuild\")")
      list(APPEND EP_SCRIPT_PARAMS "${line}")
    else()
      message(WARNING "Regex match failed for ${arg}")
    endif()
  endif()
endforeach()
string(REPLACE ";" "\n" EP_SCRIPT_PARAMS "${EP_SCRIPT_PARAMS}")
file(WRITE "${EP_SCRIPT_CONFIG}" "${EP_SCRIPT_PARAMS}")