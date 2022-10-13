function(handle_langulus_features)

if (CMAKE_CXX_FLAGS)
    STRING(FIND ${CMAKE_CXX_FLAGS} "/Zc:trigraphs" TRIGRAPHS_ENABLED)
    if (${TRIGRAPHS_ENABLED} GREATER -1)
        message(FATAL_ERROR "Langulus can't be built with trigraphs enabled")
    endif()

    STRING(FIND ${CMAKE_CXX_FLAGS} "-trigraphs" TRIGRAPHS_ENABLED)
    if (${TRIGRAPHS_ENABLED} GREATER -1)
        message(FATAL_ERROR "Langulus can't be built with trigraphs enabled")
    endif()
endif()

# Configure the features you require, all these are disabled by default
option(LANGULUS_ENABLE_SAFE_MODE 
    "Overrides additional error checking and sanity checks, \
    incurs a serious runtime overhead")

option(LANGULUS_ENABLE_PARANOIA 
    "Make sure that any unused memory is nullified, \
    incurs a serious runtime overhead")

option(LANGULUS_ENABLE_DEBUGGING 
    "Explicitly define debug mode, in the case that default flags are \
    not detected by some odd reason")

option(LANGULUS_FEATURE_NEWDELETE 
    "Overrides new/delete operators for anything statically linked to this library, \
    or provides LANGULUS_MONOPOLIZE_MEMORY() macro for you to use to override them, if dynamically linked. \
    This feature can be enabled only if LANGULUS_FEATURE_MANAGED_MEMORY is enabled")

option(LANGULUS_FEATURE_UTFCPP
    "Links to utfcpp library and provides UTF8, UTF16, UTF32 conversions")

option(LANGULUS_FEATURE_ZLIB
    "Links to zlib library and provides memory compression for use with any container of your liking")

option(LANGULUS_FEATURE_ENCRYPTION
    "Allows for memory encryption for use with any container of your liking")

option(LANGULUS_FEATURE_MANAGED_MEMORY
    "Memory will be pooled and recycled when freed, and you can safely push any kind of pointer, \
    as long as it was allocated by the memory manager, or by the overridden new/delete feature")

option(LANGULUS_FEATURE_MANAGED_REFLECTION
    "Reflections will be kept in a centralized location, when reflected, which speeds up \
    type comparisons, and allows you to dynamically modify the reflection at runtime. \
    This feature can be enabled only if LANGULUS_FEATURE_MANAGED_MEMORY is enabled")

option(LANGULUS_FEATURE_MEMORY_STATISTICS
    "Memory manager shall keep track of statistics, for the price of little overhead")

set(LANGULUS_ALIGNMENT 16 CACHE STRING "Default langulus alignment")
message(STATUS "[FEATURE] Alignment was set to ${LANGULUS_ALIGNMENT}")
add_compile_definitions(LANGULUS_ALIGNMENT=${LANGULUS_ALIGNMENT})

if(LANGULUS_ENABLE_SAFE_MODE)
	message(STATUS "[FEATURE] Safe mode enabled")
    add_compile_definitions(LANGULUS_ENABLE_SAFE_MODE)
endif()

if(LANGULUS_ENABLE_PARANOIA)
	message(STATUS "[FEATURE] Paranoid mode enabled")
    add_compile_definitions(LANGULUS_ENABLE_PARANOIA)
endif()

if(LANGULUS_FEATURE_NEWDELETE)
	message(STATUS "[FEATURE] New/Delete override")
    add_compile_definitions(LANGULUS_ENABLE_FEATURE_NEWDELETE)
endif()

if(LANGULUS_FEATURE_UTFCPP)
	message(STATUS "[FEATURE] UTFCPP unicode conversion enabled")
    add_compile_definitions(LANGULUS_ENABLE_FEATURE_UTFCPP)
endif()

if(LANGULUS_FEATURE_ZLIB)
    message(STATUS "[FEATURE] ZLIB compression enabled")
    add_compile_definitions(LANGULUS_ENABLE_FEATURE_ZLIB)
endif()

if(LANGULUS_FEATURE_ENCRYPTION)
    message(STATUS "[FEATURE] Encryption enabled")
    add_compile_definitions(LANGULUS_ENABLE_FEATURE_ENCRYPTION)
endif()

if(LANGULUS_ENABLE_DEBUGGING OR CMAKE_BUILD_TYPE STREQUAL "Debug")
    message(STATUS "[FEATURE] Debugging mode enabled")
    add_compile_definitions(LANGULUS_ENABLE_DEBUGGING)
endif()

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
	message(STATUS "[FEATURE] Debug mode, all assertions are enabled")
	add_compile_definitions(LANGULUS_ENABLE_SAFE_MODE)
	add_compile_definitions(LANGULUS_ENABLE_ASSERTION_LEVEL=1000)
    add_compile_definitions(LANGULUS_ENABLE_FEATURE_MEMORY_STATISTICS)
endif()

if(LANGULUS_FEATURE_MANAGED_MEMORY)
    message(STATUS "[FEATURE] Managed memory enabled")
    add_compile_definitions(LANGULUS_ENABLE_FEATURE_MANAGED_MEMORY)
endif()

if(LANGULUS_FEATURE_MANAGED_REFLECTION)
    message(STATUS "[FEATURE] Managed reflection enabled")
    add_compile_definitions(LANGULUS_ENABLE_FEATURE_MANAGED_REFLECTION)
endif()

if(LANGULUS_FEATURE_MEMORY_STATISTICS)
    message(STATUS "[FEATURE] Memory statistics enabled")
    add_compile_definitions(LANGULUS_ENABLE_FEATURE_MEMORY_STATISTICS)
endif()

endfunction()