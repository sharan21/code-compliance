; ModuleID = './test4.cpp'
source_filename = "./test4.cpp"
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

; <label>:5:                                      ; preds = %73, %0
  %6 = load i32, i32* %2, align 4, !dbg !23
  %7 = icmp slt i32 %6, 10, !dbg !25
  br i1 %7, label %8, label %76, !dbg !26

; <label>:8:                                      ; preds = %5
  call void @llvm.dbg.declare(metadata i32* %3, metadata !27, metadata !DIExpression()), !dbg !30
  store i32 0, i32* %3, align 4, !dbg !30
  br label %9, !dbg !31

; <label>:9:                                      ; preds = %69, %8
  %10 = load i32, i32* %3, align 4, !dbg !32
  %11 = icmp slt i32 %10, 10, !dbg !34
  br i1 %11, label %12, label %72, !dbg !35

; <label>:12:                                     ; preds = %9
  call void @llvm.dbg.declare(metadata i32* %4, metadata !36, metadata !DIExpression()), !dbg !39
  store i32 0, i32* %4, align 4, !dbg !39
  br label %13, !dbg !40

; <label>:13:                                     ; preds = %65, %12
  %14 = load i32, i32* %4, align 4, !dbg !41
  %15 = icmp slt i32 %14, 10, !dbg !43
  br i1 %15, label %16, label %68, !dbg !44

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
  %28 = add nsw i32 %27, 1, !dbg !51
  %29 = load i32, i32* %2, align 4, !dbg !52
  %30 = add nsw i32 %29, 70, !dbg !53
  %31 = sext i32 %30 to i64, !dbg !54
  %32 = getelementptr inbounds [100 x [100 x [100 x i32]]], [100 x [100 x [100 x i32]]]* %1, i64 0, i64 %31, !dbg !54
  %33 = load i32, i32* %3, align 4, !dbg !55
  %34 = add nsw i32 %33, 69, !dbg !56
  %35 = sext i32 %34 to i64, !dbg !54
  %36 = getelementptr inbounds [100 x [100 x i32]], [100 x [100 x i32]]* %32, i64 0, i64 %35, !dbg !54
  %37 = load i32, i32* %4, align 4, !dbg !57
  %38 = add nsw i32 %37, 1, !dbg !58
  %39 = sext i32 %38 to i64, !dbg !54
  %40 = getelementptr inbounds [100 x i32], [100 x i32]* %36, i64 0, i64 %39, !dbg !54
  store i32 %28, i32* %40, align 4, !dbg !59
  %41 = load i32, i32* %2, align 4, !dbg !60
  %42 = sext i32 %41 to i64, !dbg !61
  %43 = getelementptr inbounds [100 x [100 x [100 x i32]]], [100 x [100 x [100 x i32]]]* %1, i64 0, i64 %42, !dbg !61
  %44 = load i32, i32* %3, align 4, !dbg !62
  %45 = add nsw i32 %44, 87, !dbg !63
  %46 = sext i32 %45 to i64, !dbg !61
  %47 = getelementptr inbounds [100 x [100 x i32]], [100 x [100 x i32]]* %43, i64 0, i64 %46, !dbg !61
  %48 = load i32, i32* %4, align 4, !dbg !64
  %49 = sext i32 %48 to i64, !dbg !61
  %50 = getelementptr inbounds [100 x i32], [100 x i32]* %47, i64 0, i64 %49, !dbg !61
  %51 = load i32, i32* %50, align 4, !dbg !61
  %52 = add nsw i32 %51, 2, !dbg !65
  %53 = load i32, i32* %2, align 4, !dbg !66
  %54 = add nsw i32 %53, 80, !dbg !67
  %55 = sext i32 %54 to i64, !dbg !68
  %56 = getelementptr inbounds [100 x [100 x [100 x i32]]], [100 x [100 x [100 x i32]]]* %1, i64 0, i64 %55, !dbg !68
  %57 = load i32, i32* %3, align 4, !dbg !69
  %58 = add nsw i32 %57, 89, !dbg !70
  %59 = sext i32 %58 to i64, !dbg !68
  %60 = getelementptr inbounds [100 x [100 x i32]], [100 x [100 x i32]]* %56, i64 0, i64 %59, !dbg !68
  %61 = load i32, i32* %4, align 4, !dbg !71
  %62 = add nsw i32 %61, 3, !dbg !72
  %63 = sext i32 %62 to i64, !dbg !68
  %64 = getelementptr inbounds [100 x i32], [100 x i32]* %60, i64 0, i64 %63, !dbg !68
  store i32 %52, i32* %64, align 4, !dbg !73
  br label %65, !dbg !74

; <label>:65:                                     ; preds = %16
  %66 = load i32, i32* %4, align 4, !dbg !75
  %67 = add nsw i32 %66, 1, !dbg !75
  store i32 %67, i32* %4, align 4, !dbg !75
  br label %13, !dbg !76, !llvm.loop !77

; <label>:68:                                     ; preds = %13
  br label %69, !dbg !79

; <label>:69:                                     ; preds = %68
  %70 = load i32, i32* %3, align 4, !dbg !80
  %71 = add nsw i32 %70, 1, !dbg !80
  store i32 %71, i32* %3, align 4, !dbg !80
  br label %9, !dbg !81, !llvm.loop !82

; <label>:72:                                     ; preds = %9
  br label %73, !dbg !84

; <label>:73:                                     ; preds = %72
  %74 = load i32, i32* %2, align 4, !dbg !85
  %75 = add nsw i32 %74, 1, !dbg !85
  store i32 %75, i32* %2, align 4, !dbg !85
  br label %5, !dbg !86, !llvm.loop !87

; <label>:76:                                     ; preds = %5
  ret void, !dbg !89
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline norecurse nounwind optnone ssp uwtable
define i32 @main() #2 !dbg !90 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  ret i32 0, !dbg !93
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
!6 = !DIFile(filename: "test4.cpp", directory: "/Users/sharan/llvm-project/build/lib/tests")
!7 = !{}
!8 = !{!"Apple clang version 11.0.0 (clang-1100.0.33.17)"}
!9 = distinct !DISubprogram(name: "foo", linkageName: "_Z3foov", scope: !10, file: !10, line: 3, type: !11, scopeLine: 3, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !5, retainedNodes: !7)
!10 = !DIFile(filename: "./test4.cpp", directory: "/Users/sharan/llvm-project/build/lib/tests")
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
!51 = !DILocation(line: 9, column: 52, scope: !46)
!52 = !DILocation(line: 9, column: 11, scope: !46)
!53 = !DILocation(line: 9, column: 13, scope: !46)
!54 = !DILocation(line: 9, column: 9, scope: !46)
!55 = !DILocation(line: 9, column: 19, scope: !46)
!56 = !DILocation(line: 9, column: 21, scope: !46)
!57 = !DILocation(line: 9, column: 27, scope: !46)
!58 = !DILocation(line: 9, column: 29, scope: !46)
!59 = !DILocation(line: 9, column: 34, scope: !46)
!60 = !DILocation(line: 10, column: 38, scope: !46)
!61 = !DILocation(line: 10, column: 36, scope: !46)
!62 = !DILocation(line: 10, column: 41, scope: !46)
!63 = !DILocation(line: 10, column: 43, scope: !46)
!64 = !DILocation(line: 10, column: 49, scope: !46)
!65 = !DILocation(line: 10, column: 52, scope: !46)
!66 = !DILocation(line: 10, column: 11, scope: !46)
!67 = !DILocation(line: 10, column: 13, scope: !46)
!68 = !DILocation(line: 10, column: 9, scope: !46)
!69 = !DILocation(line: 10, column: 19, scope: !46)
!70 = !DILocation(line: 10, column: 21, scope: !46)
!71 = !DILocation(line: 10, column: 27, scope: !46)
!72 = !DILocation(line: 10, column: 29, scope: !46)
!73 = !DILocation(line: 10, column: 34, scope: !46)
!74 = !DILocation(line: 11, column: 7, scope: !46)
!75 = !DILocation(line: 8, column: 32, scope: !42)
!76 = !DILocation(line: 8, column: 7, scope: !42)
!77 = distinct !{!77, !44, !78}
!78 = !DILocation(line: 11, column: 7, scope: !37)
!79 = !DILocation(line: 12, column: 5, scope: !38)
!80 = !DILocation(line: 7, column: 30, scope: !33)
!81 = !DILocation(line: 7, column: 5, scope: !33)
!82 = distinct !{!82, !35, !83}
!83 = !DILocation(line: 12, column: 5, scope: !28)
!84 = !DILocation(line: 13, column: 3, scope: !29)
!85 = !DILocation(line: 6, column: 28, scope: !24)
!86 = !DILocation(line: 6, column: 3, scope: !24)
!87 = distinct !{!87, !26, !88}
!88 = !DILocation(line: 13, column: 3, scope: !20)
!89 = !DILocation(line: 14, column: 1, scope: !9)
!90 = distinct !DISubprogram(name: "main", scope: !10, file: !10, line: 16, type: !91, scopeLine: 16, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !5, retainedNodes: !7)
!91 = !DISubroutineType(types: !92)
!92 = !{!15}
!93 = !DILocation(line: 16, column: 16, scope: !90)
