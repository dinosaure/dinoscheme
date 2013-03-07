; ModuleID = 'identity'

define i32 @main() {
entry:
  %argument = alloca i32
  store i32 6, i32* %argument
  %0 = load i32* %argument
  %1 = call i32 @fa(i32 %0)
  ret i32 %1
}

define i32 @fa(i32 %y) {
entry:
  %0 = add i32 5, %y
  ret i32 %0
}
