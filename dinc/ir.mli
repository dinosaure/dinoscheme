type global = { ctxt: Llvm.llcontext;
                modl: Llvm.llmodule;
                bldr: Llvm.llbuilder; }

val init: string -> global
val eval: string -> Closure.t -> unit
