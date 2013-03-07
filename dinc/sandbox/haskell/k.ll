target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-linux-gnu"
declare  ccc i8* @memcpy(i8*, i8*, i64)
declare  ccc i8* @memmove(i8*, i8*, i64)
declare  ccc i8* @memset(i8*, i64, i64)
declare  ccc i64 @newSpark(i8*, i8*)
%__stginit_Main_struct = type <{}>
@__stginit_Main =  global %__stginit_Main_struct<{}>
%srY_closure_struct = type <{i64, i64}>
@srY_closure = internal global %srY_closure_struct<{i64 ptrtoint ([0 x i64]* @integerzmgmp_GHCziIntegerziType_Szh_static_info to i64), i64 42}>
@integerzmgmp_GHCziIntegerziType_Szh_static_info = external global [0 x i64]
%srZ_srt_struct = type <{i64, i64}>
@srZ_srt = internal constant %srZ_srt_struct<{i64 ptrtoint ([0 x i64]* @base_SystemziIO_print_closure to i64), i64 ptrtoint ([0 x i64]* @base_GHCziShow_zdfShowInteger_closure to i64)}>
@base_SystemziIO_print_closure = external global [0 x i64]
@base_GHCziShow_zdfShowInteger_closure = external global [0 x i64]
%srZ_closure_struct = type <{i64, i64, i64, i64}>
@srZ_closure = internal global %srZ_closure_struct<{i64 ptrtoint (void (i64*, i64*, i64*, i64, i64, i64, i64, i64, i64, i64, float, float, float, float, double, double)* @srZ_info to i64), i64 0, i64 0, i64 0}>
%Main_main_srt_struct = type <{i64, i64, i64}>
@Main_main_srt = internal constant %Main_main_srt_struct<{i64 ptrtoint ([0 x i64]* @base_GHCziBase_zd_closure to i64), i64 ptrtoint (%srY_closure_struct* @srY_closure to i64), i64 ptrtoint (%srZ_closure_struct* @srZ_closure to i64)}>
@base_GHCziBase_zd_closure = external global [0 x i64]
%Main_main_closure_struct = type <{i64, i64, i64, i64}>
@Main_main_closure =  global %Main_main_closure_struct<{i64 ptrtoint (void (i64*, i64*, i64*, i64, i64, i64, i64, i64, i64, i64, float, float, float, float, double, double)* @Main_main_info to i64), i64 0, i64 0, i64 0}>
%ZCMain_main_srt_struct = type <{i64, i64}>
@ZCMain_main_srt = internal constant %ZCMain_main_srt_struct<{i64 ptrtoint ([0 x i64]* @base_GHCziTopHandler_runMainIO_closure to i64), i64 ptrtoint (%Main_main_closure_struct* @Main_main_closure to i64)}>
@base_GHCziTopHandler_runMainIO_closure = external global [0 x i64]
%ZCMain_main_closure_struct = type <{i64, i64, i64, i64}>
@ZCMain_main_closure =  global %ZCMain_main_closure_struct<{i64 ptrtoint (void (i64*, i64*, i64*, i64, i64, i64, i64, i64, i64, i64, float, float, float, float, double, double)* @ZCMain_main_info to i64), i64 0, i64 0, i64 0}>
%srZ_info_struct = type <{i64, i64, i64}>
@srZ_info_itable = internal constant %srZ_info_struct<{i64 add (i64 sub (i64 ptrtoint (%srZ_srt_struct* @srZ_srt to i64),i64 ptrtoint (void (i64*, i64*, i64*, i64, i64, i64, i64, i64, i64, i64, float, float, float, float, double, double)* @srZ_info to i64)),i64 0), i64 0, i64 12884901910}>, section "X98A__STRIP,__me1", align 8
define internal cc 10 void @srZ_info(i64* noalias nocapture %Base_Arg, i64* noalias nocapture %Sp_Arg, i64* noalias nocapture %Hp_Arg, i64 %R1_Arg, i64 %R2_Arg, i64 %R3_Arg, i64 %R4_Arg, i64 %R5_Arg, i64 %R6_Arg, i64 %SpLim_Arg, float %F1_Arg, float %F2_Arg, float %F3_Arg, float %F4_Arg, double %D1_Arg, double %D2_Arg) align 8 nounwind section "X98A__STRIP,__me2"
{
ctZ:
%Base_Var = alloca i64*, i32 1
store i64* %Base_Arg, i64** %Base_Var
%Sp_Var = alloca i64*, i32 1
store i64* %Sp_Arg, i64** %Sp_Var
%Hp_Var = alloca i64*, i32 1
store i64* %Hp_Arg, i64** %Hp_Var
%R1_Var = alloca i64, i32 1
store i64 %R1_Arg, i64* %R1_Var
%R2_Var = alloca i64, i32 1
store i64 %R2_Arg, i64* %R2_Var
%R3_Var = alloca i64, i32 1
store i64 %R3_Arg, i64* %R3_Var
%R4_Var = alloca i64, i32 1
store i64 %R4_Arg, i64* %R4_Var
%R5_Var = alloca i64, i32 1
store i64 %R5_Arg, i64* %R5_Var
%R6_Var = alloca i64, i32 1
store i64 %R6_Arg, i64* %R6_Var
%SpLim_Var = alloca i64, i32 1
store i64 %SpLim_Arg, i64* %SpLim_Var
%F1_Var = alloca float, i32 1
store float %F1_Arg, float* %F1_Var
%F2_Var = alloca float, i32 1
store float %F2_Arg, float* %F2_Var
%F3_Var = alloca float, i32 1
store float %F3_Arg, float* %F3_Var
%F4_Var = alloca float, i32 1
store float %F4_Arg, float* %F4_Var
%D1_Var = alloca double, i32 1
store double %D1_Arg, double* %D1_Var
%D2_Var = alloca double, i32 1
store double %D2_Arg, double* %D2_Var
%lcsF = alloca i64, i32 1
%lnu0 = load i64** %Sp_Var
%lnu1 = getelementptr inbounds i64* %lnu0, i32 -2
%lnu2 = ptrtoint i64* %lnu1 to i64
%lnu3 = load i64* %SpLim_Var
%lnu4 = icmp ult i64 %lnu2, %lnu3
br i1 %lnu4, label %cu6, label %nu7
nu7:
%lnu8 = load i64** %Hp_Var
%lnu9 = getelementptr inbounds i64* %lnu8, i32 2
%lnua = ptrtoint i64* %lnu9 to i64
%lnub = inttoptr i64 %lnua to i64*
store i64* %lnub, i64** %Hp_Var
%lnuc = load i64** %Hp_Var
%lnud = ptrtoint i64* %lnuc to i64
%lnue = load i64** %Base_Var
%lnuf = getelementptr inbounds i64* %lnue, i32 18
%lnug = bitcast i64* %lnuf to i64*
%lnuh = load i64* %lnug
%lnui = icmp ugt i64 %lnud, %lnuh
br i1 %lnui, label %cuk, label %nul
nul:
%lnum = ptrtoint [0 x i64]* @stg_CAF_BLACKHOLE_info to i64
%lnun = load i64** %Hp_Var
%lnuo = getelementptr inbounds i64* %lnun, i32 -1
store i64 %lnum, i64* %lnuo
%lnup = load i64** %Base_Var
%lnuq = getelementptr inbounds i64* %lnup, i32 20
%lnur = bitcast i64* %lnuq to i64*
%lnus = load i64* %lnur
%lnut = load i64** %Hp_Var
%lnuu = getelementptr inbounds i64* %lnut, i32 0
store i64 %lnus, i64* %lnuu
%lnuv = load i64** %Base_Var
%lnuw = ptrtoint i64* %lnuv to i64
%lnux = inttoptr i64 %lnuw to i8*
%lnuy = load i64* %R1_Var
%lnuz = inttoptr i64 %lnuy to i8*
%lnuA = load i64** %Hp_Var
%lnuB = getelementptr inbounds i64* %lnuA, i32 -1
%lnuC = ptrtoint i64* %lnuB to i64
%lnuD = inttoptr i64 %lnuC to i8*
store i64 undef, i64* %R3_Var
store i64 undef, i64* %R4_Var
store i64 undef, i64* %R5_Var
store i64 undef, i64* %R6_Var
store float undef, float* %F1_Var
store float undef, float* %F2_Var
store float undef, float* %F3_Var
store float undef, float* %F4_Var
store double undef, double* %D1_Var
store double undef, double* %D2_Var
%lnuE = call ccc i64 (i8*,i8*,i8*)* @newCAF( i8* %lnux, i8* %lnuz, i8* %lnuD ) nounwind
store i64 %lnuE, i64* %lcsF
%lnuF = load i64* %lcsF
%lnuG = icmp eq i64 %lnuF, 0
br i1 %lnuG, label %cuH, label %nuI
nuI:
br label %cuJ
cu6:
%lnuK = load i64** %Base_Var
%lnuL = getelementptr inbounds i64* %lnuK, i32 -2
%lnuM = bitcast i64* %lnuL to i64*
%lnuN = load i64* %lnuM
%lnuO = inttoptr i64 %lnuN to void (i64*, i64*, i64*, i64, i64, i64, i64, i64, i64, i64, float, float, float, float, double, double)*
%lnuP = load i64** %Base_Var
%lnuQ = load i64** %Sp_Var
%lnuR = load i64** %Hp_Var
%lnuS = load i64* %R1_Var
%lnuT = load i64* %R2_Var
%lnuU = load i64* %R3_Var
%lnuV = load i64* %R4_Var
%lnuW = load i64* %R5_Var
%lnuX = load i64* %R6_Var
%lnuY = load i64* %SpLim_Var
%lnuZ = load float* %F1_Var
%lnv0 = load float* %F2_Var
%lnv1 = load float* %F3_Var
%lnv2 = load float* %F4_Var
%lnv3 = load double* %D1_Var
%lnv4 = load double* %D2_Var
tail call cc 10 void (i64*,i64*,i64*,i64,i64,i64,i64,i64,i64,i64,float,float,float,float,double,double)* %lnuO( i64* %lnuP, i64* %lnuQ, i64* %lnuR, i64 %lnuS, i64 %lnuT, i64 %lnuU, i64 %lnuV, i64 %lnuW, i64 %lnuX, i64 %lnuY, float %lnuZ, float %lnv0, float %lnv1, float %lnv2, double %lnv3, double %lnv4 ) nounwind
ret void
cuk:
%lnv5 = load i64** %Base_Var
%lnv6 = getelementptr inbounds i64* %lnv5, i32 24
store i64 16, i64* %lnv6
br label %cu6
cuH:
%lnv7 = load i64* %R1_Var
%lnv8 = inttoptr i64 %lnv7 to i64*
%lnv9 = load i64* %lnv8
%lnva = inttoptr i64 %lnv9 to void (i64*, i64*, i64*, i64, i64, i64, i64, i64, i64, i64, float, float, float, float, double, double)*
%lnvb = load i64** %Base_Var
%lnvc = load i64** %Sp_Var
%lnvd = load i64** %Hp_Var
%lnve = load i64* %R1_Var
%lnvf = load i64* %R2_Var
%lnvg = load i64* %R3_Var
%lnvh = load i64* %R4_Var
%lnvi = load i64* %R5_Var
%lnvj = load i64* %R6_Var
%lnvk = load i64* %SpLim_Var
%lnvl = load float* %F1_Var
%lnvm = load float* %F2_Var
%lnvn = load float* %F3_Var
%lnvo = load float* %F4_Var
%lnvp = load double* %D1_Var
%lnvq = load double* %D2_Var
tail call cc 10 void (i64*,i64*,i64*,i64,i64,i64,i64,i64,i64,i64,float,float,float,float,double,double)* %lnva( i64* %lnvb, i64* %lnvc, i64* %lnvd, i64 %lnve, i64 %lnvf, i64 %lnvg, i64 %lnvh, i64 %lnvi, i64 %lnvj, i64 %lnvk, float %lnvl, float %lnvm, float %lnvn, float %lnvo, double %lnvp, double %lnvq ) nounwind
ret void
cuJ:
%lnvr = ptrtoint [0 x i64]* @stg_bh_upd_frame_info to i64
%lnvs = load i64** %Sp_Var
%lnvt = getelementptr inbounds i64* %lnvs, i32 -2
store i64 %lnvr, i64* %lnvt
%lnvu = load i64** %Hp_Var
%lnvv = getelementptr inbounds i64* %lnvu, i32 -1
%lnvw = ptrtoint i64* %lnvv to i64
%lnvx = load i64** %Sp_Var
%lnvy = getelementptr inbounds i64* %lnvx, i32 -1
store i64 %lnvw, i64* %lnvy
%lnvz = ptrtoint [0 x i64]* @base_SystemziIO_print_closure to i64
store i64 %lnvz, i64* %R1_Var
%lnvA = ptrtoint [0 x i64]* @base_GHCziShow_zdfShowInteger_closure to i64
store i64 %lnvA, i64* %R2_Var
%lnvB = load i64** %Sp_Var
%lnvC = getelementptr inbounds i64* %lnvB, i32 -2
%lnvD = ptrtoint i64* %lnvC to i64
%lnvE = inttoptr i64 %lnvD to i64*
store i64* %lnvE, i64** %Sp_Var
%lnvF = load i64** %Base_Var
%lnvG = load i64** %Sp_Var
%lnvH = load i64** %Hp_Var
%lnvI = load i64* %R1_Var
%lnvJ = load i64* %R2_Var
%lnvK = load i64* %R3_Var
%lnvL = load i64* %R4_Var
%lnvM = load i64* %R5_Var
%lnvN = load i64* %R6_Var
%lnvO = load i64* %SpLim_Var
%lnvP = load float* %F1_Var
%lnvQ = load float* %F2_Var
%lnvR = load float* %F3_Var
%lnvS = load float* %F4_Var
%lnvT = load double* %D1_Var
%lnvU = load double* %D2_Var
tail call cc 10 void (i64*,i64*,i64*,i64,i64,i64,i64,i64,i64,i64,float,float,float,float,double,double)* @stg_ap_p_fast( i64* %lnvF, i64* %lnvG, i64* %lnvH, i64 %lnvI, i64 %lnvJ, i64 %lnvK, i64 %lnvL, i64 %lnvM, i64 %lnvN, i64 %lnvO, float %lnvP, float %lnvQ, float %lnvR, float %lnvS, double %lnvT, double %lnvU ) nounwind
ret void
}
@stg_CAF_BLACKHOLE_info = external global [0 x i64]
declare  ccc i64 @newCAF(i8*, i8*, i8*) align 8
@stg_bh_upd_frame_info = external global [0 x i64]
declare  cc 10 void @stg_ap_p_fast(i64* noalias nocapture, i64* noalias nocapture, i64* noalias nocapture, i64, i64, i64, i64, i64, i64, i64, float, float, float, float, double, double) align 8
%Main_main_info_struct = type <{i64, i64, i64}>
@Main_main_info_itable =  constant %Main_main_info_struct<{i64 add (i64 sub (i64 ptrtoint (%Main_main_srt_struct* @Main_main_srt to i64),i64 ptrtoint (void (i64*, i64*, i64*, i64, i64, i64, i64, i64, i64, i64, float, float, float, float, double, double)* @Main_main_info to i64)),i64 0), i64 0, i64 30064771094}>, section "X98A__STRIP,__me3", align 8
define  cc 10 void @Main_main_info(i64* noalias nocapture %Base_Arg, i64* noalias nocapture %Sp_Arg, i64* noalias nocapture %Hp_Arg, i64 %R1_Arg, i64 %R2_Arg, i64 %R3_Arg, i64 %R4_Arg, i64 %R5_Arg, i64 %R6_Arg, i64 %SpLim_Arg, float %F1_Arg, float %F2_Arg, float %F3_Arg, float %F4_Arg, double %D1_Arg, double %D2_Arg) align 8 nounwind section "X98A__STRIP,__me4"
{
cxV:
%Base_Var = alloca i64*, i32 1
store i64* %Base_Arg, i64** %Base_Var
%Sp_Var = alloca i64*, i32 1
store i64* %Sp_Arg, i64** %Sp_Var
%Hp_Var = alloca i64*, i32 1
store i64* %Hp_Arg, i64** %Hp_Var
%R1_Var = alloca i64, i32 1
store i64 %R1_Arg, i64* %R1_Var
%R2_Var = alloca i64, i32 1
store i64 %R2_Arg, i64* %R2_Var
%R3_Var = alloca i64, i32 1
store i64 %R3_Arg, i64* %R3_Var
%R4_Var = alloca i64, i32 1
store i64 %R4_Arg, i64* %R4_Var
%R5_Var = alloca i64, i32 1
store i64 %R5_Arg, i64* %R5_Var
%R6_Var = alloca i64, i32 1
store i64 %R6_Arg, i64* %R6_Var
%SpLim_Var = alloca i64, i32 1
store i64 %SpLim_Arg, i64* %SpLim_Var
%F1_Var = alloca float, i32 1
store float %F1_Arg, float* %F1_Var
%F2_Var = alloca float, i32 1
store float %F2_Arg, float* %F2_Var
%F3_Var = alloca float, i32 1
store float %F3_Arg, float* %F3_Var
%F4_Var = alloca float, i32 1
store float %F4_Arg, float* %F4_Var
%D1_Var = alloca double, i32 1
store double %D1_Arg, double* %D1_Var
%D2_Var = alloca double, i32 1
store double %D2_Arg, double* %D2_Var
%lcwz = alloca i64, i32 1
%lnxW = load i64** %Sp_Var
%lnxX = getelementptr inbounds i64* %lnxW, i32 -2
%lnxY = ptrtoint i64* %lnxX to i64
%lnxZ = load i64* %SpLim_Var
%lny0 = icmp ult i64 %lnxY, %lnxZ
br i1 %lny0, label %cy2, label %ny3
ny3:
%lny4 = load i64** %Hp_Var
%lny5 = getelementptr inbounds i64* %lny4, i32 2
%lny6 = ptrtoint i64* %lny5 to i64
%lny7 = inttoptr i64 %lny6 to i64*
store i64* %lny7, i64** %Hp_Var
%lny8 = load i64** %Hp_Var
%lny9 = ptrtoint i64* %lny8 to i64
%lnya = load i64** %Base_Var
%lnyb = getelementptr inbounds i64* %lnya, i32 18
%lnyc = bitcast i64* %lnyb to i64*
%lnyd = load i64* %lnyc
%lnye = icmp ugt i64 %lny9, %lnyd
br i1 %lnye, label %cyg, label %nyh
nyh:
%lnyi = ptrtoint [0 x i64]* @stg_CAF_BLACKHOLE_info to i64
%lnyj = load i64** %Hp_Var
%lnyk = getelementptr inbounds i64* %lnyj, i32 -1
store i64 %lnyi, i64* %lnyk
%lnyl = load i64** %Base_Var
%lnym = getelementptr inbounds i64* %lnyl, i32 20
%lnyn = bitcast i64* %lnym to i64*
%lnyo = load i64* %lnyn
%lnyp = load i64** %Hp_Var
%lnyq = getelementptr inbounds i64* %lnyp, i32 0
store i64 %lnyo, i64* %lnyq
%lnyr = load i64** %Base_Var
%lnys = ptrtoint i64* %lnyr to i64
%lnyt = inttoptr i64 %lnys to i8*
%lnyu = load i64* %R1_Var
%lnyv = inttoptr i64 %lnyu to i8*
%lnyw = load i64** %Hp_Var
%lnyx = getelementptr inbounds i64* %lnyw, i32 -1
%lnyy = ptrtoint i64* %lnyx to i64
%lnyz = inttoptr i64 %lnyy to i8*
store i64 undef, i64* %R3_Var
store i64 undef, i64* %R4_Var
store i64 undef, i64* %R5_Var
store i64 undef, i64* %R6_Var
store float undef, float* %F1_Var
store float undef, float* %F2_Var
store float undef, float* %F3_Var
store float undef, float* %F4_Var
store double undef, double* %D1_Var
store double undef, double* %D2_Var
%lnyA = call ccc i64 (i8*,i8*,i8*)* @newCAF( i8* %lnyt, i8* %lnyv, i8* %lnyz ) nounwind
store i64 %lnyA, i64* %lcwz
%lnyB = load i64* %lcwz
%lnyC = icmp eq i64 %lnyB, 0
br i1 %lnyC, label %cyD, label %nyE
nyE:
br label %cyF
cy2:
%lnyG = load i64** %Base_Var
%lnyH = getelementptr inbounds i64* %lnyG, i32 -2
%lnyI = bitcast i64* %lnyH to i64*
%lnyJ = load i64* %lnyI
%lnyK = inttoptr i64 %lnyJ to void (i64*, i64*, i64*, i64, i64, i64, i64, i64, i64, i64, float, float, float, float, double, double)*
%lnyL = load i64** %Base_Var
%lnyM = load i64** %Sp_Var
%lnyN = load i64** %Hp_Var
%lnyO = load i64* %R1_Var
%lnyP = load i64* %R2_Var
%lnyQ = load i64* %R3_Var
%lnyR = load i64* %R4_Var
%lnyS = load i64* %R5_Var
%lnyT = load i64* %R6_Var
%lnyU = load i64* %SpLim_Var
%lnyV = load float* %F1_Var
%lnyW = load float* %F2_Var
%lnyX = load float* %F3_Var
%lnyY = load float* %F4_Var
%lnyZ = load double* %D1_Var
%lnz0 = load double* %D2_Var
tail call cc 10 void (i64*,i64*,i64*,i64,i64,i64,i64,i64,i64,i64,float,float,float,float,double,double)* %lnyK( i64* %lnyL, i64* %lnyM, i64* %lnyN, i64 %lnyO, i64 %lnyP, i64 %lnyQ, i64 %lnyR, i64 %lnyS, i64 %lnyT, i64 %lnyU, float %lnyV, float %lnyW, float %lnyX, float %lnyY, double %lnyZ, double %lnz0 ) nounwind
ret void
cyg:
%lnz1 = load i64** %Base_Var
%lnz2 = getelementptr inbounds i64* %lnz1, i32 24
store i64 16, i64* %lnz2
br label %cy2
cyD:
%lnz3 = load i64* %R1_Var
%lnz4 = inttoptr i64 %lnz3 to i64*
%lnz5 = load i64* %lnz4
%lnz6 = inttoptr i64 %lnz5 to void (i64*, i64*, i64*, i64, i64, i64, i64, i64, i64, i64, float, float, float, float, double, double)*
%lnz7 = load i64** %Base_Var
%lnz8 = load i64** %Sp_Var
%lnz9 = load i64** %Hp_Var
%lnza = load i64* %R1_Var
%lnzb = load i64* %R2_Var
%lnzc = load i64* %R3_Var
%lnzd = load i64* %R4_Var
%lnze = load i64* %R5_Var
%lnzf = load i64* %R6_Var
%lnzg = load i64* %SpLim_Var
%lnzh = load float* %F1_Var
%lnzi = load float* %F2_Var
%lnzj = load float* %F3_Var
%lnzk = load float* %F4_Var
%lnzl = load double* %D1_Var
%lnzm = load double* %D2_Var
tail call cc 10 void (i64*,i64*,i64*,i64,i64,i64,i64,i64,i64,i64,float,float,float,float,double,double)* %lnz6( i64* %lnz7, i64* %lnz8, i64* %lnz9, i64 %lnza, i64 %lnzb, i64 %lnzc, i64 %lnzd, i64 %lnze, i64 %lnzf, i64 %lnzg, float %lnzh, float %lnzi, float %lnzj, float %lnzk, double %lnzl, double %lnzm ) nounwind
ret void
cyF:
%lnzn = ptrtoint [0 x i64]* @stg_bh_upd_frame_info to i64
%lnzo = load i64** %Sp_Var
%lnzp = getelementptr inbounds i64* %lnzo, i32 -2
store i64 %lnzn, i64* %lnzp
%lnzq = load i64** %Hp_Var
%lnzr = getelementptr inbounds i64* %lnzq, i32 -1
%lnzs = ptrtoint i64* %lnzr to i64
%lnzt = load i64** %Sp_Var
%lnzu = getelementptr inbounds i64* %lnzt, i32 -1
store i64 %lnzs, i64* %lnzu
%lnzv = ptrtoint [0 x i64]* @base_GHCziBase_zd_closure to i64
store i64 %lnzv, i64* %R1_Var
%lnzw = ptrtoint %srZ_closure_struct* @srZ_closure to i64
store i64 %lnzw, i64* %R2_Var
%lnzx = ptrtoint %srY_closure_struct* @srY_closure to i64
%lnzy = add i64 %lnzx, 1
store i64 %lnzy, i64* %R3_Var
%lnzz = load i64** %Sp_Var
%lnzA = getelementptr inbounds i64* %lnzz, i32 -2
%lnzB = ptrtoint i64* %lnzA to i64
%lnzC = inttoptr i64 %lnzB to i64*
store i64* %lnzC, i64** %Sp_Var
%lnzD = load i64** %Base_Var
%lnzE = load i64** %Sp_Var
%lnzF = load i64** %Hp_Var
%lnzG = load i64* %R1_Var
%lnzH = load i64* %R2_Var
%lnzI = load i64* %R3_Var
%lnzJ = load i64* %R4_Var
%lnzK = load i64* %R5_Var
%lnzL = load i64* %R6_Var
%lnzM = load i64* %SpLim_Var
%lnzN = load float* %F1_Var
%lnzO = load float* %F2_Var
%lnzP = load float* %F3_Var
%lnzQ = load float* %F4_Var
%lnzR = load double* %D1_Var
%lnzS = load double* %D2_Var
tail call cc 10 void (i64*,i64*,i64*,i64,i64,i64,i64,i64,i64,i64,float,float,float,float,double,double)* @stg_ap_pp_fast( i64* %lnzD, i64* %lnzE, i64* %lnzF, i64 %lnzG, i64 %lnzH, i64 %lnzI, i64 %lnzJ, i64 %lnzK, i64 %lnzL, i64 %lnzM, float %lnzN, float %lnzO, float %lnzP, float %lnzQ, double %lnzR, double %lnzS ) nounwind
ret void
}
declare  cc 10 void @stg_ap_pp_fast(i64* noalias nocapture, i64* noalias nocapture, i64* noalias nocapture, i64, i64, i64, i64, i64, i64, i64, float, float, float, float, double, double) align 8
%ZCMain_main_info_struct = type <{i64, i64, i64}>
@ZCMain_main_info_itable =  constant %ZCMain_main_info_struct<{i64 add (i64 sub (i64 ptrtoint (%ZCMain_main_srt_struct* @ZCMain_main_srt to i64),i64 ptrtoint (void (i64*, i64*, i64*, i64, i64, i64, i64, i64, i64, i64, float, float, float, float, double, double)* @ZCMain_main_info to i64)),i64 0), i64 0, i64 12884901910}>, section "X98A__STRIP,__me5", align 8
define  cc 10 void @ZCMain_main_info(i64* noalias nocapture %Base_Arg, i64* noalias nocapture %Sp_Arg, i64* noalias nocapture %Hp_Arg, i64 %R1_Arg, i64 %R2_Arg, i64 %R3_Arg, i64 %R4_Arg, i64 %R5_Arg, i64 %R6_Arg, i64 %SpLim_Arg, float %F1_Arg, float %F2_Arg, float %F3_Arg, float %F4_Arg, double %D1_Arg, double %D2_Arg) align 8 nounwind section "X98A__STRIP,__me6"
{
cBR:
%Base_Var = alloca i64*, i32 1
store i64* %Base_Arg, i64** %Base_Var
%Sp_Var = alloca i64*, i32 1
store i64* %Sp_Arg, i64** %Sp_Var
%Hp_Var = alloca i64*, i32 1
store i64* %Hp_Arg, i64** %Hp_Var
%R1_Var = alloca i64, i32 1
store i64 %R1_Arg, i64* %R1_Var
%R2_Var = alloca i64, i32 1
store i64 %R2_Arg, i64* %R2_Var
%R3_Var = alloca i64, i32 1
store i64 %R3_Arg, i64* %R3_Var
%R4_Var = alloca i64, i32 1
store i64 %R4_Arg, i64* %R4_Var
%R5_Var = alloca i64, i32 1
store i64 %R5_Arg, i64* %R5_Var
%R6_Var = alloca i64, i32 1
store i64 %R6_Arg, i64* %R6_Var
%SpLim_Var = alloca i64, i32 1
store i64 %SpLim_Arg, i64* %SpLim_Var
%F1_Var = alloca float, i32 1
store float %F1_Arg, float* %F1_Var
%F2_Var = alloca float, i32 1
store float %F2_Arg, float* %F2_Var
%F3_Var = alloca float, i32 1
store float %F3_Arg, float* %F3_Var
%F4_Var = alloca float, i32 1
store float %F4_Arg, float* %F4_Var
%D1_Var = alloca double, i32 1
store double %D1_Arg, double* %D1_Var
%D2_Var = alloca double, i32 1
store double %D2_Arg, double* %D2_Var
%lcAx = alloca i64, i32 1
%lnBS = load i64** %Sp_Var
%lnBT = getelementptr inbounds i64* %lnBS, i32 -2
%lnBU = ptrtoint i64* %lnBT to i64
%lnBV = load i64* %SpLim_Var
%lnBW = icmp ult i64 %lnBU, %lnBV
br i1 %lnBW, label %cBY, label %nBZ
nBZ:
%lnC0 = load i64** %Hp_Var
%lnC1 = getelementptr inbounds i64* %lnC0, i32 2
%lnC2 = ptrtoint i64* %lnC1 to i64
%lnC3 = inttoptr i64 %lnC2 to i64*
store i64* %lnC3, i64** %Hp_Var
%lnC4 = load i64** %Hp_Var
%lnC5 = ptrtoint i64* %lnC4 to i64
%lnC6 = load i64** %Base_Var
%lnC7 = getelementptr inbounds i64* %lnC6, i32 18
%lnC8 = bitcast i64* %lnC7 to i64*
%lnC9 = load i64* %lnC8
%lnCa = icmp ugt i64 %lnC5, %lnC9
br i1 %lnCa, label %cCc, label %nCd
nCd:
%lnCe = ptrtoint [0 x i64]* @stg_CAF_BLACKHOLE_info to i64
%lnCf = load i64** %Hp_Var
%lnCg = getelementptr inbounds i64* %lnCf, i32 -1
store i64 %lnCe, i64* %lnCg
%lnCh = load i64** %Base_Var
%lnCi = getelementptr inbounds i64* %lnCh, i32 20
%lnCj = bitcast i64* %lnCi to i64*
%lnCk = load i64* %lnCj
%lnCl = load i64** %Hp_Var
%lnCm = getelementptr inbounds i64* %lnCl, i32 0
store i64 %lnCk, i64* %lnCm
%lnCn = load i64** %Base_Var
%lnCo = ptrtoint i64* %lnCn to i64
%lnCp = inttoptr i64 %lnCo to i8*
%lnCq = load i64* %R1_Var
%lnCr = inttoptr i64 %lnCq to i8*
%lnCs = load i64** %Hp_Var
%lnCt = getelementptr inbounds i64* %lnCs, i32 -1
%lnCu = ptrtoint i64* %lnCt to i64
%lnCv = inttoptr i64 %lnCu to i8*
store i64 undef, i64* %R3_Var
store i64 undef, i64* %R4_Var
store i64 undef, i64* %R5_Var
store i64 undef, i64* %R6_Var
store float undef, float* %F1_Var
store float undef, float* %F2_Var
store float undef, float* %F3_Var
store float undef, float* %F4_Var
store double undef, double* %D1_Var
store double undef, double* %D2_Var
%lnCw = call ccc i64 (i8*,i8*,i8*)* @newCAF( i8* %lnCp, i8* %lnCr, i8* %lnCv ) nounwind
store i64 %lnCw, i64* %lcAx
%lnCx = load i64* %lcAx
%lnCy = icmp eq i64 %lnCx, 0
br i1 %lnCy, label %cCz, label %nCA
nCA:
br label %cCB
cBY:
%lnCC = load i64** %Base_Var
%lnCD = getelementptr inbounds i64* %lnCC, i32 -2
%lnCE = bitcast i64* %lnCD to i64*
%lnCF = load i64* %lnCE
%lnCG = inttoptr i64 %lnCF to void (i64*, i64*, i64*, i64, i64, i64, i64, i64, i64, i64, float, float, float, float, double, double)*
%lnCH = load i64** %Base_Var
%lnCI = load i64** %Sp_Var
%lnCJ = load i64** %Hp_Var
%lnCK = load i64* %R1_Var
%lnCL = load i64* %R2_Var
%lnCM = load i64* %R3_Var
%lnCN = load i64* %R4_Var
%lnCO = load i64* %R5_Var
%lnCP = load i64* %R6_Var
%lnCQ = load i64* %SpLim_Var
%lnCR = load float* %F1_Var
%lnCS = load float* %F2_Var
%lnCT = load float* %F3_Var
%lnCU = load float* %F4_Var
%lnCV = load double* %D1_Var
%lnCW = load double* %D2_Var
tail call cc 10 void (i64*,i64*,i64*,i64,i64,i64,i64,i64,i64,i64,float,float,float,float,double,double)* %lnCG( i64* %lnCH, i64* %lnCI, i64* %lnCJ, i64 %lnCK, i64 %lnCL, i64 %lnCM, i64 %lnCN, i64 %lnCO, i64 %lnCP, i64 %lnCQ, float %lnCR, float %lnCS, float %lnCT, float %lnCU, double %lnCV, double %lnCW ) nounwind
ret void
cCc:
%lnCX = load i64** %Base_Var
%lnCY = getelementptr inbounds i64* %lnCX, i32 24
store i64 16, i64* %lnCY
br label %cBY
cCz:
%lnCZ = load i64* %R1_Var
%lnD0 = inttoptr i64 %lnCZ to i64*
%lnD1 = load i64* %lnD0
%lnD2 = inttoptr i64 %lnD1 to void (i64*, i64*, i64*, i64, i64, i64, i64, i64, i64, i64, float, float, float, float, double, double)*
%lnD3 = load i64** %Base_Var
%lnD4 = load i64** %Sp_Var
%lnD5 = load i64** %Hp_Var
%lnD6 = load i64* %R1_Var
%lnD7 = load i64* %R2_Var
%lnD8 = load i64* %R3_Var
%lnD9 = load i64* %R4_Var
%lnDa = load i64* %R5_Var
%lnDb = load i64* %R6_Var
%lnDc = load i64* %SpLim_Var
%lnDd = load float* %F1_Var
%lnDe = load float* %F2_Var
%lnDf = load float* %F3_Var
%lnDg = load float* %F4_Var
%lnDh = load double* %D1_Var
%lnDi = load double* %D2_Var
tail call cc 10 void (i64*,i64*,i64*,i64,i64,i64,i64,i64,i64,i64,float,float,float,float,double,double)* %lnD2( i64* %lnD3, i64* %lnD4, i64* %lnD5, i64 %lnD6, i64 %lnD7, i64 %lnD8, i64 %lnD9, i64 %lnDa, i64 %lnDb, i64 %lnDc, float %lnDd, float %lnDe, float %lnDf, float %lnDg, double %lnDh, double %lnDi ) nounwind
ret void
cCB:
%lnDj = ptrtoint [0 x i64]* @stg_bh_upd_frame_info to i64
%lnDk = load i64** %Sp_Var
%lnDl = getelementptr inbounds i64* %lnDk, i32 -2
store i64 %lnDj, i64* %lnDl
%lnDm = load i64** %Hp_Var
%lnDn = getelementptr inbounds i64* %lnDm, i32 -1
%lnDo = ptrtoint i64* %lnDn to i64
%lnDp = load i64** %Sp_Var
%lnDq = getelementptr inbounds i64* %lnDp, i32 -1
store i64 %lnDo, i64* %lnDq
%lnDr = ptrtoint [0 x i64]* @base_GHCziTopHandler_runMainIO_closure to i64
store i64 %lnDr, i64* %R1_Var
%lnDs = ptrtoint %Main_main_closure_struct* @Main_main_closure to i64
store i64 %lnDs, i64* %R2_Var
%lnDt = load i64** %Sp_Var
%lnDu = getelementptr inbounds i64* %lnDt, i32 -2
%lnDv = ptrtoint i64* %lnDu to i64
%lnDw = inttoptr i64 %lnDv to i64*
store i64* %lnDw, i64** %Sp_Var
%lnDx = load i64** %Base_Var
%lnDy = load i64** %Sp_Var
%lnDz = load i64** %Hp_Var
%lnDA = load i64* %R1_Var
%lnDB = load i64* %R2_Var
%lnDC = load i64* %R3_Var
%lnDD = load i64* %R4_Var
%lnDE = load i64* %R5_Var
%lnDF = load i64* %R6_Var
%lnDG = load i64* %SpLim_Var
%lnDH = load float* %F1_Var
%lnDI = load float* %F2_Var
%lnDJ = load float* %F3_Var
%lnDK = load float* %F4_Var
%lnDL = load double* %D1_Var
%lnDM = load double* %D2_Var
tail call cc 10 void (i64*,i64*,i64*,i64,i64,i64,i64,i64,i64,i64,float,float,float,float,double,double)* @stg_ap_p_fast( i64* %lnDx, i64* %lnDy, i64* %lnDz, i64 %lnDA, i64 %lnDB, i64 %lnDC, i64 %lnDD, i64 %lnDE, i64 %lnDF, i64 %lnDG, float %lnDH, float %lnDI, float %lnDJ, float %lnDK, double %lnDL, double %lnDM ) nounwind
ret void
}
@llvm.used = appending global [1 x i8*] [i8* bitcast (%srZ_info_struct* @srZ_info_itable to i8*)], section "llvm.metadata"
