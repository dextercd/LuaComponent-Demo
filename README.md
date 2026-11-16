LuaComponents are tricky

Demonstrates:

* The script runs in its own Lua context which is shared between `LuaComponent`/entities,
  and that means the `counter` variable is shared too.
* The script gets loaded when its callback is first invoked,
  not when the entity with the script is loaded.
* `GetUpdatedComponentID()` returns zero when a script is loaded but `GetUpdatedEntityID()` does not.
  (Weird. I wouldn't make use of that fact, since you should just call the function in the callbacks. If you must use `execute_every_n_frame`/`execute_on_added`/`execute_on_removed` then that complicates this guidance though).

Perhaps additional demos will be added to demonstrate these facts:

* `vm_type` causes multiple Lua contexts to be allocated for the same script, but it only affects `script_source_file`. Other `script_*` fields are unaffected.
* How `script_source_file` (>0, -1) works.
* `enable_coroutines` just causes the `wake_up_waiting_threads()` callback to be run every frame.
  It doesn't force you to use `data/scripts/lib/coroutines.lua`.
  You can use this as a more convenient callback than `execute_every_n_frame=1`,
  which reruns the main chunk.
* When one `LuaComponent` callback triggers another callback,
  after that callback returns `GetUpdatedComponentID()` will return 0 and also breaks the component variable functions
  (`{Set,Get}Value{Number,Integer,Bool}`, e.g., `SetValueNumber`, `GetValueBool`).

  This is why you should call these functions at the top of the callback, if possible,
  or avoid invoking other callbacks.

  A simple way to cause this to happen is to damage an entity in your callback.
  If that entity has a damage script then that will be invoked.
