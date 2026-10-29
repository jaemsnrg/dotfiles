local M = {}

local plover = "/Applications/Plover.app/Contents/MacOS/Plover"

local function ploverCmd(cmd)
  hs.task.new(plover, nil, { "-s", "plover_send_command", cmd }):start()
end

function M.start()
  local mode = hs.hotkey.modal.new({ "ctrl" }, "q")

  function mode:entered()
    hs.alert.show("Plover: t/r/s", 1)
    self.timer = hs.timer.doAfter(2, function() self:exit() end)
  end

  function mode:exited()
    if self.timer then self.timer:stop() end
  end

  local function run(cmd, msg)
    return function()
      mode:exit()
      ploverCmd(cmd)
      hs.alert.show(msg)
    end
  end

  mode:bind({}, "t", run("toggle", "Plover toggled"))
  mode:bind({}, "r", run("resume", "Plover on"))
  mode:bind({}, "s", run("suspend", "Plover off"))
  mode:bind({}, "escape", function() mode:exit() end)
end

return M
