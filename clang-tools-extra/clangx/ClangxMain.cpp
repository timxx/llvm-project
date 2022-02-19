#include "../clang-tidy/tool/ClangTidyMain.h"

#include <vector>

int clangdMain(int argc, const char **argv);

int main(int argc, const char **argv) {
  // since clang-tidy internal use GetCommandLineArguments (llvm::InitLLVM)
  // we can't remove our extra useless argument at all
  // so make clang-tidy as default
  if (argc >= 2 && strcmp(argv[1], "lsp") == 0) {
    std::vector<const char*> Argv;
    Argv.resize(argc - 1);
    Argv[0] = argv[0];
    for (int i = 2; i < argc; ++i)
        Argv[i - 1] = argv[i];
    return clangdMain(argc - 1, Argv.data());
  }

  return clang::tidy::clangTidyMain(argc, argv);
}
