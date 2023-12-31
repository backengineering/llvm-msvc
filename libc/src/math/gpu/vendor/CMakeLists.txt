find_package(AMDDeviceLibs QUIET HINTS ${CMAKE_INSTALL_PREFIX} PATHS /opt/rocm)
if(AMDDeviceLibs_FOUND)
  message(STATUS "Found the ROCm device library. Implementations falling back "
                 "to the vendor libraries will be resolved statically.")
  get_target_property(ocml_path ocml IMPORTED_LOCATION)
  list(APPEND bitcode_link_flags
       "SHELL:-Xclang -mlink-builtin-bitcode -Xclang ${ocml_path}")
else()
  message(STATUS "Could not find the ROCm device library. Unimplemented "
                 "functions will be an external reference to the vendor libraries.")
endif()

find_package(CUDAToolkit QUIET)
if(CUDAToolkit_FOUND)
  set(libdevice_path ${CUDAToolkit_BIN_DIR}/../nvvm/libdevice/libdevice.10.bc)
  if (EXISTS ${libdevice_path})
    message(STATUS "Found the CUDA device library. Implementations falling back "
                   "to the vendor libraries will be resolved statically.")
    list(APPEND bitcode_link_flags
         "SHELL:-Xclang -mlink-builtin-bitcode -Xclang ${libdevice_path}")
  endif()
else()
  message(STATUS "Could not find the CUDA device library. Unimplemented "
                 "functions will be an external reference to the vendor libraries.")
endif()

# FIXME: We need a way to pass the library to only the NVTPX / AMDGPU build.
# This shouldn't cause issues because we only link in needed symbols, but it
# will link in identity metadata from both libraries. This silences the warning.
list(APPEND bitcode_link_flags "-Wno-linker-warnings")

add_entrypoint_object(
  acos
  SRCS
    acos.cpp
  HDRS
    ../../acos.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  acosf
  SRCS
    acosf.cpp
  HDRS
    ../../acosf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  acosh
  SRCS
    acosh.cpp
  HDRS
    ../../acosh.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  acoshf
  SRCS
    acoshf.cpp
  HDRS
    ../../acoshf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  asin
  SRCS
    asin.cpp
  HDRS
    ../../asin.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  asinf
  SRCS
    asinf.cpp
  HDRS
    ../../asinf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  asinh
  SRCS
    asinh.cpp
  HDRS
    ../../asinh.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  atan
  SRCS
    atan.cpp
  HDRS
    ../../atan.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  atanf
  SRCS
    atanf.cpp
  HDRS
    ../../atanf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  atan2
  SRCS
    atan2.cpp
  HDRS
    ../../atan2.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  atan2f
  SRCS
    atan2f.cpp
  HDRS
    ../../atan2f.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  atanh
  SRCS
    atanh.cpp
  HDRS
    ../../atanh.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  atanhf
  SRCS
    atanhf.cpp
  HDRS
    ../../atanhf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  cos
  SRCS
    cos.cpp
  HDRS
    ../../cos.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  cosf
  SRCS
    cosf.cpp
  HDRS
    ../../cosf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  cosh
  SRCS
    cosh.cpp
  HDRS
    ../../cosh.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  coshf
  SRCS
    coshf.cpp
  HDRS
    ../../coshf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  erf
  SRCS
    erf.cpp
  HDRS
    ../../erf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  erff
  SRCS
    erff.cpp
  HDRS
    ../../erff.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  exp
  SRCS
    exp.cpp
  HDRS
    ../../exp.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  exp10
  SRCS
    exp10.cpp
  HDRS
    ../../exp10.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  exp10f
  SRCS
    exp10f.cpp
  HDRS
    ../../exp10f.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  exp2
  SRCS
    exp2.cpp
  HDRS
    ../../exp2.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  exp2f
  SRCS
    exp2f.cpp
  HDRS
    ../../exp2f.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  expf
  SRCS
    expf.cpp
  HDRS
    ../../expf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  expm1
  SRCS
    expm1.cpp
  HDRS
    ../../expm1.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  expm1f
  SRCS
    expm1f.cpp
  HDRS
    ../../expm1f.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  fdim
  SRCS
    fdim.cpp
  HDRS
    ../../fdim.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  fdimf
  SRCS
    fdimf.cpp
  HDRS
    ../../fdimf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  hypot
  SRCS
    hypot.cpp
  HDRS
    ../../hypot.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  hypotf
  SRCS
    hypotf.cpp
  HDRS
    ../../hypotf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  ilogb
  SRCS
    ilogb.cpp
  HDRS
    ../../ilogb.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  ilogbf
  SRCS
    ilogbf.cpp
  HDRS
    ../../ilogbf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  log10
  SRCS
    log10.cpp
  HDRS
    ../../log10.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  log10f
  SRCS
    log10f.cpp
  HDRS
    ../../log10f.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  log2
  SRCS
    log2.cpp
  HDRS
    ../../log2.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  log2f
  SRCS
    log2f.cpp
  HDRS
    ../../log2f.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  log
  SRCS
    log.cpp
  HDRS
    ../../log.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  logf
  SRCS
    logf.cpp
  HDRS
    ../../logf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  lrint
  SRCS
    lrint.cpp
  HDRS
    ../../lrint.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  lrintf
  SRCS
    lrintf.cpp
  HDRS
    ../../lrintf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  ldexp
  SRCS
    ldexp.cpp
  HDRS
    ../../ldexp.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  ldexpf
  SRCS
    ldexpf.cpp
  HDRS
    ../../ldexpf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  log1p
  SRCS
    log1p.cpp
  HDRS
    ../../log1p.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  log1pf
  SRCS
    log1pf.cpp
  HDRS
    ../../log1pf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  llrint
  SRCS
    llrint.cpp
  HDRS
    ../../llrint.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  llrintf
  SRCS
    llrintf.cpp
  HDRS
    ../../llrintf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  remquo
  SRCS
    remquo.cpp
  HDRS
    ../../remquo.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  remquof
  SRCS
    remquof.cpp
  HDRS
    ../../remquof.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  scalbn
  SRCS
    scalbn.cpp
  HDRS
    ../../scalbn.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  scalbnf
  SRCS
    scalbnf.cpp
  HDRS
    ../../scalbnf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)


add_entrypoint_object(
  nextafter
  SRCS
    nextafter.cpp
  HDRS
    ../../nextafter.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  nextafterf
  SRCS
    nextafterf.cpp
  HDRS
    ../../nextafterf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  pow
  SRCS
    pow.cpp
  HDRS
    ../../pow.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  powf
  SRCS
    powf.cpp
  HDRS
    ../../powf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  sin
  SRCS
    sin.cpp
  HDRS
    ../../sin.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  sinf
  SRCS
    sinf.cpp
  HDRS
    ../../sinf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  sincos
  SRCS
    sincos.cpp
  HDRS
    ../../sincos.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  sincosf
  SRCS
    sincosf.cpp
  HDRS
    ../../sincosf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  sinh
  SRCS
    sinh.cpp
  HDRS
    ../../sinh.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  sinhf
  SRCS
    sinhf.cpp
  HDRS
    ../../sinhf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  tan
  SRCS
    tan.cpp
  HDRS
    ../../tan.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  tanf
  SRCS
    tanf.cpp
  HDRS
    ../../tanf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  tanh
  SRCS
    tanh.cpp
  HDRS
    ../../tanh.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  tanhf
  SRCS
    tanhf.cpp
  HDRS
    ../../tanhf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  tgamma
  SRCS
    tgamma.cpp
  HDRS
    ../../tgamma.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  tgammaf
  SRCS
    tgammaf.cpp
  HDRS
    ../../tgammaf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  frexp
  SRCS
    frexp.cpp
  HDRS
    ../../frexp.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)

add_entrypoint_object(
  frexpf
  SRCS
    frexpf.cpp
  HDRS
    ../../frexpf.h
  COMPILE_OPTIONS
    ${bitcode_link_flags}
    -O2
)
