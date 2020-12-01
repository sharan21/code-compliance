add_llvm_library( pointerAlias MODULE BUILDTREE_ONLY
  pointerAlias.cpp

  DEPENDS
  intrinsics_gen
  PLUGIN_TOOL
  opt
  )
