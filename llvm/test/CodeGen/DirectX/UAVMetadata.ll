; RUN: opt -S -dxil-metadata-emit < %s | FileCheck %s
; ModuleID = '/home/cbieneman/dev/shuffle.hlsl'
target datalayout = "e-m:e-p:32:32-i1:32-i8:8-i16:16-i32:32-i64:64-f16:16-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-pc-shadermodel6.0-compute"

%"class.hlsl::RWBuffer" = type { ptr }

@Zero = local_unnamed_addr global %"class.hlsl::RWBuffer" zeroinitializer, align 4
@One = local_unnamed_addr global %"class.hlsl::RWBuffer" zeroinitializer, align 4
@Two = local_unnamed_addr global %"class.hlsl::RWBuffer" zeroinitializer, align 4
@Three = local_unnamed_addr global [2 x %"class.hlsl::RWBuffer"] zeroinitializer, align 4
@Four = local_unnamed_addr global %"class.hlsl::RWBuffer" zeroinitializer, align 4
@Five = local_unnamed_addr global %"class.hlsl::RWBuffer" zeroinitializer, align 4
@Six = local_unnamed_addr global %"class.hlsl::RWBuffer" zeroinitializer, align 4
@Seven = local_unnamed_addr global %"class.hlsl::RWBuffer" zeroinitializer, align 4
@Eight = local_unnamed_addr global %"class.hlsl::RWBuffer" zeroinitializer, align 4
@Nine = local_unnamed_addr global %"class.hlsl::RWBuffer" zeroinitializer, align 4


!hlsl.uavs = !{!0, !1, !2, !3, !4, !5, !6, !7, !8, !9}

!0 = !{ptr @Zero, !"RWBuffer<half>", i32 0}
!1 = !{ptr @One, !"Buffer<vector<float,4>>", i32 1}
!2 = !{ptr @Two, !"Buffer<double>", i32 2}
!3 = !{ptr @Three, !"Buffer<bool>", i32 3}
!4 = !{ptr @Four, !"ByteAddressBuffer<int16_t>", i32 4}
!5 = !{ptr @Five, !"StructuredBuffer<uint16_t>", i32 5}
!6 = !{ptr @Six, !"RasterizerOrderedBuffer<int32_t>", i32 6}
!7 = !{ptr @Seven, !"RasterizerOrderedStructuredBuffer<uint32_t>", i32 7}
!8 = !{ptr @Eight, !"RasterizerOrderedByteAddressBuffer<int64_t>", i32 8}
!9 = !{ptr @Nine, !"RWBuffer<uint64_t>", i32 9}


; CHECK: !dx.resources = !{[[ResList:[!][0-9]+]]}

; CHECK: [[ResList]] = !{null, [[UAVList:[!][0-9]+]], null, null}
; CHECK: [[UAVList]] = !{[[Zero:[!][0-9]+]], [[One:[!][0-9]+]],
; CHECK-SAME: [[Two:[!][0-9]+]], [[Three:[!][0-9]+]], [[Four:[!][0-9]+]], 
; CHECK-SAME: [[Five:[!][0-9]+]], [[Six:[!][0-9]+]], [[Seven:[!][0-9]+]],
; CHECK-SAME: [[Eight:[!][0-9]+]], [[Nine:[!][0-9]+]]}
; CHECK: [[Zero]] = !{i32 0, ptr @Zero, !"", i32 0, i32 0, i32 1, i32 10, i1 false, i1 false, i1 false, [[Half:[!][0-9]+]]}
; CHECK: [[Half]] = !{i32 0, i32 8}
; CHECK: [[One]] = !{i32 1, ptr @One, !"", i32 0, i32 0, i32 1, i32 10, i1 false, i1 false, i1 false, [[Float:[!][0-9]+]]}
; CHECK: [[Float]] = !{i32 0, i32 9}
; CHECK: [[Two]] = !{i32 2, ptr @Two, !"", i32 0, i32 0, i32 1, i32 10, i1 false, i1 false, i1 false, [[Double:[!][0-9]+]]}
; CHECK: [[Double]] = !{i32 0, i32 10}
; CHECK: [[Three]] = !{i32 3, ptr @Three, !"", i32 0, i32 0, i32 2, i32 10, i1 false, i1 false, i1 false, [[Bool:[!][0-9]+]]}
; CHECK: [[Bool]] = !{i32 0, i32 1}
; CHECK: [[Four]] = !{i32 4, ptr @Four, !"", i32 0, i32 0, i32 1, i32 11, i1 false, i1 false, i1 false, [[I16:[!][0-9]+]]}
; CHECK: [[I16]] = !{i32 0, i32 2}
; CHECK: [[Five]] = !{i32 5, ptr @Five, !"", i32 0, i32 0, i32 1, i32 12, i1 false, i1 false, i1 false, [[U16:[!][0-9]+]]}
; CHECK: [[U16]] = !{i32 0, i32 3}
; CHECK: [[Six]] = !{i32 6, ptr @Six, !"", i32 0, i32 0, i32 1, i32 10, i1 false, i1 false, i1 true, [[I32:[!][0-9]+]]}
; CHECK: [[I32]] = !{i32 0, i32 4}
; CHECK: [[Seven]] = !{i32 7, ptr @Seven, !"", i32 0, i32 0, i32 1, i32 12, i1 false, i1 false, i1 true, [[U32:[!][0-9]+]]}
; CHECK: [[U32]] = !{i32 0, i32 5}
; CHECK: [[Eight]] = !{i32 8, ptr @Eight, !"", i32 0, i32 0, i32 1, i32 11, i1 false, i1 false, i1 true, [[I64:[!][0-9]+]]}
; CHECK: [[I64]] = !{i32 0, i32 6}
; CHECK: [[Nine]] = !{i32 9, ptr @Nine, !"", i32 0, i32 0, i32 1, i32 10, i1 false, i1 false, i1 false, [[U64:[!][0-9]+]]}
; CHECK: [[U64]] = !{i32 0, i32 7}
