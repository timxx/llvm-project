add_clang_tool(clangx
  ClangxMain.cpp
  ../clangd/tool/ClangdMain.cpp
  ../clangd/tool/Check.cpp
  )

add_definitions(
  -DBUILD_CLANGX
  )

include_directories(
  ../clangd
  )

target_link_libraries(clangx
  PRIVATE
  clangTidyMain

  clangDaemon
  clangdRemoteIndex
  clangdSupport
  )
