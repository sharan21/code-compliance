; ModuleID = './test1.cpp'
source_filename = "./test1.cpp"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @_Z3foov() #0 !dbg !9 {
  %1 = alloca [100 x i32], align 16
  %2 = alloca i32, align 4
  call void @llvm.dbg.declare(metadata [100 x i32]* %1, metadata !13, metadata !DIExpression()), !dbg !18
  call void @llvm.dbg.declare(metadata i32* %2, metadata !19, metadata !DIExpression()), !dbg !21
  store i32 0, i32* %2, align 4, !dbg !21
  br label %3, !dbg !22

; <label>:3:                                      ; preds = %16, %0
  %4 = load i32, i32* %2, align 4, !dbg !23
  %5 = icmp slt i32 %4, 10, !dbg !25
  br i1 %5, label %6, label %19, !dbg !26

; <label>:6:                                      ; preds = %3
  %7 = load i32, i32* %2, align 4, !dbg !27
  %8 = add nsw i32 %7, 1, !dbg !29
  %9 = sext i32 %8 to i64, !dbg !30
  %10 = getelementptr inbounds [100 x i32], [100 x i32]* %1, i64 0, i64 %9, !dbg !30
  %11 = load i32, i32* %10, align 4, !dbg !30
  %12 = load i32, i32* %2, align 4, !dbg !31
  %13 = add nsw i32 %12, 3, !dbg !32
  %14 = sext i32 %13 to i64, !dbg !33
  %15 = getelementptr inbounds [100 x i32], [100 x i32]* %1, i64 0, i64 %14, !dbg !33
  store i32 %11, i32* %15, align 4, !dbg !34
  br label %16, !dbg !35

; <label>:16:                                     ; preds = %6
  %17 = load i32, i32* %2, align 4, !dbg !36
  %18 = add nsw i32 %17, 1, !dbg !36
  store i32 %18, i32* %2, align 4, !dbg !36
  br label %3, !dbg !37, !llvm.loop !38

; <label>:19:                                     ; preds = %3
  ret void, !dbg !40
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline norecurse nounwind optnone ssp uwtable
define i32 @main() #2 !dbg !41 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  ret i32 0, !dbg !44
}

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "darwin-stkchk-strong-link" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "probe-stack"="___chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { noinline norecurse nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "darwin-stkchk-strong-link" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "probe-stack"="___chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.dbg.cu = !{!5}
!llvm.ident = !{!8}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 10, i32 15]}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 7, !"PIC Level", i32 2}
!5 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !6, producer: "Apple clang version 11.0.0 (clang-1100.0.33.17)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !7, nameTableKind: GNU)
!6 = !DIFile(filename: "test1.cpp", directory: "/Users/sharan/llvm-project/build/lib/tests")
!7 = !{}
!8 = !{!"Apple clang version 11.0.0 (clang-1100.0.33.17)"}
!9 = distinct !DISubprogram(name: "foo", linkageName: "_Z3foov", scope: !10, file: !10, line: 3, type: !11, scopeLine: 3, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !5, retainedNodes: !7)
!10 = !DIFile(filename: "./test1.cpp", directory: "/Users/sharan/llvm-project/build/lib/tests")
!11 = !DISubroutineType(types: !12)
!12 = !{null}
!13 = !DILocalVariable(name: "a", scope: !9, file: !10, line: 4, type: !14)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 3200, elements: !16)
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !{!17}
!17 = !DISubrange(count: 100)
!18 = !DILocation(line: 4, column: 7, scope: !9)
!19 = !DILocalVariable(name: "i", scope: !20, file: !10, line: 6, type: !15)
!20 = distinct !DILexicalBlock(scope: !9, file: !10, line: 6, column: 3)
!21 = !DILocation(line: 6, column: 12, scope: !20)
!22 = !DILocation(line: 6, column: 8, scope: !20)
!23 = !DILocation(line: 6, column: 19, scope: !24)
!24 = distinct !DILexicalBlock(scope: !20, file: !10, line: 6, column: 3)
!25 = !DILocation(line: 6, column: 21, scope: !24)
!26 = !DILocation(line: 6, column: 3, scope: !20)
!27 = !DILocation(line: 7, column: 18, scope: !28)
!28 = distinct !DILexicalBlock(scope: !24, file: !10, line: 6, column: 32)
!29 = !DILocation(line: 7, column: 20, scope: !28)
!30 = !DILocation(line: 7, column: 16, scope: !28)
!31 = !DILocation(line: 7, column: 7, scope: !28)
!32 = !DILocation(line: 7, column: 9, scope: !28)
!33 = !DILocation(line: 7, column: 5, scope: !28)
!34 = !DILocation(line: 7, column: 14, scope: !28)
!35 = !DILocation(line: 8, column: 3, scope: !28)
!36 = !DILocation(line: 6, column: 28, scope: !24)
!37 = !DILocation(line: 6, column: 3, scope: !24)
!38 = distinct !{!38, !26, !39}
!39 = !DILocation(line: 8, column: 3, scope: !20)
!40 = !DILocation(line: 9, column: 1, scope: !9)
!41 = distinct !DISubprogram(name: "main", scope: !10, file: !10, line: 11, type: !42, scopeLine: 11, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !5, retainedNodes: !7)
!42 = !DISubroutineType(types: !43)
!43 = !{!15}
!44 = !DILocation(line: 11, column: 14, scope: !41)
