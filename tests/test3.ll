; ModuleID = './test3.cpp'
source_filename = "./test3.cpp"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @_Z3foov() #0 !dbg !9 {
  %1 = alloca [100 x [100 x i32]], align 16
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  call void @llvm.dbg.declare(metadata [100 x [100 x i32]]* %1, metadata !13, metadata !DIExpression()), !dbg !18
  call void @llvm.dbg.declare(metadata i32* %2, metadata !19, metadata !DIExpression()), !dbg !21
  store i32 0, i32* %2, align 4, !dbg !21
  br label %4, !dbg !22

; <label>:4:                                      ; preds = %50, %0
  %5 = load i32, i32* %2, align 4, !dbg !23
  %6 = icmp slt i32 %5, 10, !dbg !25
  br i1 %6, label %7, label %53, !dbg !26

; <label>:7:                                      ; preds = %4
  call void @llvm.dbg.declare(metadata i32* %3, metadata !27, metadata !DIExpression()), !dbg !30
  store i32 0, i32* %3, align 4, !dbg !30
  br label %8, !dbg !31

; <label>:8:                                      ; preds = %46, %7
  %9 = load i32, i32* %3, align 4, !dbg !32
  %10 = icmp slt i32 %9, 10, !dbg !34
  br i1 %10, label %11, label %49, !dbg !35

; <label>:11:                                     ; preds = %8
  %12 = load i32, i32* %2, align 4, !dbg !36
  %13 = sext i32 %12 to i64, !dbg !38
  %14 = getelementptr inbounds [100 x [100 x i32]], [100 x [100 x i32]]* %1, i64 0, i64 %13, !dbg !38
  %15 = load i32, i32* %3, align 4, !dbg !39
  %16 = add nsw i32 %15, 67, !dbg !40
  %17 = sext i32 %16 to i64, !dbg !38
  %18 = getelementptr inbounds [100 x i32], [100 x i32]* %14, i64 0, i64 %17, !dbg !38
  %19 = load i32, i32* %18, align 4, !dbg !38
  %20 = add nsw i32 %19, 1, !dbg !41
  %21 = load i32, i32* %2, align 4, !dbg !42
  %22 = add nsw i32 %21, 70, !dbg !43
  %23 = sext i32 %22 to i64, !dbg !44
  %24 = getelementptr inbounds [100 x [100 x i32]], [100 x [100 x i32]]* %1, i64 0, i64 %23, !dbg !44
  %25 = load i32, i32* %3, align 4, !dbg !45
  %26 = add nsw i32 %25, 69, !dbg !46
  %27 = sext i32 %26 to i64, !dbg !44
  %28 = getelementptr inbounds [100 x i32], [100 x i32]* %24, i64 0, i64 %27, !dbg !44
  store i32 %20, i32* %28, align 4, !dbg !47
  %29 = load i32, i32* %2, align 4, !dbg !48
  %30 = sext i32 %29 to i64, !dbg !49
  %31 = getelementptr inbounds [100 x [100 x i32]], [100 x [100 x i32]]* %1, i64 0, i64 %30, !dbg !49
  %32 = load i32, i32* %3, align 4, !dbg !50
  %33 = add nsw i32 %32, 87, !dbg !51
  %34 = sext i32 %33 to i64, !dbg !49
  %35 = getelementptr inbounds [100 x i32], [100 x i32]* %31, i64 0, i64 %34, !dbg !49
  %36 = load i32, i32* %35, align 4, !dbg !49
  %37 = add nsw i32 %36, 2, !dbg !52
  %38 = load i32, i32* %2, align 4, !dbg !53
  %39 = add nsw i32 %38, 80, !dbg !54
  %40 = sext i32 %39 to i64, !dbg !55
  %41 = getelementptr inbounds [100 x [100 x i32]], [100 x [100 x i32]]* %1, i64 0, i64 %40, !dbg !55
  %42 = load i32, i32* %3, align 4, !dbg !56
  %43 = add nsw i32 %42, 89, !dbg !57
  %44 = sext i32 %43 to i64, !dbg !55
  %45 = getelementptr inbounds [100 x i32], [100 x i32]* %41, i64 0, i64 %44, !dbg !55
  store i32 %37, i32* %45, align 4, !dbg !58
  br label %46, !dbg !59

; <label>:46:                                     ; preds = %11
  %47 = load i32, i32* %3, align 4, !dbg !60
  %48 = add nsw i32 %47, 1, !dbg !60
  store i32 %48, i32* %3, align 4, !dbg !60
  br label %8, !dbg !61, !llvm.loop !62

; <label>:49:                                     ; preds = %8
  br label %50, !dbg !64

; <label>:50:                                     ; preds = %49
  %51 = load i32, i32* %2, align 4, !dbg !65
  %52 = add nsw i32 %51, 1, !dbg !65
  store i32 %52, i32* %2, align 4, !dbg !65
  br label %4, !dbg !66, !llvm.loop !67

; <label>:53:                                     ; preds = %4
  ret void, !dbg !69
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline norecurse nounwind optnone ssp uwtable
define i32 @main() #2 !dbg !70 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  ret i32 0, !dbg !73
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
!6 = !DIFile(filename: "test3.cpp", directory: "/Users/sharan/llvm-project/build/lib/tests")
!7 = !{}
!8 = !{!"Apple clang version 11.0.0 (clang-1100.0.33.17)"}
!9 = distinct !DISubprogram(name: "foo", linkageName: "_Z3foov", scope: !10, file: !10, line: 3, type: !11, scopeLine: 3, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !5, retainedNodes: !7)
!10 = !DIFile(filename: "./test3.cpp", directory: "/Users/sharan/llvm-project/build/lib/tests")
!11 = !DISubroutineType(types: !12)
!12 = !{null}
!13 = !DILocalVariable(name: "a", scope: !9, file: !10, line: 4, type: !14)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 320000, elements: !16)
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !{!17, !17}
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
!27 = !DILocalVariable(name: "j", scope: !28, file: !10, line: 7, type: !15)
!28 = distinct !DILexicalBlock(scope: !29, file: !10, line: 7, column: 5)
!29 = distinct !DILexicalBlock(scope: !24, file: !10, line: 6, column: 32)
!30 = !DILocation(line: 7, column: 14, scope: !28)
!31 = !DILocation(line: 7, column: 10, scope: !28)
!32 = !DILocation(line: 7, column: 21, scope: !33)
!33 = distinct !DILexicalBlock(scope: !28, file: !10, line: 7, column: 5)
!34 = !DILocation(line: 7, column: 23, scope: !33)
!35 = !DILocation(line: 7, column: 5, scope: !28)
!36 = !DILocation(line: 9, column: 29, scope: !37)
!37 = distinct !DILexicalBlock(scope: !33, file: !10, line: 7, column: 34)
!38 = !DILocation(line: 9, column: 27, scope: !37)
!39 = !DILocation(line: 9, column: 32, scope: !37)
!40 = !DILocation(line: 9, column: 34, scope: !37)
!41 = !DILocation(line: 9, column: 40, scope: !37)
!42 = !DILocation(line: 9, column: 9, scope: !37)
!43 = !DILocation(line: 9, column: 11, scope: !37)
!44 = !DILocation(line: 9, column: 7, scope: !37)
!45 = !DILocation(line: 9, column: 17, scope: !37)
!46 = !DILocation(line: 9, column: 19, scope: !37)
!47 = !DILocation(line: 9, column: 25, scope: !37)
!48 = !DILocation(line: 10, column: 29, scope: !37)
!49 = !DILocation(line: 10, column: 27, scope: !37)
!50 = !DILocation(line: 10, column: 32, scope: !37)
!51 = !DILocation(line: 10, column: 34, scope: !37)
!52 = !DILocation(line: 10, column: 40, scope: !37)
!53 = !DILocation(line: 10, column: 9, scope: !37)
!54 = !DILocation(line: 10, column: 11, scope: !37)
!55 = !DILocation(line: 10, column: 7, scope: !37)
!56 = !DILocation(line: 10, column: 17, scope: !37)
!57 = !DILocation(line: 10, column: 19, scope: !37)
!58 = !DILocation(line: 10, column: 25, scope: !37)
!59 = !DILocation(line: 11, column: 5, scope: !37)
!60 = !DILocation(line: 7, column: 30, scope: !33)
!61 = !DILocation(line: 7, column: 5, scope: !33)
!62 = distinct !{!62, !35, !63}
!63 = !DILocation(line: 11, column: 5, scope: !28)
!64 = !DILocation(line: 12, column: 3, scope: !29)
!65 = !DILocation(line: 6, column: 28, scope: !24)
!66 = !DILocation(line: 6, column: 3, scope: !24)
!67 = distinct !{!67, !26, !68}
!68 = !DILocation(line: 12, column: 3, scope: !20)
!69 = !DILocation(line: 13, column: 1, scope: !9)
!70 = distinct !DISubprogram(name: "main", scope: !10, file: !10, line: 15, type: !71, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !5, retainedNodes: !7)
!71 = !DISubroutineType(types: !72)
!72 = !{!15}
!73 = !DILocation(line: 15, column: 14, scope: !70)
