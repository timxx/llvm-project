//===--- UniquePtrArrayMismatchCheck.cpp - clang-tidy ---------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "UniquePtrArrayMismatchCheck.h"

using namespace clang::ast_matchers;

namespace clang {
namespace tidy {
namespace bugprone {

UniquePtrArrayMismatchCheck::UniquePtrArrayMismatchCheck(
    StringRef Name, ClangTidyContext *Context)
    : SmartPtrArrayMismatchCheck(Name, Context, "unique") {}

UniquePtrArrayMismatchCheck::SmartPtrClassMatcher
UniquePtrArrayMismatchCheck::getSmartPointerClassMatcher() const {
  return classTemplateSpecializationDecl(
      hasName("::std::unique_ptr"), templateArgumentCountIs(2),
      hasTemplateArgument(
          0, templateArgument(refersToType(qualType().bind(PointerTypeN)))),
      hasTemplateArgument(
          1,
          templateArgument(refersToType(
              qualType(hasDeclaration(classTemplateSpecializationDecl(
                  hasName("::std::default_delete"), templateArgumentCountIs(1),
                  hasTemplateArgument(
                      0, templateArgument(refersToType(
                             qualType(equalsBoundNode(PointerTypeN))))))))))));
}

} // namespace bugprone
} // namespace tidy
} // namespace clang
