require("plover").start()

configWatcher = hs.pathwatcher.new(hs.configdir, function()
  hs.reload()
end):start()
