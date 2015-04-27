#  Try to find ALPSCore. Depends on  Once done this will define
#  ALPSCore_FOUND         - System has ALPSCore
#  ALPSCore_LIBRARIES     - The ALPSCore libraries (imported targets)
#  ALPSCore_HAS_MPI       - True if ALPSCore is compiled with MPI enabled
#  ALPSCore_<c>_FOUND     - True if the requested component <c> is present
#  ALPSCore_<c>_LIBRARIES - The libraries (imported targets) for the component <c>

# FIXME: Is not affected by ALPSCore_LIBRARY variable

# Everything is hidden inside a function to avoid polluting the caller's scope
# This function sets in the parent scope:
#   ALPSCore_LIBRARIES 
#   ALPSCore_<c>_FOUND (for each component <c>) 
#   ALPSCore_<c>_LIBRARIES (for each component <c>) 
function(alpscore_config_main_)
    # Create a list of known components
    set(known_components_ utilities hdf5 accumulators params mc python)

    # if no components required - search for everything
    if (NOT ALPSCore_FIND_COMPONENTS)
        set(ALPSCore_FIND_COMPONENTS ${known_components_})
    endif()

    unset(ALPSCore_LIBRARIES)

    # check for each required component
    foreach(component_ ${ALPSCore_FIND_COMPONENTS})
        list(FIND known_components_ ${component_} component_idx_)
        if (component_idx_ EQUAL -1) 
            message(FATAL_ERROR "ALPSCore : Unknown component ${component_}")
        else()
            set(pkg_ alps-${component_})
            # message(STATUS "DEBUG: looking for ${pkg_} in ${CMAKE_CURRENT_LIST_DIR}/../..")
            if (ALPSCore_FIND_REQUIRED_${component_} AND ALPSCore_FIND_REQUIRED)
                set(be_required_ REQUIRED)
            else()
                unset(be_required_)
            endif()
            find_package(${pkg_} QUIET ${be_required_} NO_MODULE 
                PATHS ${CMAKE_CURRENT_LIST_DIR}/../.. 
                NO_DEFAULT_PATH)
            # message(STATUS "DEBUG: ${pkg_}_FOUND=${${pkg_}_FOUND}")
            if (${pkg_}_FOUND)
                set(ALPSCore_${component_}_FOUND true PARENT_SCOPE)
                set(ALPSCore_${component_}_LIBRARIES ${${pkg_}_LIBRARIES} PARENT_SCOPE)
                list(APPEND ALPSCore_LIBRARIES ${${pkg_}_LIBRARIES})
            endif()
            # message(STATUS "DEBUG: ALPSCore_LIBRARIES=${ALPSCore_LIBRARIES}")
        endif()
    endforeach()
    set(ALPSCore_LIBRARIES ${ALPSCore_LIBRARIES} PARENT_SCOPE)
endfunction(alpscore_config_main_)

alpscore_config_main_()
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ALPSCore REQUIRED_VARS ALPSCore_LIBRARIES HANDLE_COMPONENTS)


# # Definitions for compatibility
# set(ALPSCore_INCLUDE_DIR  ${ALPSCore_INCLUDES} )
# set(ALPSCore_INCLUDE_DIRS ${ALPSCore_INCLUDES} )
# set(ALPSCore_LIBRARY      ${ALPSCore_LIBRARIES})

# mark_as_advanced(
#     ALPSCore_INCLUDES
#     ALPSCore_INCLUDE_DIR
#     ALPSCore_INCLUDE_DIRS
#     ALPSCore_LIBRARIES
#     ALPSCore_LIBRARY
#     )
