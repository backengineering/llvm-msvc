add_entrypoint_object(
  socket
  SRCS
    socket.cpp
  HDRS
    ../socket.h
  DEPENDS
    libc.include.sys_syscall
    libc.include.sys_socket
    libc.src.__support.OSUtil.osutil
    libc.src.errno.errno
)

add_entrypoint_object(
  bind
  SRCS
    bind.cpp
  HDRS
    ../bind.h
  DEPENDS
    libc.include.sys_syscall
    libc.include.sys_socket
    libc.src.__support.OSUtil.osutil
    libc.src.errno.errno
)
