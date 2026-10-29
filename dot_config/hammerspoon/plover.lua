local M = {}

local plover = "/Applications/Plover.app/Contents/MacOS/Plover"

-- Leader: Cmd+Esc, then the follow-up key within the timeout
local LEADER_MODS = { "cmd" }
local LEADER_KEY = "escape"
local TOGGLE_KEY = "`"
local TIMEOUT = 2 -- seconds

local function ploverCmd(cmd)
  hs.task.new(plover, nil, { "-s", "plover_send_command", cmd }):start()
end

function M.start()
  local mode = hs.hotkey.modal.new(LEADER_MODS, LEADER_KEY)

  function mode:entered()
    hs.alert.show("Plover: ` to toggle", 1)
    self.timer = hs.timer.doAfter(TIMEOUT, function() self:exit() end)
  end

  function mode:exited()
    if self.timer then self.timer:stop() end
  end

  mode:bind({}, TOGGLE_KEY, function()
    mode:exit()
    ploverCmd("toggle")
    hs.alert.show("Plover toggled", 0.7)
  end)

  mode:bind({}, "escape", function() mode:exit() end)
end

return M
