; ModuleID = 'fatptr.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._e = type { i32, i32* }
%struct._c = type { i32 (%struct._e*)*, %struct._e* }

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

define i32 @f(%struct._e* %env) nounwind {
  %1 = alloca %struct._e*, align 8
  store %struct._e* %env, %struct._e** %1, align 8
  %2 = load %struct._e** %1, align 8
  %3 = getelementptr inbounds %struct._e* %2, i32 0, i32 1
  %4 = load i32** %3, align 8
  %5 = getelementptr inbounds i32* %4, i64 1
  %6 = load i32* %5, align 4
  ret i32 %6
}

define i32 @k(%struct._e* %env) nounwind {
  %1 = alloca %struct._e*, align 8
  %new = alloca %struct._e*, align 8
  %clo = alloca %struct._c*, align 8
  store %struct._e* %env, %struct._e** %1, align 8
  %2 = call i8* @malloc(i64 16)
  %3 = bitcast i8* %2 to %struct._e*
  store %struct._e* %3, %struct._e** %new, align 8
  %4 = load %struct._e** %1, align 8
  %5 = getelementptr inbounds %struct._e* %4, i32 0, i32 0
  %6 = load i32* %5, align 4
  %7 = add nsw i32 %6, 1
  %8 = load %struct._e** %new, align 8
  %9 = getelementptr inbounds %struct._e* %8, i32 0, i32 0
  store i32 %7, i32* %9, align 4
  %10 = load %struct._e** %new, align 8
  %11 = getelementptr inbounds %struct._e* %10, i32 0, i32 0
  %12 = load i32* %11, align 4
  %13 = sext i32 %12 to i64
  %14 = mul i64 4, %13
  %15 = call i8* @malloc(i64 %14)
  %16 = bitcast i8* %15 to i32*
  %17 = load %struct._e** %new, align 8
  %18 = getelementptr inbounds %struct._e* %17, i32 0, i32 1
  store i32* %16, i32** %18, align 8
  %19 = load %struct._e** %new, align 8
  %20 = getelementptr inbounds %struct._e* %19, i32 0, i32 1
  %21 = load i32** %20, align 8
  %22 = getelementptr inbounds i32* %21, i64 0
  store i32 6, i32* %22, align 4
  %23 = load %struct._e** %1, align 8
  %24 = getelementptr inbounds %struct._e* %23, i32 0, i32 1
  %25 = load i32** %24, align 8
  %26 = getelementptr inbounds i32* %25, i64 0
  %27 = load i32* %26, align 4
  %28 = load %struct._e** %new, align 8
  %29 = getelementptr inbounds %struct._e* %28, i32 0, i32 1
  %30 = load i32** %29, align 8
  %31 = getelementptr inbounds i32* %30, i64 1
  store i32 %27, i32* %31, align 4
  %32 = call i8* @malloc(i64 16)
  %33 = bitcast i8* %32 to %struct._c*
  store %struct._c* %33, %struct._c** %clo, align 8
  %34 = load %struct._e** %new, align 8
  %35 = load %struct._c** %clo, align 8
  %36 = getelementptr inbounds %struct._c* %35, i32 0, i32 1
  store %struct._e* %34, %struct._e** %36, align 8
  %37 = load %struct._c** %clo, align 8
  %38 = getelementptr inbounds %struct._c* %37, i32 0, i32 0
  store i32 (%struct._e*)* @f, i32 (%struct._e*)** %38, align 8
  %39 = load %struct._c** %clo, align 8
  %40 = ptrtoint %struct._c* %39 to i32
  ret i32 %40
}

declare i8* @malloc(i64)

define i32 @main() nounwind {
  %1 = alloca i32, align 4
  %env = alloca %struct._e*, align 8
  %clo = alloca %struct._c*, align 8
  store i32 0, i32* %1
  %2 = call i8* @malloc(i64 16)
  %3 = bitcast i8* %2 to %struct._e*
  store %struct._e* %3, %struct._e** %env, align 8
  %4 = load %struct._e** %env, align 8
  %5 = getelementptr inbounds %struct._e* %4, i32 0, i32 0
  store i32 1, i32* %5, align 4
  %6 = load %struct._e** %env, align 8
  %7 = getelementptr inbounds %struct._e* %6, i32 0, i32 0
  %8 = load i32* %7, align 4
  %9 = sext i32 %8 to i64
  %10 = mul i64 4, %9
  %11 = call i8* @malloc(i64 %10)
  %12 = bitcast i8* %11 to i32*
  %13 = load %struct._e** %env, align 8
  %14 = getelementptr inbounds %struct._e* %13, i32 0, i32 1
  store i32* %12, i32** %14, align 8
  %15 = load %struct._e** %env, align 8
  %16 = getelementptr inbounds %struct._e* %15, i32 0, i32 1
  %17 = load i32** %16, align 8
  %18 = getelementptr inbounds i32* %17, i64 0
  store i32 5, i32* %18, align 4
  %19 = load %struct._e** %env, align 8
  %20 = call i32 @k(%struct._e* %19)
  %21 = sext i32 %20 to i64
  %22 = inttoptr i64 %21 to %struct._c*
  store %struct._c* %22, %struct._c** %clo, align 8
  %23 = load %struct._c** %clo, align 8
  %24 = getelementptr inbounds %struct._c* %23, i32 0, i32 0
  %25 = load i32 (%struct._e*)** %24, align 8
  %26 = load %struct._c** %clo, align 8
  %27 = getelementptr inbounds %struct._c* %26, i32 0, i32 1
  %28 = load %struct._e** %27, align 8
  %29 = call i32 %25(%struct._e* %28)
  %30 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %29)
  ret i32 0
}

declare i32 @printf(i8*, ...)
