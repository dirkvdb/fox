module m_common_struct

  ! Common parts of an XML document. Shared by both SAX & WXML.

  use m_common_charset, only: XML1_0, XML1_1
  use m_common_entities, only: entity_list, init_entity_list, destroy_entity_list, &
    add_internal_entity, add_external_entity
  use m_common_element, only: element_list, init_element_list, destroy_element_list
  use m_common_notations, only: notation_list, init_notation_list, destroy_notation_list

  implicit none
  private

  type xml_doc_state
    logical :: building = .false. ! Are we in the middle of building this doc?
    integer :: xml_version = XML1_0
    logical :: standalone_declared = .false.
    logical :: standalone = .false.
    type(entity_list) :: entityList
    type(entity_list) :: PEList
    type(notation_list) :: nList
    type(element_list) :: element_list
    logical :: warning = .false. ! Do we care about warnings?
    logical :: valid = .true. ! Do we care about validity?
    logical :: liveNodeLists = .true. ! Do we want live nodelists?
    character, pointer :: encoding(:) => null()
    character, pointer :: inputEncoding(:) => null()
  end type xml_doc_state

  public :: xml_doc_state
  
  public :: init_xml_doc_state
  public :: destroy_xml_doc_state
  
  public :: register_internal_PE
  public :: register_external_PE
  public :: register_internal_GE
  public :: register_external_GE

contains
  
  subroutine init_xml_doc_state(xds)
    type(xml_doc_state), intent(inout) :: xds
    call init_entity_list(xds%entityList)
    call init_entity_list(xds%PEList)
    call init_notation_list(xds%nList)
    call init_element_list(xds%element_list)
    allocate(xds%inputEncoding(0))
  end subroutine init_xml_doc_state

  subroutine destroy_xml_doc_state(xds)
    type(xml_doc_state), intent(inout) :: xds
    call destroy_entity_list(xds%entityList)
    call destroy_entity_list(xds%PEList)
    call destroy_notation_list(xds%nList)
    call destroy_element_list(xds%element_list)
    if (associated(xds%encoding)) deallocate(xds%encoding)
    if (associated(xds%inputEncoding)) deallocate(xds%inputEncoding)
  end subroutine destroy_xml_doc_state

  subroutine register_internal_PE(xds, name, value)
    type(xml_doc_state), intent(inout) :: xds
    character(len=*), intent(in) :: name
    character(len=*), intent(in) :: value

    call add_internal_entity(xds%PEList, name, value)

  end subroutine register_internal_PE

  subroutine register_external_PE(xds, name, system, public)
    type(xml_doc_state), intent(inout) :: xds
    character(len=*), intent(in) :: name
    character(len=*), intent(in) :: system
    character(len=*), intent(in), optional :: public

    call add_external_entity(xds%PEList, name, system, public)
  end subroutine register_external_PE

  subroutine register_internal_GE(xds, name, value)
    type(xml_doc_state), intent(inout) :: xds
    character(len=*), intent(in) :: name
    character(len=*), intent(in) :: value

    call add_internal_entity(xds%entityList, name, value)

  end subroutine register_internal_GE

  subroutine register_external_GE(xds, name, system, public, notation)
    type(xml_doc_state), intent(inout) :: xds
    character(len=*), intent(in) :: name
    character(len=*), intent(in) :: system
    character(len=*), intent(in), optional :: public
    character(len=*), intent(in), optional :: notation

    call add_external_entity(xds%entityList, name, system, public, notation)
  end subroutine register_external_GE

end module m_common_struct
