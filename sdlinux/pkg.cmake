# Package builder

function(add_package PACKAGE_NAME PACKAGE_VERSION)
	set(PACKAGE_SOURCE_DIR ${PROJECT_SOURCE_DIR}/packages/${PACKAGE_NAME})
	set(PACKAGE_BINARY_DIR ${PROJECT_BINARY_DIR}/packages/${PACKAGE_NAME})
	set(INITRD ${PROJECT_BINARY_DIR}/initrd)
	set(BUILDFS ${PROJECT_BINARY_DIR}/buildfs)
	set(ROOTFS ${PROJECT_BINARY_DIR}/rootfs)
	configure_file("${PACKAGE_SOURCE_DIR}/build.sh.in" "${PROJECT_BINARY_DIR}/${PACKAGE_NAME}.pkg.sh" @ONLY)
	execute_process(COMMAND mkdir -p ${PACKAGE_BINARY_DIR} ${INITRD} ${BUILDFS} ${ROOTFS})
	if(PACKAGE_OUTPUT)
		add_custom_command(OUTPUT ${PACKAGE_OUTPUT}
			COMMAND "${PROJECT_BINARY_DIR}/${PACKAGE_NAME}.pkg.sh"
			WORKING_DIRECTORY ${PACKAGE_SOURCE_DIR}
			DEPENDS ${PACKAGE_DEPENDS}
			COMMENT "Building package ${PACKAGE_NAME} (v${PACKAGE_VERSION})")
		add_custom_target(sdlinux-${PACKAGE_NAME} ALL DEPENDS ${PACKAGE_DEPENDS} ${PACKAGE_OUTPUT})
	else()
		add_custom_target(sdlinux-${PACKAGE_NAME} ALL
			COMMAND "${PROJECT_BINARY_DIR}/${PACKAGE_NAME}.pkg.sh"
			DEPENDS ${PACKAGE_DEPENDS}
			WORKING_DIRECTORY ${PACKAGE_SOURCE_DIR}
			COMMENT "Building package ${PACKAGE_NAME} (v${PACKAGE_VERSION})")
	endif()
endfunction()
