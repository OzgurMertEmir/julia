; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: -p
; RUN: opt -enable-new-pm=0 -load libjulia-codegen%shlibext -DemoteFloat16 -S %s | FileCheck %s
; RUN: opt -enable-new-pm=1 --load-pass-plugin=libjulia-codegen%shlibext -passes='DemoteFloat16' -S %s | FileCheck %s

define half @demotehalf_test(half %a, half %b) {
; CHECK-LABEL: @demotehalf_test(
; CHECK-NEXT:  top:
; CHECK-NEXT:    %0 = fpext half %a to float
; CHECK-NEXT:    %1 = fpext half %b to float
; CHECK-NEXT:    %2 = fadd float %0, %1
; CHECK-NEXT:    %3 = fptrunc float %2 to half
; CHECK-NEXT:    %4 = fpext half %3 to float
; CHECK-NEXT:    %5 = fpext half %b to float
; CHECK-NEXT:    %6 = fadd float %4, %5
; CHECK-NEXT:    %7 = fptrunc float %6 to half
; CHECK-NEXT:    %8 = fpext half %7 to float
; CHECK-NEXT:    %9 = fpext half %b to float
; CHECK-NEXT:    %10 = fadd float %8, %9
; CHECK-NEXT:    %11 = fptrunc float %10 to half
; CHECK-NEXT:    %12 = fpext half %11 to float
; CHECK-NEXT:    %13 = fpext half %b to float
; CHECK-NEXT:    %14 = fmul float %12, %13
; CHECK-NEXT:    %15 = fptrunc float %14 to half
; CHECK-NEXT:    %16 = fpext half %15 to float
; CHECK-NEXT:    %17 = fpext half %b to float
; CHECK-NEXT:    %18 = fdiv float %16, %17
; CHECK-NEXT:    %19 = fptrunc float %18 to half
; CHECK-NEXT:    %20 = insertelement <2 x half> undef, half %a, i32 0
; CHECK-NEXT:    %21 = insertelement <2 x half> %20, half %b, i32 1
; CHECK-NEXT:    %22 = insertelement <2 x half> undef, half %b, i32 0
; CHECK-NEXT:    %23 = insertelement <2 x half> %22, half %b, i32 1
; CHECK-NEXT:    %24 = fpext <2 x half> %21 to <2 x float>
; CHECK-NEXT:    %25 = fpext <2 x half> %23 to <2 x float>
; CHECK-NEXT:    %26 = fadd <2 x float> %24, %25
; CHECK-NEXT:    %27 = fptrunc <2 x float> %26 to <2 x half>
; CHECK-NEXT:    %28 = extractelement <2 x half> %27, i32 0
; CHECK-NEXT:    %29 = extractelement <2 x half> %27, i32 1
; CHECK-NEXT:    %30 = fpext half %28 to float
; CHECK-NEXT:    %31 = fpext half %29 to float
; CHECK-NEXT:    %32 = fadd float %30, %31
; CHECK-NEXT:    %33 = fptrunc float %32 to half
; CHECK-NEXT:    %34 = fpext half %33 to float
; CHECK-NEXT:    %35 = fpext half %19 to float
; CHECK-NEXT:    %36 = fadd float %34, %35
; CHECK-NEXT:    %37 = fptrunc float %36 to half
; CHECK-NEXT:    ret half %37
;
top:
  %0 = fadd half %a, %b
  %1 = fadd half %0, %b
  %2 = fadd half %1, %b
  %3 = fmul half %2, %b
  %4 = fdiv half %3, %b
  %5 = insertelement <2 x half> undef, half %a, i32 0
  %6 = insertelement <2 x half> %5, half %b, i32 1
  %7 = insertelement <2 x half> undef, half %b, i32 0
  %8 = insertelement <2 x half> %7, half %b, i32 1
  %9 = fadd <2 x half> %6, %8
  %10 = extractelement <2 x half> %9, i32 0
  %11 = extractelement <2 x half> %9, i32 1
  %12 = fadd half %10, %11
  %13 = fadd half %12, %4
  ret half %13
}