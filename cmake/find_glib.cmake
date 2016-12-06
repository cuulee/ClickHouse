set (GLIB_HINTS "/usr/local/opt/glib/lib")
set (GLIB_INCLUDE_HINTS
	"/usr/local/include/glib-2.0/"
	"/usr/local/lib/glib-2.0/include/"
	"/usr/include/glib-2.0/"
	"/usr/lib64/glib-2.0/include/")
if (AARCH64)
	set (GLIB_INCLUDE_HINTS ${GLIB_INCLUDE_HINTS} "/usr/lib/aarch64-linux-gnu/glib-2.0/include/")
else ()
	set (GLIB_INCLUDE_HINTS ${GLIB_INCLUDE_HINTS} "/usr/lib/x86_64-linux-gnu/glib-2.0/include/")
endif ()
if (USE_STATIC_LIBRARIES)
	find_library (GLIB_LIB libglib-2.0.a HINTS ${GLIB_HINTS})
else ()
	find_library (GLIB_LIB glib-2.0 HINTS ${GLIB_HINTS})
endif ()
find_path (GLIB_INCLUDE_DIR NAMES glib.h HINTS ${GLIB_INCLUDE_HINTS})
find_path (GLIB_CONFIG_INCLUDE_DIR NAMES glibconfig.h HINTS ${GLIB_INCLUDE_HINTS})
include_directories (${GLIB_INCLUDE_DIR})
include_directories (${GLIB_CONFIG_INCLUDE_DIR})
if (APPLE)
	set (INTL_HINTS "/usr/local/opt/gettext/lib")
	if (USE_STATIC_LIBRARIES)
		find_library (INTL_LIB libintl.a HINTS ${INTL_HINTS})
	else ()
		find_library (INTL_LIB intl HINTS ${INTL_HINTS})
	endif ()
	set (ICONV_HINTS "/usr/local/opt/libiconv/lib")
	if (USE_STATIC_LIBRARIES)
		find_library (ICONV_LIB libiconv.a HINTS ${ICONV_HINTS})
	else ()
		find_library (ICONV_LIB iconv HINTS ${ICONV_HINTS})
	endif ()
	find_library (CORE_FOUNDATION_LIB CoreFoundation)
	find_library (CARBON_LIB Carbon)
	set (GLIB_LIBS ${GLIB_LIB} ${INTL_LIB} ${ICONV_LIB} ${CORE_FOUNDATION_LIB} ${CARBON_LIB})
else (APPLE)
	set (GLIB_LIBS ${GLIB_LIB})
endif (APPLE)