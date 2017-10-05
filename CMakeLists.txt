cmake_minimum_required(VERSION 2.8)

set(QUANTUM_DEPTH 8)
set(HDRI NO)
set(TARGET_NAME Magick.NET-Q${QUANTUM_DEPTH}-x64.Native.dll)

if (${HDRI})
	set(HDRI_SUFFIX HDRI)
endif()

find_package(PkgConfig REQUIRED)
pkg_check_modules(IM MagickWand-7.Q${QUANTUM_DEPTH}${HDRI_SUFFIX} REQUIRED)
pkg_check_modules(JPEG libjpeg REQUIRED)

include_directories(. ${IM_INCLUDE_DIRS} ${JPEG_INCLUDE_DIRS})

add_definitions(-DMAGICK_NET_LINUX -DMAGICKCORE_QUANTUM_DEPTH=${QUANTUM_DEPTH} -DMAGICKCORE_HDRI_ENABLE=0)

add_library(${TARGET_NAME} SHARED
	./Colors/MagickColor.c
	./Colors/MagickColorCollection.c
	./Drawables/DrawingWand.c
	./Drawables/PointInfoCollection.c
	./Exceptions/MagickExceptionHelper.c
	./Helpers/Environment.c
	./Helpers/MagickMemory.c
	./MagickFormatInfo.c
	./MagickImage.c
	./MagickImageCollection.c
	./MagickNET.c
	./Matricis/DoubleMatrix.c
	./OpenCL/OpenCL.c
	./OpenCL/OpenCLDevice.c
	./OpenCL/OpenCLKernelProfileRecord.c
	./Optimizers/JpegOptimizer.c
	./Pixels/PixelCollection.c
	./Quantum.c
	./ResourceLimits.c
	./Settings/DrawingSettings.c
	./Settings/MagickSettings.c
	./Settings/MontageSettings.c
	./Settings/QuantizeSettings.c
	./Statistics/ChannelMoments.c
	./Statistics/ChannelPerceptualHash.c
	./Statistics/ChannelStatistics.c
	./Statistics/Moments.c
	./Statistics/PerceptualHash.c
	./Statistics/Statistics.c
	./Stdafx.c
	./Types/ConnectedComponent.c
	./Types/MagickGeometry.c
	./Types/MagickRectangle.c
	./Types/OffsetInfo.c
	./Types/PointInfo.c
	./Types/PrimaryInfo.c
	./Types/StringInfo.c
	./Types/TypeMetric.c)

set_target_properties(${TARGET_NAME} PROPERTIES LINK_FLAGS -Wl,--no-undefined)

target_link_libraries(${TARGET_NAME} ${IM_STATIC_LIBRARIES} pthread)
