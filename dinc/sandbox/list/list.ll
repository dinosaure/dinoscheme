; ModuleID = 'list.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.list = type { i32, %struct.list* }

define i32 @main() nounwind {
  %1 = alloca i32, align 4
  %l = alloca %struct.list, align 8
  store i32 0, i32* %1
  %2 = getelementptr inbounds %struct.list* %l, i32 0, i32 0
  store i32 5, i32* %2, align 4
  %3 = getelementptr inbounds %struct.list* %l, i32 0, i32 1
  store %struct.list* null, %struct.list** %3, align 8
  ret i32 0
}
