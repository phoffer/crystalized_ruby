# I think this was to help figuring out callbacks for parsing hashes?
lib LibTicker
  fun on_tick(callback : (Int32, Void* ->), data : Void*)
end
module Ticker
  # The callback for the user doesn't have a Void*
  def self.on_tick(&callback : Int32 ->)
    # We must save this in Crystal-land so the GC doesn't collect it (*)
    @@callback = callback

    # Since Proc is a {Void*, Void*}, we can't turn that into a Void*, so we
    # "box" it: we allocate memory and store the Proc there
    boxed_data = Box.box(callback)

    # We pass a callback that doesn't form a closure, and pass the boxed_data as
    # the callback data
    LibTicker.on_tick(->(tick, data) {
      # Now we turn data back into the Proc, using Box.unbox
      data_as_callback = Box(typeof(callback)).unbox(data)
      # And finally invoke the user's callback
      data_as_callback.call(tick)
    }, boxed_data)
  end
end
Ticker.on_tick do |tick|
  puts tick
end
