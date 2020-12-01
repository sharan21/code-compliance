; ModuleID = './test5.cpp'
source_filename = "./test5.cpp"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @_Z3foov() #0 !dbg !9 {
  %1 = alloca [100 x [100 x [100 x i32]]], align 16
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  call void @llvm.dbg.declare(metadata [100 x [100 x [100 x i32]]]* %1, metadata !13, metadata !DIExpression()), !dbg !18
  call void @llvm.dbg.declare(metadata i32* %2, metadata !19, metadata !DIExpression()), !dbg !21
  store i32 0, i32* %2, align 4, !dbg !21
  br label %5, !dbg !22

; <label>:5:                                      ; preds = %95, %0
  %6 = load i32, i32* %2, align 4, !dbg !23
  %7 = icmp slt i32 %6, 10, !dbg !25
  br i1 %7, label %8, label %98, !dbg !26

; <label>:8:                                      ; preds = %5
  call void @llvm.dbg.declare(metadata i32* %3, metadata !27, metadata !DIExpression()), !dbg !30
  store i32 0, i32* %3, align 4, !dbg !30
  br label %9, !dbg !31

; <label>:9:                                      ; preds = %91, %8
  %10 = load i32, i32* %3, align 4, !dbg !32
  %11 = icmp slt i32 %10, 10, !dbg !34
  br i1 %11, label %12, label %94, !dbg !35

; <label>:12:                                     ; preds = %9
  call void @llvm.dbg.declare(metadata i32* %4, metadata !36, metadata !DIExpression()), !dbg !39
  store i32 0, i32* %4, align 4, !dbg !39
  br label %13, !dbg !40

; <label>:13:                                     ; preds = %87, %12
  %14 = load i32, i32* %4, align 4, !dbg !41
  %15 = icmp slt i32 %14, 10, !dbg !43
  br i1 %15, label %16, label %90, !dbg !44

; <label>:16:                                     ; preds = %13
  %17 = load i32, i32* %2, align 4, !dbg !45
  %18 = sext i32 %17 to i64, !dbg !47
  %19 = getelementptr inbounds [100 x [100 x [100 x i32]]], [100 x [100 x [100 x i32]]]* %1, i64 0, i64 %18, !dbg !47
  %20 = load i32, i32* %3, align 4, !dbg !48
  %21 = add nsw i32 %20, 67, !dbg !49
  %22 = sext i32 %21 to i64, !dbg !47
  %23 = getelementptr inbounds [100 x [100 x i32]], [100 x [100 x i32]]* %19, i64 0, i64 %22, !dbg !47
  %24 = load i32, i32* %4, align 4, !dbg !50
  %25 = sext i32 %24 to i64, !dbg !47
  %26 = getelementptr inbounds [100 x i32], [100 x i32]* %23, i64 0, i64 %25, !dbg !47
  %27 = load i32, i32* %26, align 4, !dbg !47
  %28 = load i32, i32* %2, align 4, !dbg !51
  %29 = sext i32 %28 to i64, !dbg !52
  %30 = getelementptr inbounds [100 x [100 x [100 x i32]]], [100 x [100 x [100 x i32]]]* %1, i64 0, i64 %29, !dbg !52
  %31 = load i32, i32* %3, align 4, !dbg !53
  %32 = sext i32 %31 to i64, !dbg !52
  %33 = getelementptr inbounds [100 x [100 x i32]], [100 x [100 x i32]]* %30, i64 0, i64 %32, !dbg !52
  %34 = load i32, i32* %4, align 4, !dbg !54
  %35 = sext i32 %34 to i64, !dbg !52
  %36 = getelementptr inbounds [100 x i32], [100 x i32]* %33, i64 0, i64 %35, !dbg !52
  %37 = load i32, i32* %36, align 4, !dbg !52
  %38 = add nsw i32 %27, %37, !dbg !55
  %39 = load i32, i32* %2, align 4, !dbg !56
  %40 = add nsw i32 %39, 70, !dbg !57
  %41 = sext i32 %40 to i64, !dbg !58
  %42 = getelementptr inbounds [100 x [100 x [100 x i32]]], [100 x [100 x [100 x i32]]]* %1, i64 0, i64 %41, !dbg !58
  %43 = load i32, i32* %3, align 4, !dbg !59
  %44 = sext i32 %43 to i64, !dbg !58
  %45 = getelementptr inbounds [100 x [100 x i32]], [100 x [100 x i32]]* %42, i64 0, i64 %44, !dbg !58
  %46 = load i32, i32* %4, align 4, !dbg !60
  %47 = sext i32 %46 to i64, !dbg !58
  %48 = getelementptr inbounds [100 x i32], [100 x i32]* %45, i64 0, i64 %47, !dbg !58
  %49 = load i32, i32* %48, align 4, !dbg !58
  %50 = add nsw i32 %38, %49, !dbg !61
  %51 = load i32, i32* %2, align 4, !dbg !62
  %52 = add nsw i32 %51, 70, !dbg !63
  %53 = sext i32 %52 to i64, !dbg !64
  %54 = getelementptr inbounds [100 x [100 x [100 x i32]]], [100 x [100 x [100 x i32]]]* %1, i64 0, i64 %53, !dbg !64
  %55 = load i32, i32* %3, align 4, !dbg !65
  %56 = add nsw i32 %55, 69, !dbg !66
  %57 = sext i32 %56 to i64, !dbg !64
  %58 = getelementptr inbounds [100 x [100 x i32]], [100 x [100 x i32]]* %54, i64 0, i64 %57, !dbg !64
  %59 = load i32, i32* %4, align 4, !dbg !67
  %60 = add nsw i32 %59, 1, !dbg !68
  %61 = sext i32 %60 to i64, !dbg !64
  %62 = getelementptr inbounds [100 x i32], [100 x i32]* %58, i64 0, i64 %61, !dbg !64
  store i32 %50, i32* %62, align 4, !dbg !69
  %63 = load i32, i32* %2, align 4, !dbg !70
  %64 = sext i32 %63 to i64, !dbg !71
  %65 = getelementptr inbounds [100 x [100 x [100 x i32]]], [100 x [100 x [100 x i32]]]* %1, i64 0, i64 %64, !dbg !71
  %66 = load i32, i32* %3, align 4, !dbg !72
  %67 = add nsw i32 %66, 87, !dbg !73
  %68 = sext i32 %67 to i64, !dbg !71
  %69 = getelementptr inbounds [100 x [100 x i32]], [100 x [100 x i32]]* %65, i64 0, i64 %68, !dbg !71
  %70 = load i32, i32* %4, align 4, !dbg !74
  %71 = sext i32 %70 to i64, !dbg !71
  %72 = getelementptr inbounds [100 x i32], [100 x i32]* %69, i64 0, i64 %71, !dbg !71
  %73 = load i32, i32* %72, align 4, !dbg !71
  %74 = add nsw i32 %73, 2, !dbg !75
  %75 = load i32, i32* %2, align 4, !dbg !76
  %76 = add nsw i32 %75, 80, !dbg !77
  %77 = sext i32 %76 to i64, !dbg !78
  %78 = getelementptr inbounds [100 x [100 x [100 x i32]]], [100 x [100 x [100 x i32]]]* %1, i64 0, i64 %77, !dbg !78
  %79 = load i32, i32* %3, align 4, !dbg !79
  %80 = add nsw i32 %79, 89, !dbg !80
  %81 = sext i32 %80 to i64, !dbg !78
  %82 = getelementptr inbounds [100 x [100 x i32]], [100 x [100 x i32]]* %78, i64 0, i64 %81, !dbg !78
  %83 = load i32, i32* %4, align 4, !dbg !81
  %84 = add nsw i32 %83, 3, !dbg !82
  %85 = sext i32 %84 to i64, !dbg !78
  %86 = getelementptr inbounds [100 x i32], [100 x i32]* %82, i64 0, i64 %85, !dbg !78
  store i32 %74, i32* %86, align 4, !dbg !83
  br label %87, !dbg !84

; <label>:87:                                     ; preds = %16
  %88 = load i32, i32* %4, align 4, !dbg !85
  %89 = add nsw i32 %88, 1, !dbg !85
  store i32 %89, i32* %4, align 4, !dbg !85
  br label %13, !dbg !86, !llvm.loop !87

; <label>:90:                                     ; preds = %13
  br label %91, !dbg !89

; <label>:91:                                     ; preds = %90
  %92 = load i32, i32* %3, align 4, !dbg !90
  %93 = add nsw i32 %92, 1, !dbg !90
  store i32 %93, i32* %3, align 4, !dbg !90
  br label %9, !dbg !91, !llvm.loop !92

; <label>:94:                                     ; preds = %9
  br label %95, !dbg !94

; <label>:95:                                     ; preds = %94
  %96 = load i32, i32* %2, align 4, !dbg !95
  %97 = add nsw i32 %96, 1, !dbg !95
  store i32 %97, i32* %2, align 4, !dbg !95
  br label %5, !dbg !96, !llvm.loop !97

; <label>:98:                                     ; preds = %5
  ret void, !dbg !99
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline norecurse nounwind optnone ssp uwtable
define i32 @main() #2 !dbg !100 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  ret i32 0, !dbg !103
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
!6 = !DIFile(filename: "test5.cpp", directory: "/Users/sharan/llvm-project/build/lib/tests")
!7 = !{}
!8 = !{!"Apple clang version 11.0.0 (clang-1100.0.33.17)"}
!9 = distinct !DISubprogram(name: "foo", linkageName: "_Z3foov", scope: !10, file: !10, line: 3, type: !11, scopeLine: 3, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !5, retainedNodes: !7)
!10 = !DIFile(filename: "./test5.cpp", directory: "/Users/sharan/llvm-project/build/lib/tests")
!11 = !DISubroutineType(types: !12)
!12 = !{null}
!13 = !DILocalVariable(name: "a", scope: !9, file: !10, line: 4, type: !14)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 32000000, elements: !16)
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !{!17, !17, !17}
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
!36 = !DILocalVariable(name: "k", scope: !37, file: !10, line: 8, type: !15)
!37 = distinct !DILexicalBlock(scope: !38, file: !10, line: 8, column: 7)
!38 = distinct !DILexicalBlock(scope: !33, file: !10, line: 7, column: 34)
!39 = !DILocation(line: 8, column: 16, scope: !37)
!40 = !DILocation(line: 8, column: 12, scope: !37)
!41 = !DILocation(line: 8, column: 23, scope: !42)
!42 = distinct !DILexicalBlock(scope: !37, file: !10, line: 8, column: 7)
!43 = !DILocation(line: 8, column: 25, scope: !42)
!44 = !DILocation(line: 8, column: 7, scope: !37)
!45 = !DILocation(line: 9, column: 38, scope: !46)
!46 = distinct !DILexicalBlock(scope: !42, file: !10, line: 8, column: 36)
!47 = !DILocation(line: 9, column: 36, scope: !46)
!48 = !DILocation(line: 9, column: 41, scope: !46)
!49 = !DILocation(line: 9, column: 43, scope: !46)
!50 = !DILocation(line: 9, column: 49, scope: !46)
!51 = !DILocation(line: 9, column: 56, scope: !46)
!52 = !DILocation(line: 9, column: 54, scope: !46)
!53 = !DILocation(line: 9, column: 59, scope: !46)
!54 = !DILocation(line: 9, column: 62, scope: !46)
!55 = !DILocation(line: 9, column: 52, scope: !46)
!56 = !DILocation(line: 9, column: 69, scope: !46)
!57 = !DILocation(line: 9, column: 71, scope: !46)
!58 = !DILocation(line: 9, column: 67, scope: !46)
!59 = !DILocation(line: 9, column: 77, scope: !46)
!60 = !DILocation(line: 9, column: 80, scope: !46)
!61 = !DILocation(line: 9, column: 65, scope: !46)
!62 = !DILocation(line: 9, column: 11, scope: !46)
!63 = !DILocation(line: 9, column: 13, scope: !46)
!64 = !DILocation(line: 9, column: 9, scope: !46)
!65 = !DILocation(line: 9, column: 19, scope: !46)
!66 = !DILocation(line: 9, column: 21, scope: !46)
!67 = !DILocation(line: 9, column: 27, scope: !46)
!68 = !DILocation(line: 9, column: 29, scope: !46)
!69 = !DILocation(line: 9, column: 34, scope: !46)
!70 = !DILocation(line: 10, column: 38, scope: !46)
!71 = !DILocation(line: 10, column: 36, scope: !46)
!72 = !DILocation(line: 10, column: 41, scope: !46)
!73 = !DILocation(line: 10, column: 43, scope: !46)
!74 = !DILocation(line: 10, column: 49, scope: !46)
!75 = !DILocation(line: 10, column: 52, scope: !46)
!76 = !DILocation(line: 10, column: 11, scope: !46)
!77 = !DILocation(line: 10, column: 13, scope: !46)
!78 = !DILocation(line: 10, column: 9, scope: !46)
!79 = !DILocation(line: 10, column: 19, scope: !46)
!80 = !DILocation(line: 10, column: 21, scope: !46)
!81 = !DILocation(line: 10, column: 27, scope: !46)
!82 = !DILocation(line: 10, column: 29, scope: !46)
!83 = !DILocation(line: 10, column: 34, scope: !46)
!84 = !DILocation(line: 11, column: 7, scope: !46)
!85 = !DILocation(line: 8, column: 32, scope: !42)
!86 = !DILocation(line: 8, column: 7, scope: !42)
!87 = distinct !{!87, !44, !88}
!88 = !DILocation(line: 11, column: 7, scope: !37)
!89 = !DILocation(line: 12, column: 5, scope: !38)
!90 = !DILocation(line: 7, column: 30, scope: !33)
!91 = !DILocation(line: 7, column: 5, scope: !33)
!92 = distinct !{!92, !35, !93}
!93 = !DILocation(line: 12, column: 5, scope: !28)
!94 = !DILocation(line: 13, column: 3, scope: !29)
!95 = !DILocation(line: 6, column: 28, scope: !24)
!96 = !DILocation(line: 6, column: 3, scope: !24)
!97 = distinct !{!97, !26, !98}
!98 = !DILocation(line: 13, column: 3, scope: !20)
!99 = !DILocation(line: 14, column: 1, scope: !9)
!100 = distinct !DISubprogram(name: "main", scope: !10, file: !10, line: 16, type: !101, scopeLine: 16, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !5, retainedNodes: !7)
!101 = !DISubroutineType(types: !102)
!102 = !{!15}
!103 = !DILocation(line: 16, column: 16, scope: !100)
