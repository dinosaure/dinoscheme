; ModuleID = 'identity'

define i32 @main() {
entry:
  %envr = alloca [0 x i32]
  %malloccall = tail call i8* @malloc(i32 trunc (i64 mul nuw (i64 ptrtoint (i32* getelementptr (i32* null, i32 1) to i64), i64 2) to i32))
  %envr1 = bitcast i8* %malloccall to [2 x i32]*
  %envp = inttoptr [0 x i32]* %envr to [1 x i32]*
  %malloccall2 = tail call i8* @malloc(i32 ptrtoint ({ i32 (i32, i32)*, i32 }* getelementptr ({ i32 (i32, i32)*, i32 }* null, i32 1) to i32))
  %clos = bitcast i8* %malloccall2 to { i32 (i32, i32)*, i32 }*
  %0 = getelementptr inbounds { i32 (i32, i32)*, i32 }* %clos, i32 0, i32 0
  store i32 (i32, i32)* @fa, i32 (i32, i32)** %0
  %1 = getelementptr inbounds { i32 (i32, i32)*, i32 }* %clos, i32 0, i32 1
  %2 = ptrtoint [2 x i32]* %envr1 to i32
  store i32 %2, i32* %1
  %3 = getelementptr [2 x i32]* %envr1, i32 0, i32 1
  %4 = getelementptr [1 x i32]* %envp, i32 0, i32 0
  %5 = load i32* %4
  store i32 %5, i32* %3
  %6 = getelementptr [1 x i32]* %envp, i32 0, i32 0
  %7 = ptrtoint { i32 (i32, i32)*, i32 }* %clos to i32
  %clop = inttoptr i32 %7 to { i32 (i32, i32)*, i32 }*
  %8 = getelementptr inbounds { i32 (i32, i32)*, i32 }* %clop, i32 0, i32 1
  %9 = load i32* %8
  %10 = getelementptr inbounds { i32 (i32, i32)*, i32 }* %clop, i32 0, i32 0
  %11 = load i32 (i32, i32)** %10
  %12 = call i32 %11(i32 42, i32 %9)
  %clop3 = inttoptr i32 %12 to { i32 (i32, i32)*, i32 }*
  %13 = getelementptr inbounds { i32 (i32, i32)*, i32 }* %clop3, i32 0, i32 1
  %14 = load i32* %13
  %15 = getelementptr inbounds { i32 (i32, i32)*, i32 }* %clop3, i32 0, i32 0
  %16 = load i32 (i32, i32)** %15
  %17 = call i32 %16(i32 21, i32 %14)
  ret i32 %17
}

define i32 @fa(i32 %x, i32 %e) {
entry:
  %malloccall = tail call i8* @malloc(i32 trunc (i64 mul nuw (i64 ptrtoint (i32* getelementptr (i32* null, i32 1) to i64), i64 3) to i32))
  %envr = bitcast i8* %malloccall to [3 x i32]*
  %envp = inttoptr i32 %e to [2 x i32]*
  %malloccall1 = tail call i8* @malloc(i32 ptrtoint ({ i32 (i32, i32)*, i32 }* getelementptr ({ i32 (i32, i32)*, i32 }* null, i32 1) to i32))
  %clos = bitcast i8* %malloccall1 to { i32 (i32, i32)*, i32 }*
  %0 = getelementptr inbounds { i32 (i32, i32)*, i32 }* %clos, i32 0, i32 0
  store i32 (i32, i32)* @fb, i32 (i32, i32)** %0
  %1 = getelementptr inbounds { i32 (i32, i32)*, i32 }* %clos, i32 0, i32 1
  %2 = ptrtoint [3 x i32]* %envr to i32
  store i32 %2, i32* %1
  %3 = getelementptr [3 x i32]* %envr, i32 0, i32 2
  %4 = getelementptr [2 x i32]* %envp, i32 0, i32 1
  %5 = load i32* %4
  store i32 %5, i32* %3
  %6 = getelementptr [3 x i32]* %envr, i32 0, i32 1
  %7 = getelementptr [2 x i32]* %envp, i32 0, i32 0
  %8 = load i32* %7
  store i32 %8, i32* %6
  %9 = getelementptr [2 x i32]* %envp, i32 0, i32 0
  %10 = ptrtoint { i32 (i32, i32)*, i32 }* %clos to i32
  ret i32 %10
}

define i32 @fb(i32 %x, i32 %e) {
entry:
  %0 = inttoptr i32 %e to [3 x i32]*
  %1 = getelementptr [3 x i32]* %0, i32 0, i32 1
  %2 = load i32* %1
  ret i32 %2
}

declare noalias i8* @malloc(i32)
