set(fox_sax_srcs
  FoX_sax.f90
)

set(fox_sax_srcs_pp
  m_sax_operate.F90
  m_sax_parser.F90
  m_sax_reader.F90
  m_sax_tokenizer.F90
  m_sax_types.F90
  m_sax_xml_source.F90
)


add_library(
  ${PROJECT_NAME}_sax STATIC
  ${fox_sax_srcs}
  ${fox_sax_srcs_pp}
)

target_link_libraries(
  ${PROJECT_NAME}_sax
  ${PROJECT_NAME}_common
  ${PROJECT_NAME}_utils
  ${PROJECT_NAME}_fsys
)

install(TARGETS ${PROJECT_NAME}_sax
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
  DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
  FILES_MATCHING PATTERN "*.mod"
)
