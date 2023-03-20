project( PatchManIRPass C CXX ASM_MASM)

include_directories(${CMAKE_SOURCE_DIR}/../PatchMan/src/PatchManIRPass)


set( SOURCE 

PatchManIRPass.h
PatchManIRPass.cpp

)

add_library(${PROJECT_NAME} STATIC ${SOURCE} )

#CXX 17
target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_17)
