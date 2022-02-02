.upd.callbacks:([tab:`$()]func:`$());

registerCallback:{[t;f]
  `.upd.callbacks upsert (t;f);
  .log.out (string f)," registered as callback for ",(string t)
 };

applyCallback:{[t;x]
  (value first .upd.callbacks t)[t;x]
 };

upd:applyCallback;
