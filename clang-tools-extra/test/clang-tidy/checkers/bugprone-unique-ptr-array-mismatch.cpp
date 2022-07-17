// RUN: %check_clang_tidy %s bugprone-unique-ptr-array-mismatch %t

namespace std {

template <typename T>
class default_delete {}; // NOLINT

template <typename T, typename Deleter = std::default_delete<T>>
class unique_ptr { // NOLINT
public:
  explicit unique_ptr(T *) {}
  unique_ptr(const unique_ptr<T> &) = delete;
};

template <typename T, typename Deleter>
class unique_ptr<T[], Deleter> {
public:
  template <typename U, class D = Deleter>
  explicit unique_ptr(U *) {}
};

} // namespace std

void f1() {
  std::unique_ptr<char> P1(new char[10]);
  // CHECK-MESSAGES: :[[@LINE-1]]:28: warning: unique pointer to non-array is initialized with array [bugprone-unique-ptr-array-mismatch]
  std::unique_ptr<char[]> P2(new char[10]);

  using byte = char;
  std::unique_ptr<byte> P3(new byte[10]);
  // CHECK-MESSAGES: :[[@LINE-1]]:28: warning: unique pointer to non-array is initialized with array [bugprone-unique-ptr-array-mismatch]
}