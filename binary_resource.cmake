if (NOT TARGET bin2c)
	add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/bin2c ${CMAKE_BINARY_DIR}/bin2c)
endif()

function(make_binary_resource)
	set(opts GZIP)
	set(val_args INPUT ARRAY_NAME OUTPUT)
	set(mval_args "")
	cmake_parse_arguments(BINRES "${opts}" "${val_args}" "${mval_args}" ${ARGN})


	if (NOT BINRES_INPUT)
		message(FATAL_ERROR "make_binary_resource: no input specified")
	endif()

	if (NOT BINRES_OUTPUT AND NOT BINRES_ARRAY_NAME)
		get_filename_component(in_basename "${BINRES_INPUT}" NAME_WE)
		set(BINRES_OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${in_basename}.c")
	endif()

	if (BINRES_OUTPUT AND NOT BINRES_ARRAY_NAME)
		get_filename_component(filename "${BINRES_OUTPUT}" NAME_WE)
		string(MAKE_C_IDENTIFIER ${filename} BINRES_ARRAY_NAME)
	elseif(NOT BINRES_OUTPUT AND BINRES_ARRAY_NAME)
		set(BINRES_OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${BINRES_ARRAY_NAME}.c")
	else()
		message(FATAL_ERROR "make_binary_resource: Unable to deduce output path and array name")
	endif()

	set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES "${BINRES_OUTPUT}")

	add_custom_command(
		OUTPUT "${BINRES_OUTPUT}"
		COMMAND $<TARGET_FILE:bin2c>
			-i "${BINRES_INPUT}"
			-a ${BINRES_ARRAY_NAME}
			-l 15
			-o ${BINRES_OUTPUT}
			DEPENDS bin2c ${BINRES_INPUT}
		COMMENT "Making binary resource for ${BINRES_ARRAY_NAME}"
		WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
	)
endfunction()
