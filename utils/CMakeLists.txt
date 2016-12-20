set(fox_utils_srcs
  FoX_utils.f90
)

set(fox_utils_srcs_pp
  fox_m_utils_mtprng.F90
  fox_m_utils_uri.F90
  fox_m_utils_uuid.F90
)

add_library(
  ${PROJECT_NAME}_utils STATIC
  ${fox_utils_srcs}
  ${fox_utils_srcs_pp}
)

target_link_libraries(
  ${PROJECT_NAME}_utils
  ${PROJECT_NAME}_fsys
)

install(TARGETS ${PROJECT_NAME}_utils
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
  DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
  FILES_MATCHING PATTERN "*.mod"
)