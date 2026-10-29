local M = {}

local plover = "/Applications/Plover.app/Contents/MacOS/Plover"

-- Leader: modifiers + key. Ctrl+Q was swallowed by Plover, so this uses F9.
local LEADER_MODS = {}
local LEADER_KEY = "f9"

-- Keys pressed after the leader (no modifiers)
local KEYS = {
  toggle = "1",
  resume = "2",
  suspend = "3",
}

local function ploverCmd(cmd)
  hs.task.new(plover, nil, { "-s", "plover_send_command", cmd }):start()
end

function M.start()
  local mode = hs.hotkey.modal.new(LEADER_MODS, LEADER_KEY)

  function mode:entered()
    hs.alert.show("Plover: 1 toggle / 2 on / 3 off", 1)
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

  mode:bind({}, KEYS.toggle, run("toggle", "Plover toggled"))
  mode:bind({}, KEYS.resume, run("resume", "Plover on"))
  mode:bind({}, KEYS.suspend, run("suspend", "Plover off"))
  mode:bind({}, "escape", function() mode:exit() end)
end

return M
